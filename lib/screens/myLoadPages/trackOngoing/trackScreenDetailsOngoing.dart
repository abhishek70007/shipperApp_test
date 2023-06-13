import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/dynamicLink.dart';
import '/functions/ongoingTrackUtils/getTraccarSummaryByDeviceId.dart';
import '/screens/myLoadPages/trackOngoing/nearbyPlacesScreenOngoing.dart';
import '/screens/myLoadPages/trackOngoing/truckHistoryScreenOngoing.dart';
import '../../mapFunctionScreens/playRouteHistoryScreen.dart';
import '../../mapFunctionScreens/truckAnalysisScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackScreenDetailsOngoing extends StatefulWidget {
  final String? truckNo;
  DateTimeRange? dateRange;
  var gpsData;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var stops;
  var totalRunningTime;
  var totalStoppedTime;
  var deviceId;
  var imei;
  var recentStops;

  TrackScreenDetailsOngoing({
    required this.gpsData,
    required this.gpsDataHistory,
    required this.gpsStoppageHistory,
    required this.dateRange,
    required this.truckNo,
    required this.stops,
    required this.totalRunningTime,
    required this.totalStoppedTime,
    required this.deviceId,
    this.imei,
    this.recentStops,
  });

  @override
  _TrackScreenDetailsOngoingState createState() =>
      _TrackScreenDetailsOngoingState();
}

class _TrackScreenDetailsOngoingState extends State<TrackScreenDetailsOngoing> {
  var gpsData;
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
      DateTime.now().subtract(Duration(days: 0, hours: 5, minutes: 30));
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  String selectedLocation = '24 hours';

  @override
  void initState() {
    super.initState();
    initFunction2();
    initFunction();

    timer = Timer.periodic(
        Duration(minutes: 0, seconds: 10), (Timer t) => initFunction2());
  }

  void distanceCalculation(String from, String to) async {
    var gpsRoute1 = await getTraccarSummaryByDeviceId(
        deviceId: widget.gpsData.last.deviceId, from: from, to: to);
    setState(() {
      totalDistance = (gpsRoute1[0].distance! / 1000).toStringAsFixed(2);
    });
  }

  initFunction2() {
    setState(() {
      gpsStoppageHistory = widget.gpsStoppageHistory;
      recentStops = widget.recentStops;
      gpsData = widget.gpsData;
      gpsDataHistory = widget.gpsDataHistory;
      gpsStoppageHistory = widget.gpsStoppageHistory;
      stops = widget.stops;
      totalRunningTime = widget.totalRunningTime;
      totalStoppedTime = widget.totalStoppedTime;
      latitude = gpsData.last.latitude;
      longitude = gpsData.last.longitude;
    });
  }

  initFunction() {
    distanceCalculation(widget.dateRange!.start.toIso8601String(),
        widget.dateRange!.end.toIso8601String());
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  SizedBox(width: 8),
                                  Container(
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
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
                                    SizedBox(width: 10),
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
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        : Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("off".tr,
                                                softWrap: true,
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 12,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                    SizedBox(),
                                  ]),
                            ),
                          ]),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          ],
                        ),
                      ),
                      Spacer(),
                    ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image(
                        image: AssetImage('assets/icons/distanceCovered.png'),
                        height: 14,
                        width: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
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
                                Text("$totalDistance " + "km".tr,
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
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(children: [
                      Icon(Icons.pause, size: 20),
                      SizedBox(
                        width: space_1,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
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
                SizedBox(height: 0),
              ]),
            ),
            Divider(
              color: black,
              thickness: 0.75,
              indent: size_10,
              endIndent: size_10,
            ),
            Container(
                alignment: Alignment.center,
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
                      SizedBox(
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
                        truckNo: widget.truckNo,
                      ),
                      SizedBox(
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
                            Get.to(PlayRouteHistory(
                              gpsTruckHistory: gpsDataHistory,
                              truckNo: widget.truckNo,
                              gpsData: gpsData,
                              dateRange: widget.dateRange.toString(),
                              gpsStoppageHistory: gpsStoppageHistory,
                              totalRunningTime: totalRunningTime,
                              totalStoppedTime: totalStoppedTime,
                            ));
                          },
                        ),
                      ),
                      SizedBox(
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
                            Get.to(TruckHistoryScreenOngoing(
                              truckNo: widget.truckNo,
                              dateRange: widget.dateRange.toString(),
                              deviceId: widget.deviceId,
                              selectedLocation: selectedLocation,
                              istDate1: yesterday,
                              istDate2: now,
                              totalDistance: totalDistance,
                              gpsDataHistory: widget.gpsDataHistory,
                              gpsStoppageHistory: widget.gpsStoppageHistory,
                            ));
                          },
                        ),
                      ),
                      SizedBox(
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
                              NearbyPlacesScreenOngoing(
                                deviceId: widget.deviceId,
                                gpsData: widget.gpsData,
                                placeOnTheMapTag: "gas_station",
                                placeOnTheMapName: "petrol_pump".tr,
                                TruckNo: widget.truckNo,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
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
                              NearbyPlacesScreenOngoing(
                                deviceId: widget.deviceId,
                                gpsData: widget.gpsData,
                                placeOnTheMapTag: "police",
                                placeOnTheMapName: "police_station".tr,
                                TruckNo: widget.truckNo,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
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
                                TruckNo: widget.truckNo,
                                imei: widget.imei,
                                deviceId: widget.deviceId));
                          },
                        ),
                      ),
                      SizedBox(
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
