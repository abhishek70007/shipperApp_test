import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/functions/trackScreenFunctions.dart';
import '../screens/mapFunctionScreens/playRouteHistoryScreen.dart';
import 'alertDialog/invalidDateConditionDialog.dart';

class PlayRouteDetailsWidget extends StatefulWidget {
  String? dateRange;
  String? truckNo;
  String? address;
  int? totalStop;
  var gpsData;
  var finalDistance;

  // String? toDate;

  PlayRouteDetailsWidget({
    required this.finalDistance,
    required this.address,
    required this.totalStop,
    required this.dateRange,
    required this.truckNo,
    required this.gpsData,
    // required this.polylineCoordinates,
  });

  @override
  _PlayRouteDetailsWidgetState createState() => _PlayRouteDetailsWidgetState();
}

class _PlayRouteDetailsWidgetState extends State<PlayRouteDetailsWidget> {
  DateTimeRange selectedDate = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 1)), end: DateTime.now());
  var selectedDateString = [];
  var gpsStoppageHistory = [];
  var gpsTruckHistory = [];
  var routeHistory = [];
  var totalDistance;
  var start;
  var end;
  var totalRunningTime;
  var totalStoppedTime;
  String? dateRange;
  List<String> _locations = [
    'Custom',
    '48 hours',
    '7 days',
    '14 days',
    '30 days'
  ];
  String _selectedLocation = 'Custom';

  @override
  void initState() {
    super.initState();
    dateRange = widget.dateRange;
    getDateRange();
  }

  getDateRange() {
    var splitted = dateRange!.split(" - ");
    var start1 = getFormattedDateForDisplay2(splitted[0]).split(", ");
    var end1 = getFormattedDateForDisplay2(splitted[1]).split(", ");
    var start2 = start1[0].split(" ");
    var end2 = end1[0].split(" ");
    start = start1[0];
    end = end1[0];
    print("Start is ${start} and ENd is ${end}");
  }

  //Displays CALENDAR to PICK DATE RANGE -------------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
          start: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day - 1,
          ),
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0)),
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day - 5,
      ),
      lastDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: darkBlueColor,
              scaffoldBackgroundColor: white,
              accentColor: darkBlueColor,
              unselectedWidgetColor: grey,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: darkBlueColor,
                  onSecondary: darkBlueColor,
                  onSurface: Colors.black,
                  onBackground: white),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                alignment: Alignment.center,
                margin:
                    EdgeInsets.fromLTRB(space_6, space_15, space_6, space_20),
                child: child!,
              ),
            ));
      },
    );
    //If picked is not null, run all APIs with newly Selected Dates
    if (picked != null) {
      var istDate1;
      var istDate2;
      setState(() {
        // bookingDateList[3] = (nextDay.MMMEd);
        selectedDate = picked;
        print("SEL Date $selectedDate");
        selectedDateString = selectedDate.toString().split(" - ");
        istDate1 = new DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse(selectedDateString[0])
            .subtract(Duration(hours: 5, minutes: 30));
        istDate2 = new DateFormat("yyyy-MM-dd hh:mm:ss")
            .parse(selectedDateString[1])
            .subtract(Duration(hours: 5, minutes: 30));
        print(
            "selected date 1 ${istDate1.toIso8601String()} and ${istDate2.toIso8601String()}");
      });
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
      var f = getDataHistory(widget.gpsData.last.deviceId,
          istDate1.toIso8601String(), istDate2.toIso8601String());
      var s = getStoppageHistory(widget.gpsData.last.deviceId,
          istDate1.toIso8601String(), istDate2.toIso8601String());
      var t = getRouteStatusList(widget.gpsData.last.deviceId,
          istDate1.toIso8601String(), istDate2.toIso8601String());

      var newGpsTruckHistory = await f;
      var newGpsStoppageHistory = await s;
      var newRouteHistory = await t;

      print("AFter $newGpsTruckHistory");
      print("AFter $newGpsStoppageHistory");
      print("AFter $newRouteHistory");
      if (newRouteHistory != null) {
        setState(() {
          gpsTruckHistory = newGpsTruckHistory;
          gpsStoppageHistory = newGpsStoppageHistory;
          totalDistance = newRouteHistory.removeAt(0);
          routeHistory = newRouteHistory;
          dateRange = selectedDate.toString();
        });
        totalRunningTime =
            getTotalRunningTime(gpsStoppageHistory, istDate1, istDate2);
        totalStoppedTime = getTotalStoppageTime(gpsStoppageHistory);

        int i = 0;
        var start;
        var end;
        var duration;
        while (i < routeHistory.length) {
          if (i == 0) {
            DateTime yesterday = istDate1;
            start = getISOtoIST(istDate1.toIso8601String());
            end = getISOtoIST(routeHistory[i].startTime);
            duration = getStopDuration(
                yesterday.toIso8601String(), routeHistory[i].startTime);
            routeHistory.insert(i, ["stopped", start, end, duration]);
          } else {
            start = getISOtoIST(routeHistory[i - 1].endTime);
            end = getISOtoIST(routeHistory[i].startTime);
            duration = getStopDuration(
                routeHistory[i - 1].endTime, routeHistory[i].startTime);
            routeHistory.insert(i, ["stopped", start, end, duration]);
          }
          i = i + 2;
        }
        print("With Stops $routeHistory");

        Get.back();
        EasyLoading.dismiss();
        /*      Get.to(PlayRouteHistory(
          gpsTruckHistory: gpsTruckHistory,
          truckNo: widget.truckNo,
          gpsData: widget.gpsData,
          dateRange: selectedDate.toString(),
          gpsStoppageHistory: gpsStoppageHistory,
          totalStoppedTime: totalStoppedTime,
          totalRunningTime: totalRunningTime,
          // locations: Locations,
        ));
    */
      } else {
        EasyLoading.dismiss();
        showDialog(
            context: context, builder: (context) => InvalidDateCondition());
        print("gps route null");
      }
    }
  }

//CUSTOM SELECTION allows user to select date range like 2 days, 4 days...
  customSelection(String? choice) async {
    String startTime = DateTime.now().subtract(Duration(days: 1)).toString();
    String endTime = DateTime.now().toString();
    switch (choice) {
      case '48 hours':
        print("48");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 2)).toString();
          print("NEW start $startTime and $endTime");
        });
        break;
      case '7 days':
        print("7");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 7)).toString();
          print("NEW start $startTime and $endTime");
        });
        break;
      case '14 days':
        print("14");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 14)).toString();
          print("NEW start $startTime and $endTime");
        });
        break;
      case '30 days':
        print("30");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 30)).toString();
          print("NEW start $startTime and $endTime");
        });
        break;
    }
    var istDate1;
    var istDate2;
    setState(() {
      // bookingDateList[3] = (nextDay.MMMEd);
      istDate1 = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(startTime)
          .subtract(Duration(hours: 5, minutes: 30));
      istDate2 = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(endTime)
          .subtract(Duration(hours: 5, minutes: 30));
      print(
          "selected date 1 ${istDate1.toIso8601String()} and ${istDate2.toIso8601String()}");
    });
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

    //Run all APIs using new Date Range
    var f = getDataHistory(widget.gpsData.last.imei, startTime, endTime);
    var s = getStoppageHistory(widget.gpsData.last.imei, startTime, endTime);
    var t = getRouteStatusList(widget.gpsData.last.imei, startTime, endTime);
    var newGpsTruckHistory = await f;
    var newGpsStoppageHistory = await s;
    var newRouteHistory = await t;
    var newTotalRunningTime =
        getTotalRunningTime(newGpsStoppageHistory, istDate1, istDate2);
    var newTotalStoppedTime = getTotalStoppageTime(newGpsStoppageHistory);
    print("AFter $newGpsTruckHistory");
    print("AFter $newGpsStoppageHistory");
    print("AFter $newRouteHistory");

    int i = 0;
    var start;
    var end;
    var duration;
    while (i < newRouteHistory.length) {
      if (i == 0) {
        DateTime yesterday = istDate1;
        start = getISOtoIST(istDate1.toIso8601String());
        end = getISOtoIST(newRouteHistory[i].startTime);
        duration = getStopDuration(
            yesterday.toIso8601String(), newRouteHistory[i].startTime);
        newRouteHistory.insert(i, ["stopped", start, end, duration]);
      } else {
        start = getISOtoIST(newRouteHistory[i - 1].endTime);
        end = getISOtoIST(newRouteHistory[i].startTime);
        duration = getStopDuration(
            newRouteHistory[i - 1].endTime, newRouteHistory[i].startTime);
        newRouteHistory.insert(i, ["stopped", start, end, duration]);
      }
      i = i + 2;
    }
    print("With Stops $newRouteHistory");
    if (newRouteHistory != null) {
      setState(() {
        gpsTruckHistory = newGpsTruckHistory;
        gpsStoppageHistory = newGpsStoppageHistory;
        totalDistance = newRouteHistory.removeAt(0);
        routeHistory = newRouteHistory;
        dateRange = "$startTime - $endTime";
        totalRunningTime = newTotalRunningTime;
        totalStoppedTime = newTotalStoppedTime;
        // fromDate = yesterday.toString();
        // toDate = today.toString();
      });
      // getLatLngList();
      Get.back();
      EasyLoading.dismiss();
      /*    Get.to(PlayRouteHistory(
        gpsTruckHistory: gpsTruckHistory,
        truckNo: widget.truckNo,
        gpsData: widget.gpsData,
        dateRange: dateRange,
        gpsStoppageHistory: gpsStoppageHistory,
        totalStoppedTime: totalStoppedTime,
        totalRunningTime: totalRunningTime,
        // locations: Locations,
      ));
 */
    } else {
      EasyLoading.dismiss();
      showDialog(
          context: context, builder: (context) => InvalidDateCondition());
      print("gps route null");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    //add Ui
    return Container(
        // color: white,
        width: width,
        height: height * .5,
        decoration: BoxDecoration(
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
        child: Column(children: [
          Container(
            // color: grey,
            width: space_10,
            height: space_1,
            margin: EdgeInsets.only(top: space_3),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.truckNo}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(Icons.fire_truck_outlined)
                  ],
                ),
                Divider(color: Colors.grey, endIndent: 120, thickness: 2),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.location_on_sharp, color: Colors.grey),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        "${widget.address}",
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 40, right: 120),
                  child: Container(
                    // width: MediaQuery.of(context).size.width * .5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 15, right: 25),
                    child: Row(children: [
                      Image.asset(
                        'assets/icons/circle-outline-with-a-central-dot.png',
                        color: Colors.blue,
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(width: 10),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('ignition'.tr,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: regularWeight)),
                      ),
                      (widget.gpsData.last.ignition)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              //    width: 217,

                              child: Text('on'.tr,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold)),
                            )
                          : Container(
                              alignment: Alignment.centerLeft,
                              //    width: 217,

                              child: Text("off".tr,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold)),
                            ),
                    ]),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/icons/distanceCovered.png'),
                          height: 23,
                        ),
                        SizedBox(width: 10),
                        Text("Kms Travelled:".tr + " ",
                            softWrap: true,
                            style: TextStyle(
                                color: black,
                                fontSize: size_7,
                                fontStyle: FontStyle.normal,
                                fontWeight: regularWeight)),
                        Text("${widget.finalDistance} km",
                            softWrap: true,
                            style: TextStyle(
                                color: liveasyGreen,
                                fontSize: size_7,
                                fontStyle: FontStyle.normal,
                                fontWeight: regularWeight)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.pause, size: size_11),
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text("Stops:".tr,
                            softWrap: true,
                            style: TextStyle(
                                color: black,
                                fontSize: size_8,
                                fontStyle: FontStyle.normal,
                                fontWeight: regularWeight)),
                        Text(" ${widget.totalStop} stops ",
                            softWrap: true,
                            style: TextStyle(
                                color: red,
                                fontSize: size_8,
                                fontStyle: FontStyle.normal,
                                fontWeight: regularWeight)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          // Container(
          //     child: Row(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           margin: EdgeInsets.fromLTRB(0, space_5, 0, 0),
          //           width: 117,
          //           alignment: Alignment.centerLeft,
          //           child: Text("from".tr,
          //               textAlign: TextAlign.start,
          //               style: TextStyle(
          //                   color: black,
          //                   fontSize: size_7,
          //                   fontStyle: FontStyle.normal,
          //                   fontWeight: regularWeight)),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             _selectDate(context);
          //           },
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 117,
          //                 padding: EdgeInsets.fromLTRB(
          //                     space_2, space_1, space_2, space_1),
          //                 margin: EdgeInsets.fromLTRB(space_5, 0, 0, space_2),
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: black),
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(3),
          //                   ),
          //                 ),
          //                 child: Text("${start}",
          //                     style: TextStyle(
          //                         color: grey,
          //                         fontSize: size_6,
          //                         fontStyle: FontStyle.normal,
          //                         fontWeight: regularWeight)),
          //               ),
          //               Container(
          //                 margin: EdgeInsets.fromLTRB(space_2, 0, 0, space_2),
          //                 alignment: Alignment.topCenter,
          //                 child: Icon(Icons.calendar_today_outlined,
          //                     color: black, size: 20),
          //               ),
          //             ],
          //           ),
          //         ),
          //         Container(
          //           margin: EdgeInsets.fromLTRB(0, space_2, 0, 0),
          //           width: 117,
          //           alignment: Alignment.centerLeft,
          //           child: Text("to".tr,
          //               textAlign: TextAlign.start,
          //               style: TextStyle(
          //                   color: black,
          //                   fontSize: size_7,
          //                   fontStyle: FontStyle.normal,
          //                   fontWeight: regularWeight)),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             _selectDate(context);
          //           },
          //           child: Row(
          //             children: [
          //               Container(
          //                 width: 117,
          //                 padding: EdgeInsets.fromLTRB(
          //                     space_2, space_1, space_2, space_1),
          //                 margin: EdgeInsets.fromLTRB(space_5, 0, 0, space_2),
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: black),
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(3),
          //                   ),
          //                 ),
          //                 child: Text("${end}",
          //                     style: TextStyle(
          //                         color: grey,
          //                         fontSize: size_6,
          //                         fontStyle: FontStyle.normal,
          //                         fontWeight: regularWeight)),
          //               ),
          //               Container(
          //                 margin: EdgeInsets.fromLTRB(space_2, 0, 0, space_2),
          //                 alignment: Alignment.topCenter,
          //                 child: Icon(Icons.calendar_today_outlined,
          //                     color: black, size: 20),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     Container(
          //       height: 110,
          //       alignment: Alignment.topLeft,
          //       margin: EdgeInsets.fromLTRB(space_10, space_5, 0, 0),
          //       child: DropdownButton(
          //         hint: Text('custom'.tr),
          //         style: TextStyle(
          //             color: grey,
          //             fontSize: size_7,
          //             fontStyle: FontStyle.normal,
          //             fontWeight: regularWeight),
          //         // Not necessary for Option 1
          //         value: _selectedLocation,
          //         onChanged: (newValue) {
          //           setState(() {
          //             _selectedLocation = newValue.toString();
          //           });
          //           customSelection(_selectedLocation);
          //         },
          //         items: _locations.map((location) {
          //           return DropdownMenuItem(
          //             child: new Text(location),
          //             value: location,
          //           );
          //         }).toList(),
          //       ),
          //     ),
          //   ],
          //   // ),
          //   // GestureDetector(
          //   //   onTap:(){
          //   //     _selectDate(context);
          //   //   },
          //   //   child: Row(
          //   //     children: [
          //   //       Container(
          //   //
          //   //         width: 117,
          //   //         padding: EdgeInsets.fromLTRB(space_2, space_1, space_2, space_1),
          //   //         margin:  EdgeInsets.fromLTRB(space_6, 0, 0, 0),
          //   //         decoration: BoxDecoration(
          //   //           border: Border.all(color: black),
          //   //           borderRadius: BorderRadius.all(
          //   //             Radius.circular(3),
          //   //           ),
          //   //         ),
          //   //         child: Text("${end}",
          //   //             style: TextStyle(
          //   //                 color: grey,
          //   //                 fontSize: size_6,
          //   //                 fontStyle: FontStyle.normal,
          //   //                 fontWeight: regularWeight)
          //   //         ),
          //   //       ),
          //   //
          //   //     ],
          //   //   ),
          //   // ),
          // ))
        ]));
  }
}
