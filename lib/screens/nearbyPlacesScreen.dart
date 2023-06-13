import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/functions/nearbySearchFunctions.dart';
import '/functions/trackScreenFunctions.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import '/language/localization_service.dart';
import '/models/placesNearbyDataModel.dart';
import '/widgets/Header.dart';
import '/widgets/buttons/helpButton.dart';
import '/widgets/nearbyPlaceInfoCard.dart';
import 'package:logger/logger.dart';
import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class NearbyPlacesScreen extends StatefulWidget {
  final List gpsData;
  final String? TruckNo;
  final int? deviceId;
  var truckId;
  var placeOnTheMapTag;
  var placeOnTheMapName;

  NearbyPlacesScreen(
      {required this.gpsData,
      required this.placeOnTheMapTag,
      required this.placeOnTheMapName,
      // required this.position,
      this.TruckNo,
      this.deviceId,
      this.truckId});

  @override
  _NearbyPlacesScreenState createState() => _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends State<NearbyPlacesScreen>
    with WidgetsBindingObserver {
  Map<PolylineId, Polyline> polylines = {};
  late GoogleMapController _googleMapController;
  late LatLng lastlatLngMarker =
      LatLng(widget.gpsData.last.latitude, widget.gpsData.last.longitude);
  late BitmapDescriptor pinLocationIconTruck;
  late BitmapDescriptor pinLocationIconPlace;
  late CameraPosition camPosition =
      CameraPosition(target: lastlatLngMarker, zoom: 8);
  var logger = Logger();
  List<Marker> customMarkers = [];
  Completer<GoogleMapController> _controller = Completer();
  late List newGPSData = widget.gpsData;
  MapUtil mapUtil = MapUtil();
  PolylinePoints polylinePoints = PolylinePoints();
  // String googleAPiKey = FlutterConfig.get("mapKey");
  String googleAPiKey = dotenv.get('mapKey');

  late Uint8List markerIcon;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 1)), end: DateTime.now());
  var direction;
  var maptype = MapType.normal;
  double zoom = 10;
  bool showBottomMenu = true;
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  late String from;
  late String to;
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  late Set<Circle> circles;
  PlacesNearbyData _placesNearbyData = new PlacesNearbyData();
  late Timer timer;
  final circleId =
      CircleId('circle_id_${DateTime.now().millisecondsSinceEpoch}');
  PolylinePoints polylinePointsForDistance = PolylinePoints();
  Set<Marker> markersForDistance = Set();
  late LatLng startLocationForDistance;
  late LatLng endLocationForDistance;

  double pinPillPosition = -100;
  int placesIndex = 0;
  String currentLanguage = "en";

  Future<void> callApi(double lat, double lon) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
            lat.toString() +
            "," +
            lon.toString() +
            "&radius=15000&types=" +
            widget.placeOnTheMapTag +
            "&language=" +
            currentLanguage +
            "&key=" +
            googleAPiKey);

    var response = await http.get(url);
    if (response != null) EasyLoading.dismiss();
    var body = response.body;
    _placesNearbyData = PlacesNearbyData.fromJson(jsonDecode(body));

    startLocationForDistance = LatLng(lat, lon);

    FutureGroup futureGroup = FutureGroup();
    if (_placesNearbyData.results != null)
      for (int i = 0; i < _placesNearbyData.results!.length; i++) {
        var future = markNearbyPlaces(_placesNearbyData.results![i], i);
        endLocationForDistance = LatLng(
            _placesNearbyData.results![i].geometry!.location!.lat!.toDouble(),
            _placesNearbyData.results![i].geometry!.location!.lng!.toDouble());
        futureGroup.add(future);
        getDirections(i);
      }

    futureGroup.close();
    await futureGroup.future;
  }

  @override
  void initState() {
    super.initState();

    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..maskColor = darkBlueColor
      ..userInteractions = false
      ..backgroundColor = darkBlueColor
      ..dismissOnTap = false;
    EasyLoading.show(
      status: "Loading...",
    );

    WidgetsBinding.instance.addObserver(this);
    from = yesterday.toIso8601String();
    to = now.toIso8601String();
    circles = Set.from([
      Circle(
        circleId: circleId,
        center:
            LatLng(widget.gpsData.last.latitude, widget.gpsData.last.longitude),
        radius: 1000,
        fillColor: Color.fromRGBO(17, 255, 169, 0.28),
        strokeColor: Color.fromRGBO(17, 255, 169, 0.28),
        strokeWidth: 2,
      )
    ]);
    try {
      initfunction2();
      iconthenmarker();

      currentLanguage =
          (LocalizationService().getCurrentLang() == 'Hindi') ? "hi" : "en";
      callApi(
        widget.gpsData.last.latitude,
        widget.gpsData.last.longitude,
      );
      lastlatLngMarker =
          LatLng(widget.gpsData.last.latitude, widget.gpsData.last.longitude);
      camPosition = CameraPosition(target: lastlatLngMarker, zoom: zoom);

      timer = Timer.periodic(
          Duration(minutes: 1, seconds: 10), (Timer t) => onActivityExecuted());
    } catch (e) {
      logger.e("Error is $e");
    }
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle("[]");
    _controller.complete(controller);
    _customInfoWindowController.googleMapController = controller;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        final GoogleMapController controller = await _controller.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      default:
        break;
    }
  }

  //function is called every one minute to get updated history

  Future<void> initfunction2() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _googleMapController = controller;
    });
  }

  void initfunctionAfter() async {
    //It is in init function after function
    var f1 = mapUtil.getTraccarPosition(deviceId: widget.deviceId);
    var gpsData = await f1;

    setState(() {
      newGPSData = gpsData;
      selectedDate = DateTimeRange(
          start: DateTime.now().subtract(Duration(days: 1)),
          end: DateTime.now());
    });
  }

  void iconthenmarker() {
    logger.i("in Icon maker function");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icons/truckPin.png')
        .then((value) => {
              setState(() {
                pinLocationIconTruck = value;
              }),
              createmarker()
            });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: kIsWeb ? Size(50,50) :Size(16, 16) ),
            "assets/icons/" + widget.placeOnTheMapTag + "_rounded.png")
        .then((value) => {
              setState(() {
                pinLocationIconPlace = value;
              }),
              createmarker()
            });
  }

  //function called every one minute
  void onActivityExecuted() {
    //It is in Activity Executed function
    initfunctionAfter();
    iconthenmarker();
    customMarkers = [];
    callApi(widget.gpsData.last.latitude, widget.gpsData.last.longitude);
  }

  void createmarker() async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLng latLngMarker =
          LatLng(newGPSData.last.latitude, newGPSData.last.longitude);
      String? title = widget.TruckNo;
      setState(() {
        direction = 180 + newGPSData.last.course;
        lastlatLngMarker =
            LatLng(newGPSData.last.latitude, newGPSData.last.longitude);
        customMarkers.add(Marker(
            markerId: MarkerId(newGPSData.last.deviceId.toString()),
            position: latLngMarker,
            infoWindow: InfoWindow(title: title),
            icon: pinLocationIconTruck,
            rotation: direction));
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(bearing: 0, target: lastlatLngMarker, zoom: 14),
      ));
      this.zoom = 14;

      circles = Set.from([
        Circle(
          circleId: circleId,
          center: LatLng(newGPSData.last.latitude, newGPSData.last.longitude),
          radius: 1000,
          fillColor: Color.fromRGBO(17, 255, 169, 0.28),
          strokeColor: Color.fromRGBO(17, 255, 169, 0.28),
          strokeWidth: 2,
        )
      ]);
    } catch (e) {
      print("Exceptionis $e");
    }
  }

  markNearbyPlaces(Results nearbyPlaces, int i) async {
    double height = MediaQuery.of(context).size.height;
    LatLng latlong;

    latlong = LatLng(nearbyPlaces.geometry!.location!.lat ?? 0,
        nearbyPlaces.geometry!.location!.lng ?? 0);

    markerIcon = await getBytesFromCanvas(i + 1, 100, 100);
    setState(() {
      customMarkers.add(Marker(
          markerId: MarkerId("Stop Mark $i"),
          position: latlong,
          icon: pinLocationIconPlace,
          infoWindow: InfoWindow(title: nearbyPlaces.name),
          onTap: () {
            setState(() {
              pinPillPosition = height / 3 + 24;
              placesIndex = i;
              addPolyLineForTarget(i);
            });
          }));
    });
  }

  getDirections(int index) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocationForDistance.latitude,
          startLocationForDistance.longitude),
      PointLatLng(
          endLocationForDistance.latitude, endLocationForDistance.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }

    setState(() {
      if (_placesNearbyData.results != null)
        _placesNearbyData.results![index].distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates, index);
  }

  addPolyLine(List<LatLng> polylineCoordinates, int index) {
    PolylineId id = PolylineId("poly" + index.toString());
    Polyline polyline = Polyline(
      polylineId: id,
      color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
      points: polylineCoordinates,
      width: 2,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  addPolyLineForTarget(int index) async {
    List<LatLng> polylineCoordinates = [];
    LatLng endLocationForDistanceForTarget = LatLng(
        _placesNearbyData.results![index].geometry!.location!.lat!.toDouble(),
        _placesNearbyData.results![index].geometry!.location!.lng!.toDouble());
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocationForDistance.latitude,
          startLocationForDistance.longitude),
      PointLatLng(endLocationForDistanceForTarget.latitude,
          endLocationForDistanceForTarget.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    PolylineId id = PolylineId("polytarget");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void dispose() {
    logger.i("Activity is disposed");
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    return SafeArea(
      child: Scaffold(
        backgroundColor: statusBarColor,
        body: GestureDetector(
          // onTap: () {
          //   setState(() {
          //     if (!showBottomMenu) showBottomMenu = !showBottomMenu;
          //   });
          // },
          // onPanEnd: (details) {
          //   if (details.velocity.pixelsPerSecond.dy > threshold) {
          //     this.setState(() {
          //       showBottomMenu = false;
          //     });
          //   } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
          //     this.setState(() {
          //       showBottomMenu = true;
          //     });
          //   }
          // },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: -100,
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: <Widget>[
                      GoogleMap(
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
                          setState(() {
                            pinPillPosition = -100;
                          });
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        circles: circles,
                        markers: customMarkers.toSet(),
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: true,
                        initialCameraPosition: camPosition,
                        compassEnabled: true,
                        polylines: Set.from(polylines.values),
                        mapType: maptype,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          _customInfoWindowController.googleMapController =
                              controller;
                        },
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          new Factory<OneSequenceGestureRecognizer>(
                            () => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                      ),
                      CustomInfoWindow(
                        controller: _customInfoWindowController,
                        height: 110,
                        width: 275,
                        offset: 30,
                      ),
                      Positioned(
                        left: 10,
                        top: 175,
                        child: SizedBox(
                          height: 40,
                          child: FloatingActionButton(
                            heroTag: "btn1",
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            child: const Icon(Icons.my_location,
                                size: 22, color: Color(0xFF152968)),
                            onPressed: () {
                              setState(() {
                                this.maptype = (this.maptype == MapType.normal)
                                    ? MapType.satellite
                                    : MapType.normal;
                              });
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: height / 3 + 170,
                        child: SizedBox(
                          height: 40,
                          child: FloatingActionButton(
                            heroTag: "btn2",
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            child: const Icon(Icons.zoom_in,
                                size: 22, color: Color(0xFF152968)),
                            onPressed: () {
                              setState(() {
                                this.zoom = this.zoom + 0.5;
                              });
                              this
                                  ._googleMapController
                                  .animateCamera(CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      bearing: 0,
                                      target: lastlatLngMarker,
                                      zoom: this.zoom,
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: height / 3 + 115,
                        child: SizedBox(
                          height: 40,
                          child: FloatingActionButton(
                            heroTag: "btn3",
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            child: const Icon(Icons.zoom_out,
                                size: 22, color: Color(0xFF152968)),
                            onPressed: () {
                              setState(() {
                                this.zoom = this.zoom - 0.5;
                              });
                              this
                                  ._googleMapController
                                  .animateCamera(CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      bearing: 0,
                                      target: lastlatLngMarker,
                                      zoom: this.zoom,
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                      (_placesNearbyData.results != null)
                          ? NearbyPlaceInfoCard(
                              pinPillPosition: pinPillPosition,
                              placesIndex: placesIndex,
                              placeOnTheMapTag: widget.placeOnTheMapTag,
                              placesNearbyData: _placesNearbyData)
                          : Container(),
                    ])),
              ),
              Positioned(
                  top: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: white,
                      child: Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: space_13,
                          color: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.fromLTRB(space_3, 0, space_3, 0),
                                child: Header(
                                    reset: false,
                                    text: "${widget.TruckNo}",
                                    backButton: true),
                              ),
                              HelpButtonWidget()
                            ],
                          ),
                        ),
                      ]))),
              AnimatedPositioned(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 200),
                left: 0,
                bottom: (showBottomMenu) ? 0 : -(height / 3) + 36,
                child: nearbyPlacesList(height, width),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container nearbyPlacesList(double height, double width) {
    return Container(
        height: height / 3 + 24,
        width: width,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: darkShadow,
                offset: const Offset(
                  0,
                  -5.0,
                ),
                blurRadius: 15.0,
                spreadRadius: 10.0,
              ),
              BoxShadow(
                color: white,
                offset: const Offset(0, 1.0),
                blurRadius: 0.0,
                spreadRadius: 2.0,
              ),
            ]),
        child:
            ListView(physics: const NeverScrollableScrollPhysics(), children: <
                Widget>[
          Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: const Color(0xFFCBCBCB),
                  // height: size_3,
                  thickness: 3,
                  indent: 150,
                  endIndent: 150,
                ),
                Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.fromLTRB(space_1, space_1, space_1, space_1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        //Row for nearby location name and petrol prices
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/' +
                                      widget.placeOnTheMapTag +
                                      '.png',
                                  height: size_14,
                                  width: size_14,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.placeOnTheMapName,
                                  style: TextStyle(
                                      fontSize: size_10,
                                      fontWeight: boldWeight,
                                      color: darkBlueColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        //Listview of Petrol Pumps nearby with their location
                        Container(
                            height: height / 4 + 24,
                            margin: EdgeInsets.fromLTRB(0, space_1, 0, 0),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                scrollDirection: Axis.vertical,
                                itemCount: (_placesNearbyData.results != null)
                                    ? _placesNearbyData.results?.length
                                    : 0,
                                itemBuilder: (context, index) {
                                  Results here =
                                      _placesNearbyData.results![index];
                                  print("DISTANCE ABCD " +
                                      here.distance.toString());
                                  return Card(
                                      child: InkWell(
                                    onTap: () {
                                      this._googleMapController.animateCamera(
                                              CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              bearing: 0,
                                              target: LatLng(
                                                  here.geometry!.location!.lat!,
                                                  here.geometry!.location!
                                                      .lng!),
                                              zoom: this.zoom,
                                            ),
                                          ));
                                    },
                                    child: ListTile(
                                        title: Text(
                                          here.name.toString(),
                                          style: TextStyle(
                                              fontSize: size_7,
                                              fontWeight: mediumBoldWeight,
                                              color: darkBlueColor),
                                        ),
                                        subtitle: Text(
                                          here.vicinity.toString(),
                                          style: TextStyle(
                                            fontSize: size_6,
                                            fontWeight: mediumBoldWeight,
                                          ),
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                openMap(here
                                                        .geometry!.location!.lat
                                                        .toString() +
                                                    ',' +
                                                    here.geometry!.location!.lng
                                                        .toString());
                                              },
                                              child: Image.asset(
                                                'assets/icons/navigateIcon.png',
                                                height: size_14,
                                                width: size_14,
                                              ),
                                            ),
                                            Text(
                                              here.distance!
                                                      .toStringAsFixed(1) +
                                                  " km",
                                              style: TextStyle(
                                                  fontSize: size_5,
                                                  fontWeight: mediumBoldWeight,
                                                  color: darkBlueColor),
                                            ),
                                          ],
                                        )),
                                  ));
                                })),
                      ],
                    )),
              ]),
        ]));
  }
}
