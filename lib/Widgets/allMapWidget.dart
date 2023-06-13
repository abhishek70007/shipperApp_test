import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import '/controller/trucksNearUserController.dart';
import '/models/deviceModel.dart';
import '/models/gpsDataModel.dart';
import '/models/truckModel.dart';
import '/functions/trackScreenFunctions.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import '/widgets/alertDialog/userNearLocationSelectionDialog.dart';
import '/widgets/truckInfoWindow.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';
import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AllMapWidget extends StatefulWidget {
  List gpsDataList;
  List truckDataList;
  List status;

  AllMapWidget(
      {required this.gpsDataList,
        required this.truckDataList,
        required this.status});

  @override
  _AllMapWidgetState createState() => _AllMapWidgetState();
}

class _AllMapWidgetState extends State<AllMapWidget>
    with WidgetsBindingObserver {
  late GoogleMapController _googleMapController;
  late LatLng lastlatLngMarker = LatLng(28.5673, 77.3211);
  late List<Placemark> placemarks;
  Iterable markers = [];
  ScreenshotController screenshotController = ScreenshotController();
  late BitmapDescriptor pinLocationIconGreyTruck;
  late BitmapDescriptor pinLocationIconGreenTruck;
  late BitmapDescriptor pinLocationIconRedTruck;
  late CameraPosition camPosition =
  CameraPosition(target: lastlatLngMarker, zoom: 4.5);
  var logger = Logger();
  bool showdetails = false;
  late Marker markernew;
  List<Marker> customMarkers = [];
  late Timer timer;
  Completer<GoogleMapController> _controller = Completer();
  late List newGPSData;
  late List reversedList;
  late List oldGPSData;
  MapUtil mapUtil = MapUtil();
  List<LatLng> latlng = [];
  // String googleAPiKey = FlutterConfig.get("mapKey");
  String googleAPiKey = dotenv.get('mapKey');
  bool popUp = false;
  late Uint8List markerIcon;
  var markerslist;
  // GpsDataModel positionData=GpsDataModel();
  // var speed=positionData.speed!.toString();

  //CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  CustomInfoWindowController _customDetailsInfoWindowController =
  CustomInfoWindowController();
  bool isAnimation = false;
  double mapHeight = 600;
  var direction;
  var maptype = MapType.normal;
  double zoom = 4.5;

  // TrucksNearUserController trucksNearUserController =
  //     Get.put(TrucksNearUserController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    iconthenmarker();
    initfunction2();
    try {
      timer = Timer.periodic(
          Duration(minutes: 1, seconds: 10), (Timer t) => onActivityExecuted());
    } catch (e) {
      logger.e("Error is $e");
    }
    // var customGpsDataList = widget.gpsDataList;
    // var customDeviceList = widget.deviceList;
    // var customRunningDataList = widget.runningDataList;
    // var customRunningGpsDataList = widget.runningGpsDataList;
    // var customStoppedList = widget.stoppedList;
    // var customStoppedGpsList = widget.stoppedGpsList;
    // _getCurrentLocation();
  }

  Future<void> initfunction2() async {
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _googleMapController = controller;
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle("[]");

    _controller.complete(controller);

    // _customInfoWindowController.googleMapController = controller;
    _customDetailsInfoWindowController.googleMapController = controller;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        final GoogleMapController controller = await _controller.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.paused:
        print('appLifeCycleState paused');
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }

  //function called every one minute
  void onActivityExecuted() {
    logger.i("It is in Activity Executed function");

    iconthenmarker();
  }

  void iconthenmarker() {
    var greyImg = 'assets/icons/truckPinGrey.png';
    logger.i("in Icon maker function");
    for (int i = 0; i < widget.gpsDataList.length; i++) {
      if (widget.status[i].toString() == "Offline") {
        print("speed grey ${widget.gpsDataList[i].speed!}");
        BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), greyImg)
            .then((value) => {
          setState(() {
            pinLocationIconGreyTruck = value;
          }),
          print("working grey"),
          createmarkerGrey(
              widget.gpsDataList[i], widget.truckDataList[i]),
        });
      } else {
        if (widget.status[i].toString() == "Online" &&
            widget.gpsDataList[i].speed! >= 5) {
          print("speed green ${widget.gpsDataList[i].speed!}");
          BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              'assets/icons/truckPinGreen.png')
              .then((value) => {
            setState(() {
              pinLocationIconGreenTruck = value;
            }),
            print("working green"),
            createmarkerGreen(
                widget.gpsDataList[i], widget.truckDataList[i]),
          });
        } else if (widget.status[i].toString() == "Online" &&
            widget.gpsDataList[i].speed! < 5) {
          print("speed red ${widget.gpsDataList[i].speed!}");
          BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 2.5),
              'assets/icons/truckPinRed.png')
              .then((value) => {
            setState(() {
              pinLocationIconRedTruck = value;
            }),
            print("working red"),
            createmarkerRed(
                widget.gpsDataList[i], widget.truckDataList[i]),
          });
        }
      }
    }
  }

  void createmarkerGrey(GpsDataModel gpsData, var truck) async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLng latLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
      print("Live location is  ${gpsData.latitude}");
      print("hh");
      print(gpsData.deviceId.toString());
      String? title = truck;
      var markerIcons = await getBytesFromCanvas3(truck!, 100, 100);
      var address = await getAddress(gpsData);
      var trucklatlong = latLngMarker;
      setState(() {
        direction = 180 + gpsData.course!;
        lastlatLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
        latlng.add(lastlatLngMarker);
        customMarkers.add(Marker(
            markerId: MarkerId(gpsData.deviceId.toString()),
            position: trucklatlong,
            onTap: () {
              _customDetailsInfoWindowController.addInfoWindow!(
                truckInfoWindow(truck, address),
                trucklatlong,
              );
            },
            infoWindow: InfoWindow(
              //   title: title,
                onTap: () {}),
            icon: pinLocationIconGreyTruck,
            rotation: direction));
        print("here i am");
        customMarkers.add(Marker(
            markerId: MarkerId("Details of ${gpsData.deviceId.toString()}"),
            position: latLngMarker,
            icon: BitmapDescriptor.fromBytes(markerIcons),
            rotation: 0.0));
      });
      print("done");
      //   controller.showMarkerInfoWindow(MarkerId(gpsData.last.deviceId.toString()));
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(28.5673, 77.3211),
          zoom: zoom,
        ),
      ));
    } catch (e) {
      print("Exceptionis $e");
    }
  }

  void createmarkerGreen(GpsDataModel gpsData, var truck) async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLng latLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
      print("Live location is  ${gpsData.latitude}");
      print("hh");
      print(gpsData.deviceId.toString());
      String? title = truck;
      var markerIcons = await getBytesFromCanvas3(truck!, 100, 100);
      var address = await getAddress(gpsData);
      var trucklatlong = latLngMarker;
      setState(() {
        direction = 180 + gpsData.course!;
        lastlatLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
        latlng.add(lastlatLngMarker);
        customMarkers.add(Marker(
            markerId: MarkerId(gpsData.deviceId.toString()),
            position: trucklatlong,
            onTap: () {
              _customDetailsInfoWindowController.addInfoWindow!(
                truckInfoWindow(truck, address),
                trucklatlong,
              );
            },
            infoWindow: InfoWindow(
              //   title: title,
                onTap: () {}),
            icon: pinLocationIconGreenTruck,
            rotation: direction));
        print("here i am");
        customMarkers.add(Marker(
            markerId: MarkerId("Details of ${gpsData.deviceId.toString()}"),
            position: latLngMarker,
            icon: BitmapDescriptor.fromBytes(markerIcons),
            rotation: 0.0));
      });
      print("done");
      //   controller.showMarkerInfoWindow(MarkerId(gpsData.last.deviceId.toString()));
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(28.5673, 77.3211),
          zoom: zoom,
        ),
      ));
    } catch (e) {
      print("Exceptionis $e");
    }
  }

  void createmarkerRed(GpsDataModel gpsData, var truck) async {
    try {
      final GoogleMapController controller = await _controller.future;
      LatLng latLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
      print("Live location is  ${gpsData.latitude}");
      print("hh");
      print(gpsData.deviceId.toString());
      String? title = truck;
      var markerIcons = await getBytesFromCanvas3(truck!, 100, 100);
      var address = await getAddress(gpsData);
      var trucklatlong = latLngMarker;
      setState(() {
        direction = 180 + gpsData.course!;
        lastlatLngMarker = LatLng(gpsData.latitude!, gpsData.longitude!);
        latlng.add(lastlatLngMarker);
        customMarkers.add(Marker(
            markerId: MarkerId(gpsData.deviceId.toString()),
            position: trucklatlong,
            onTap: () {
              _customDetailsInfoWindowController.addInfoWindow!(
                truckInfoWindow(truck, address),
                trucklatlong,
              );
            },
            infoWindow: InfoWindow(
              //   title: title,
                onTap: () {}),
            icon: pinLocationIconRedTruck,
            rotation: direction));
        print("here i am");
        customMarkers.add(Marker(
            markerId: MarkerId("Details of ${gpsData.deviceId.toString()}"),
            position: latLngMarker,
            icon: BitmapDescriptor.fromBytes(markerIcons),
            rotation: 0.0));
      });
      print("done");
      //   controller.showMarkerInfoWindow(MarkerId(gpsData.last.deviceId.toString()));
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(28.5673, 77.3211),
          zoom: zoom,
        ),
      ));
    } catch (e) {
      print("Exceptionis $e");
    }
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
    double threshold = 100;

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        body: Stack(children: <Widget>[
          GoogleMap(
            onTap: (position) {
              //   _customInfoWindowController.hideInfoWindow!();
              _customDetailsInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              //   _customInfoWindowController.onCameraMove!();
              _customDetailsInfoWindowController.onCameraMove!();
            },
            markers: customMarkers.toSet(),
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: camPosition,
            compassEnabled: true,
            mapType: maptype,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //   _customInfoWindowController.googleMapController = controller;
              _customDetailsInfoWindowController.googleMapController =
                  controller;
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
          ),
          /*  CustomInfoWindow(
                                controller: _customInfoWindowController,
                                height: 110,
                                width: 275,
                                offset: 0,
                              ),*/
          CustomInfoWindow(
            controller: _customDetailsInfoWindowController,
            height: 140,
            width: 300,
            offset: 0,
          ),
          /*       Positioned(
                                  left: 10,
                                  top: 275,
                                  child: SizedBox(
                                    height: 40,
                                    child: FloatingActionButton(
                                      heroTag: "btn1",
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      child: const Icon(Icons.my_location, size: 22, color: Color(0xFF152968) ),
                                      onPressed: () {
                                        setState(() {
                                          this.maptype=(this.maptype == MapType.normal) ? MapType.satellite : MapType.normal;
                                        });
                                      },
                                    ),
                                  ),
                                ),*/
          Positioned(
            right: 10,
            bottom: height / 3 + 140,
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
            bottom: height / 3 + 90,
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
          // Positioned(
          //   right: 10,
          //   bottom: height / 3 + 40,
          //   child: SizedBox(
          //     height: 40,
          //     child: FloatingActionButton(
          //       heroTag: "btn3",
          //       backgroundColor: Colors.white,
          //       foregroundColor: Colors.black,
          //       child: const Icon(Icons.my_location,
          //           size: 22, color: Color(0xFF152968)),
          //       onPressed: () {
          //         //mapAllTrucksNearUser(20);
          //         setState(() {
          //           //trucksNearUser Controller.updateDistanceRadiusData(16000);
          //           trucksNearUserController.updateNearStatusData(false);

          //           showDialog(
          //                   context: context,
          //                   builder: (context) => UserNearLocationSelection())
          //               .then((value) {
          //             if (value) {
          //               setState(() {});
          //             }
          //           });
          //           print(" kkkkkk ");
          //           print(trucksNearUserController.nearStatus.value);
          //         });
          //       },
          //     ),
          //   ),
          // ),
        ]),
      ),
    );
  }

  getAddress(var gpsData) async {
    var address =
        await getStoppageAddressLatLong(gpsData.latitude, gpsData.longitude);

    return address;
  }

// _getCurrentLocation() {
//   Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best,
//           forceAndroidLocationManager: true)
//       .then((Position position) {
//     setState(() {
//       _currentPosition = position;
//       print(
//           "CURRENT LOCATION IS ${_currentPosition.latitude} AND ${widget.gpsDataList[1].latitude}");
//     });
//   }).catchError((e) {
//     print(e);
//   });
// }

// void mapAllTrucksNearUser() {
//   for (var i = 0; i < widget.gpsDataList.length; i++) {
//     var distanceStore = calculateDistance(
//         widget.gpsDataList[i].latitude,
//         widget.gpsDataList[i].longitude,
//         _currentPosition.latitude,
//         _currentPosition.latitude);
//     if (distanceStore <= trucksNearUserController.distanceRadius.value) {
//       print("TRYINGGGGGG");
//       customGpsDataList[i] = widget.gpsDataList[i];
//       customDeviceList[i] = widget.deviceList[i];
//       customRunningDataList[i] = widget.runningDataList[i];
//       customRunningGpsDataList[i] = widget.runningGpsDataList[i];
//       customStoppedList[i] = widget.stoppedList[i];
//       customStoppedGpsList[i] = widget.stoppedGpsList[i];
//     } else {
//       customGpsDataList[i] = [];
//       customDeviceList[i] = [];
//       customRunningDataList[i] = [];
//       customRunningGpsDataList[i] = [];
//       customStoppedList[i] = [];
//       customStoppedGpsList[i] = [];
//     }
//   }
// }

// double calculateDistance(lat1, lon1, lat2, lon2) {
//   var p = 0.017453292519943295;
//   var c = cos;
//   var a = 0.5 -
//       c((lat2 - lat1) * p) / 2 +
//       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//   return 12742 * asin(sqrt(a));
// }
}
