import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/dynamicLink.dart';
import '/functions/trackScreenFunctions.dart';
import '/screens/mapFunctionScreens/playRouteHistoryScreen.dart';
import '/screens/mapFunctionScreens/truckAnalysisScreen.dart';
import '/screens/mapFunctionScreens/truckHistoryScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/nearbyPlacesScreen.dart';

class TrackScreenDetails extends StatefulWidget {
  // final String? driverNum;
  final String? TruckNo;
//  final String? driverName;
  DateTimeRange? dateRange;
  var gpsData;
  // var gpsTruckRoute;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var stops;
  var totalRunningTime;
  var totalStoppedTime;
  var deviceId;
  //var truckId;
  // var totalDistance;
  var imei;
  var recentStops;
  var finalDistance;

  TrackScreenDetails({
    required this.finalDistance,
    required this.gpsData,
    // required this.gpsTruckRoute,
    required this.gpsDataHistory,
    required this.gpsStoppageHistory,
    //  required this.driverNum,
    required this.dateRange,
    required this.TruckNo,
    //  required this.driverName,
    required this.stops,
    required this.totalRunningTime,
    required this.totalStoppedTime,
    required this.deviceId,
    //required this.truckId,
    // required this.totalDistance,
    this.imei,
    this.recentStops,
  });

  @override
  _TrackScreenDetailsState createState() => _TrackScreenDetailsState();
}

class _TrackScreenDetailsState extends State<TrackScreenDetails> {
  var waiting;
  var gpsData;
//  var gpsTruckRoute;
  var finalDistance;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var stops;
  var totalRunningTime = "";
  var totalStoppedTime = "";
  var latitude;
  var longitude;
  var totalDistance;
  var recentStops;
  late Timer timer;
  DateTime now =
      DateTime.now().subtract(const Duration(days: 0, hours: 5, minutes: 30));
  DateTime yesterday =
      DateTime.now().subtract(const Duration(days: 1, hours: 5, minutes: 30));
  String selectedLocation = '24 hours';
  @override
  void initState() {
    super.initState();
    initFunction2();
    initFunction();

    timer = Timer.periodic(
        const Duration(minutes: 0, seconds: 10), (Timer t) => initFunction2());
  }

  distanceCalculation(String from, String to) async {
    var gpsRoute1 = await mapUtil.getTraccarSummary(
        deviceId: widget.gpsData.last.deviceId, from: from, to: to);
    setState(() {
      totalDistance = (gpsRoute1[0].distance / 1000).toStringAsFixed(2);
    });
  }

  initFunction2() {
    setState(() {
      finalDistance = widget.finalDistance;
      gpsStoppageHistory = widget.gpsStoppageHistory;

      recentStops = widget.recentStops;
      gpsData = widget.gpsData;
      // gpsTruckRoute = widget.gpsTruckRoute;
      gpsDataHistory = widget.gpsDataHistory;
      gpsStoppageHistory = widget.gpsStoppageHistory;
      stops = widget.stops;
      totalRunningTime = widget.totalRunningTime;
      totalStoppedTime = widget.totalStoppedTime;
      latitude = gpsData.last.latitude;
      longitude = gpsData.last.longitude;

      //  status = getStatus(newGPSData, gpsStoppageHistory);
      //  gpsTruckRoute = getStopList(gpsTruckRoute, yesterday, now);
    });
  }

  initFunction() {
    distanceCalculation(yesterday.toIso8601String(), now.toIso8601String());
    // distancecalculation(widget.dateRange!.start.toIso8601String(),
    //     widget.dateRange!.end.toIso8601String());
  }

  getValue() {
    setState(() {
      if (gpsDataHistory == null) {
        waiting = true;
      } else {
        waiting = false;
      }
    });
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 3 + 106,
      width: width,
      padding: EdgeInsets.fromLTRB(0, 0, 0, space_3),
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: darkShadow,
              offset: Offset(
                0,
                -5.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
            BoxShadow(
              color: white,
              offset: Offset(0, 1.0),
              blurRadius: 0.0,
              spreadRadius: 2.0,
            ),
          ]),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Color(0xFFCBCBCB),
              // height: size_3,
              thickness: 3,
              indent: 150,
              endIndent: 150,
            ),
            Container(
              // height: space_11,

              padding: EdgeInsets.fromLTRB(size_10, size_3, 0, space_3),

              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    color: bidBackground,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: width / 2 + 10,
                                    child: Text(
                                      "${gpsData.last.address}",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 12,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: normalWeight),
                                    ),
                                  ),
                                ]),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //  textDirection:
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/circle-outline-with-a-central-dot.png',
                                      color: bidBackground,
                                      width: 11,
                                      height: 11,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text('ignition'.tr,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 12,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: regularWeight)),
                                    ),
                                    (gpsData.last.ignition)
                                        ? Container(
                                            alignment: Alignment.centerLeft,
                                            //    width: 217,

                                            child: Text('on'.tr,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    color: black,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        : Container(
                                            alignment: Alignment.centerLeft,
                                            //    width: 217,

                                            child: Text("off".tr,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    color: black,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                    const SizedBox(),
                                  ]),
                            ),
                          ] //

                          ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Image.asset('assets/icons/speed_status.png',
                                width: 35, height: 35),
                            (widget.gpsData.last.speed > 2)
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        Text("${(gpsData.last.speed).round()} ",
                                            style: TextStyle(
                                                color: liveasyGreen,
                                                fontSize: size_10,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: regularWeight)),
                                        Text("km/h".tr,
                                            style: TextStyle(
                                                color: liveasyGreen,
                                                fontSize: size_6,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: regularWeight)),
                                      ])
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                        Text("${(gpsData.last.speed).round()} ",
                                            style: TextStyle(
                                                color: red,
                                                fontSize: size_10,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: regularWeight)),
                                        Text("km/h".tr,
                                            style: TextStyle(
                                                color: red,
                                                fontSize: size_6,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: regularWeight)),
                                      ]),
                            /*    Text("status".tr,
                                style: TextStyle(
                                    color: black,
                                    fontSize: size_6,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: regularWeight))*/
                          ],
                        ),
                      ),
                      const Spacer(),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      const Image(
                        image: AssetImage('assets/icons/distanceCovered.png'),
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        //      width: 103,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('truckTravelled'.tr,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: liveasyGreen,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                                Text("$finalDistance ${"km".tr}",
                                    softWrap: true,
                                    style: TextStyle(
                                        color: black,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${widget.totalRunningTime} ",
                                    softWrap: true,
                                    style: TextStyle(
                                        color: grey,
                                        fontSize: size_4,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(children: [
                      const Icon(Icons.pause, size: 20),
                      SizedBox(
                        width: space_1,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        //    width: 103,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                gpsStoppageHistory != null
                                    ? Text("${gpsStoppageHistory.length} ",
                                        softWrap: true,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: size_6,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: regularWeight))
                                    : Text(" ",
                                        softWrap: true,
                                        style: TextStyle(
                                            color: black,
                                            fontSize: size_6,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: regularWeight)),
                                Text("stops".tr,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: red,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${widget.totalStoppedTime}",
                                    softWrap: true,
                                    style: TextStyle(
                                        color: grey,
                                        fontSize: size_4,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: space_1,
                    )
                  ],
                ),
                const SizedBox(height: 0),
              ]),
            ),
            Divider(
              color: black,
              // height: size_3,
              thickness: 0.75,
              indent: size_10,
              endIndent: size_10,
            ),
            Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.only(left: 15, right: 15),
                margin: EdgeInsets.fromLTRB(0, space_1, 0, space_1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button1",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child: Image.asset(
                            'assets/icons/navigate2.png',
                            scale: 2.5,
                          ),
                          onPressed: () {
                            openMap(
                                gpsData.last.latitude, gpsData.last.longitude);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "navigate".tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                    Column(children: [
                      DynamicLinkService(
                        deviceId: widget.deviceId,
                        // truckId: widget.truckId,
                        truckNo: widget.TruckNo,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "share".tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button3",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child:
                              const Icon(Icons.play_circle_outline, size: 30),
                          onPressed: () {
                            //Checking value of gpsDataHistory, if it's null then waiting until The value not get
                            getValue();
                            if (waiting) {
                              Get.to(
                                const SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              );
                              Timer(const Duration(seconds: 10), () {
                                Navigator.pop(context);
                              });
                              Timer(const Duration(seconds: 10), () {
                                Get.to(PlayRouteHistory(
                                  finalDistance: finalDistance,
                                  ignition: gpsData.last.ignition,
                                  address: gpsData.last.address,
                                  gpsTruckHistory: gpsDataHistory,
                                  truckNo: widget.TruckNo,
                                  //    routeHistory: gpsTruckRoute,
                                  gpsData: gpsData,
                                  dateRange: widget.dateRange.toString(),
                                  gpsStoppageHistory: gpsStoppageHistory,
                                  //   totalDistance: totalDistance,
                                  totalRunningTime: totalRunningTime,
                                  totalStoppedTime: totalStoppedTime,
                                ));
                                Timer(const Duration(seconds: 10), () {
                                  getValue();
                                });
                              });
                            } else {
                              Get.to(PlayRouteHistory(
                                finalDistance: finalDistance,
                                ignition: gpsData.last.ignition,
                                address: gpsData.last.address,
                                gpsTruckHistory: gpsDataHistory,
                                truckNo: widget.TruckNo,
                                //    routeHistory: gpsTruckRoute,
                                gpsData: gpsData,
                                dateRange: widget.dateRange.toString(),
                                gpsStoppageHistory: gpsStoppageHistory,
                                //   totalDistance: totalDistance,
                                totalRunningTime: totalRunningTime,
                                totalStoppedTime: totalStoppedTime,
                              ));
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "playtrip".tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button4",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child: const Icon(Icons.history, size: 30),
                          onPressed: () {
                            Get.to(TruckHistoryScreen(
                              truckNo: widget.TruckNo,
                              //   gpsTruckRoute: widget.gpsTruckRoute,
                              dateRange: widget.dateRange.toString(),
                              deviceId: widget.deviceId,
                              selectedLocation: selectedLocation,
                              istDate1: yesterday,
                              istDate2: now,
                              totalDistance: totalDistance,
                              gpsDataHistory: widget.gpsDataHistory,
                              gpsStoppageHistory: widget.gpsStoppageHistory,
                              //     latitude: latitude,
                              //      longitude: longitude,
                            ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "history".tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                  ],
                )),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(space_5, space_1, space_5, space_1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button5",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child: Image.asset(
                            'assets/icons/gas_station.png',
                            scale: 2.5,
                          ),
                          onPressed: () {
                            Get.to(
                              NearbyPlacesScreen(
                                deviceId: widget.deviceId,
                                gpsData: widget.gpsData,
                                placeOnTheMapTag: "gas_station",
                                placeOnTheMapName: "petrol_pump".tr,
                                // position: position,
                                TruckNo: widget.TruckNo,
                                // driverName: widget.driverName,
                                //  driverNum: widget.driverNum,
                                //   truckId: widget.truckId,
                                //    gpsDataHistory: widget.gpsDataHistory,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'petrol_pump'.tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button6",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child: Image.asset(
                            'assets/icons/police.png',
                            scale: 2.5,
                          ),
                          onPressed: () {
                            Get.to(
                              NearbyPlacesScreen(
                                deviceId: widget.deviceId,
                                gpsData: widget.gpsData,
                                placeOnTheMapTag: "police",
                                placeOnTheMapName: "police_station".tr,
                                // position: position,
                                TruckNo: widget.TruckNo,
                                //  driverName: widget.driverName,
                                //   driverNum: widget.driverNum,
                                //  truckId: widget.truckId,
                                // gpsDataHistory: widget.gpsDataHistory,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'police_station'.tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: bidBackground, width: 4),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: FloatingActionButton(
                          heroTag: "button7",
                          backgroundColor: Colors.white,
                          foregroundColor: bidBackground,
                          child: Image.asset(
                            'assets/icons/truckAnalysis.png',
                            scale: 2.5,
                          ),
                          onPressed: () {
                            Get.to(truckAnalysisScreen(
                                recentStops: recentStops,
                                //   truckId: widget.truckId,
                                TruckNo: widget.TruckNo,
                                imei: widget.imei,
                                deviceId: widget.deviceId));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "truckanalysis".tr,
                        style: TextStyle(
                            color: black,
                            fontSize: size_6,
                            fontStyle: FontStyle.normal,
                            fontWeight: mediumBoldWeight),
                      ),
                    ]),
                  ],
                ))
          ]),
    );
  }
}
