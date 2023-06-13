// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:geocoder/geocoder.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import '/constants/colors.dart';
// import '/constants/fontSize.dart';
// import '/constants/spaces.dart';
// import '/controller/gpsDataController.dart';
// import '/functions/mapUtils/zoomToFitToCenterBound.dart';
// import '/models/gpsDataModel.dart';
// import '/widgets/buttons/backButtonWidget.dart';
// import 'package:location_permissions/location_permissions.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_config/flutter_config.dart';
// double speed = 10;
// Future<GpsDataModel?> getGpsDataFromApi(int imei) async {
//   print("in compute function with imei: $imei");
//   if (speed > 2) {
//   print("sleep starts");
//   sleep(Duration(seconds: 20));
//   //flutter config is not functional in a different thread
//   print("speed>2");
//   // String gpsApiUrl = "http://3.109.80.120:3000/locationbyimei";
//   final String gpsApiUrl = FlutterConfig.get('gpsApiUrl');
//   try {
//     print("$gpsApiUrl/$imei");
//     http.Response response = await http.get(Uri.parse("$gpsApiUrl/$imei"));
//     print(response.statusCode);
//     print(response.body);
//     var jsonData = await jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       speed = double.parse(jsonData["speed"]);
//       GpsDataModel gpsDataModel = new GpsDataModel();
//       gpsDataModel.imei = jsonData["imei"];
//       gpsDataModel.lat = double.parse(jsonData["lat"]);
//       gpsDataModel.lng = double.parse(jsonData["lng"]);
//       gpsDataModel.speed = jsonData["speed"];
//       gpsDataModel.deviceName = jsonData["deviceName"];
//       gpsDataModel.powerValue = jsonData["powerValue"];
//       gpsDataModel.direction = jsonData["direction"];
//       return gpsDataModel;
//     }
//     else {
//       return null;
//     }
//   } catch (e) {
//     print(e);
//     return null;
//   }
//
//   } else {
//     print("speed < 2");
//     sleep(Duration(seconds: 50));
//
//     return null;
//   }
// }
//
// class ShowMapWithImei extends StatefulWidget {
//   final GpsDataModel gpsData;
//   final Position? userLocation;
//
//   ShowMapWithImei({required this.gpsData, this.userLocation});
//
//   @override
//   _ShowMapWithImeiState createState() => _ShowMapWithImeiState();
// }
//
// class _ShowMapWithImeiState extends State<ShowMapWithImei> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     setCustomMapPin(pinImageLocation: "assets/images/truckAsMarker3x.png", userImageLocation: "assets/images/humanIcon3x.png");
//     getAddress();
//     speed = double.parse(widget.gpsData.speed!);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     shouldRun = false;
//   }
//   GpsDataController gpsDataController = Get.put(GpsDataController());
//   bool shouldRun = true;
//
//   void getGpsDataByImei({String? imei}) async {
//     while (shouldRun) {
//       speed = double.parse(gpsDataController.gpsData.value.speed.toString());
//       var result = await compute(getGpsDataFromApi,
//           int.parse(gpsDataController.gpsData.value.imei.toString()));
//       print("result from compute: $result");
//
//       if (result != null) {
//         print("result from compute, lat: ${result.lat}");
//         print("result != null ");
//         gpsDataController.updateGpsData(result);
//         updateGpsMarker(LatLng(gpsDataController.gpsData.value.lat!,
//             gpsDataController.gpsData.value.lng!));
//       }
//     }
//   }
//
//   String address = "";
//   BitmapDescriptor? pinLocationIcon;
//   BitmapDescriptor? userLocationIcon;
//   Map<PolylineId, Polyline> polylines = {};
//   Set<Marker> markers = {};
//   Position? myLocation;
//   String mapMyIndiaToken = "";
//   Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   GoogleMapController? googleMapController;
//   CameraPosition _initialCameraPosition = CameraPosition(
//     target: LatLng(27, 77),
//     zoom: 14,
//   );
//
//   void updateGpsMarker(LatLng latLng) async {
//     setState(() {
//       markers.add(
//         Marker(
//             markerId: MarkerId("GpsMarker"),
//             rotation: double.parse(gpsDataController.getGpsData().direction!),
//             position: latLng,
//             anchor: Offset(0.5, 0.5),
//             icon: pinLocationIcon!),
//       );
//       // _createPolylines(
//       //   myLocation!,
//       //   Position(
//       //       latitude: latLng.latitude,
//       //       longitude: latLng.longitude),
//       // );
//     });
//   }
//
//   void setCustomMapPin({String? pinImageLocation, String? userImageLocation}) async {
//     pinLocationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(
//             devicePixelRatio: (MediaQuery.of(context).devicePixelRatio)/4),
//         '$pinImageLocation');
//     userLocationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(
//             devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
//         '$userImageLocation');
//   }
//
//   void getAddress() async {
//     // var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(widget.gpsData.lat, widget.gpsData.lng));
//     // List<Placemark> placeMark = await placemarkFromCoordinates(
//     //     widget.gpsData.lat!, widget.gpsData.lat!);
//     // print(placeMark);
//     // var first = placeMark.first;
//     // print(first.name);
//     // if (mapMyIndiaToken == "") {
//     //   mapMyIndiaToken = await getMapMyIndiaToken();
//     // }
//     // used geocoding (instead of directly getting address using lat,lng) bcs rev-geocoding has a limit of 200 and geocoding has 5000 limit per day
//     http.Response response = await http.get(
//       Uri.parse(
//           'https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/rev_geocode?lat=${widget.gpsData.lat}&lng=${widget.gpsData.lng}'),
//     );
//     var adress = jsonDecode(response.body);
//     print(adress);
//     // var street = adress["copResults"]["street"] == null ||
//     //         adress["copResults"]["street"] == ""
//     //     ? ""
//     //     : "${adress["copResults"]["street"]}, ";
//     // var locality = adress["copResults"]["locality"] == null ||
//     //         adress["copResults"]["locality"] == ""
//     //     ? ""
//     //     : "${adress["copResults"]["locality"]}, ";
//     // var cityName = adress["copResults"]["city"];
//     // var stateName = adress["copResults"]["state"];
//     // var street = adress["results"][0]["street"] == null ||
//     //         adress["results"][0]["street"] == ""
//     //     ? ""
//     //     : "${adress["results"][0]["street"]}, ";
//     var locality = adress["results"][0]["locality"] == null ||
//             adress["results"][0]["locality"] == ""
//         ? ""
//         : "${adress["results"][0]["locality"]}, ";
//     var cityName = adress["results"][0]["city"];
//     var stateName = adress["results"][0]["state"];
//     setState(() {
//       address = "$locality$cityName, $stateName";
//     });
//   }
//
//   _createPolylines(LatLng start, LatLng destination) async {
//     String mapKey = FlutterConfig.get("mapKey");
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<LatLng> polylineCoordinates = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       mapKey, // Google Maps API Key
//       PointLatLng(start.latitude, start.longitude),
//       PointLatLng(destination.latitude, destination.longitude),
//       travelMode: TravelMode.transit,
//     );
//     print(result.status);
//     print(result.errorMessage);
//     print(result.points);
//     http.Response response = await http.get(Uri.parse(
//         'https://apis.mapmyindia.com/advancedmaps/v1/5ug2mtejb2urr2zwgdg8l8mh3zdtm2i3/route_adv/driving/${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}'));
//     var body = jsonDecode(response.body);
//     List<PointLatLng> polylinePoint =
//         polylinePoints.decodePolyline(body["routes"][0]["geometry"]);
//     String distanceBetween = body["routes"][0]["distance"].toString();
//     print(distanceBetween);
//     print(polylinePoint);
//     // Adding the coordinates to the list
//     if (polylinePoint.length != 0) {
//       polylinePoint.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 5,
//     );
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }
//
//   void showMarkerAtPosition(LatLng position, String markerID,
//       BitmapDescriptor bitmapDescriptor) async {
//
//     Marker newMarker = Marker(
//       icon: bitmapDescriptor,
//       markerId: MarkerId(markerID),
//         anchor: Offset(0.5, 0.5),
//       position: position
//     );
//     setState(() {
//       markers.add(newMarker);
//     });
//   }
//
//   void getCurrentLocation() async {
//     Position position;
// // setting map position to centre to start with
//     googleMapController!.moveCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(gpsDataController.getGpsData().lat!,
//               gpsDataController.getGpsData().lng!),
//           zoom: 18,
//         ),
//       ),
//     );
//
//     if (widget.userLocation == null) {
//       PermissionStatus permission1 =
//           await LocationPermissions().checkPermissionStatus();
//       while (permission1 != PermissionStatus.granted) {
//         permission1 = await LocationPermissions().requestPermissions();
//       }
//       position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.bestForNavigation);
//     } else {
//       position = widget.userLocation!;
//     }
//     myLocation = position;
//     print(myLocation);
//
//     LatLng coordinates = LatLng(position.latitude, position.longitude);
//     LatLng latLng_1 = coordinates;
//     LatLng latLng_2 = LatLng(widget.gpsData.lat!, widget.gpsData.lng!);
//     if (latLng_1.latitude > latLng_2.latitude) {
//       latLng_1 = LatLng(widget.gpsData.lat!, widget.gpsData.lng!);
//       latLng_2 = coordinates;
//     }
//
//     LatLngBounds bounds = LatLngBounds(
//       southwest: latLng_1,
//       northeast: latLng_2,
//     );
// // calculating centre of the bounds
//     LatLng centerBounds = LatLng(
//         (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
//         (bounds.northeast.longitude + bounds.southwest.longitude) / 2);
//
//     //zooms the camera and sets it so that user location and gps location are shown at same time
//     zoomToFitToCenterBound(googleMapController!, bounds, centerBounds);
//
//     showMarkerAtPosition(
//         LatLng(myLocation!.latitude, myLocation!.longitude), "myPosition", userLocationIcon!);
//     print(pinLocationIcon);
//     print(LatLng(gpsDataController.getGpsData().lat!, gpsDataController.getGpsData().lng!));
//     setState(() {
//       markers.add(
//         Marker(
//             markerId: MarkerId("GpsMarker"),
//             rotation: 0,
//             position: LatLng(gpsDataController.getGpsData().lat!, gpsDataController.getGpsData().lng!),
//             anchor: Offset(0.5, 0.5),
//             icon: pinLocationIcon!),
//       );
//       _createPolylines(
//         LatLng(myLocation!.latitude, myLocation!.longitude),
//         LatLng(gpsDataController.getGpsData().lat!,
//             gpsDataController.getGpsData().lng!),
//       );
//     });
//
//     updateGpsMarker(LatLng(widget.gpsData.lat!, widget.gpsData.lng!));
//     getGpsDataByImei(imei: widget.gpsData.imei);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: statusBarColor,
//       // appBar: AppBar(
//       //   backgroundColor: Color(0xFF525252),
//       //   title: ,
//       // ),
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: space_4, vertical: space_2),
//                 child: Row(
//                   children: [
//                     BackButtonWidget(),
//                     SizedBox(
//                       width: space_3,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: (MediaQuery.of(context).size.width) / 1.8,
//                           child: Text(
//                             address,
//                             style: TextStyle(fontSize: size_9),
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Obx(
//                               () => Text(
//                                 gpsDataController.getGpsData().speed.toString(),
//                                 style: TextStyle(fontSize: size_10 * 2),
//                               ),
//                             ),
//                             Text(
//                               "km/hr",
//                               style: TextStyle(fontSize: size_5),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GoogleMap(
//                   polylines: Set.from(polylines.values),
//                   markers: markers,
//                   mapType: MapType.normal,
//                   initialCameraPosition: _initialCameraPosition,
//                   onMapCreated: (GoogleMapController controller) {
//                     _controllerGoogleMap.complete(controller);
//                     googleMapController = controller;
//                     googleMapController!.animateCamera(
//                       CameraUpdate.newCameraPosition(CameraPosition(
//                           target:
//                               LatLng(widget.gpsData.lat!, widget.gpsData.lng!),
//                           zoom: 14.5)),
//                     );
//                     getCurrentLocation();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
