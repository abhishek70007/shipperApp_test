import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/controller/analysisDataController.dart';
import '/controller/analysisScreenNavController.dart';
import '/functions/ongoingTrackUtils/getTraccarStoppagesByDeviceId.dart';
import '/functions/ongoingTrackUtils/getTraccarTripsByDeviceId.dart';
import '/widgets/analysisScreenBarButton.dart';
import '/widgets/stopSpecificCard.dart';
import '/widgets/truckAnalysisCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/constants/colors.dart';
import '/functions/trackScreenFunctions.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/widgets/truckAnalysisDoughnut.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String routeDataApi = dotenv.get("routeDataApiUrl");

class truckAnalysisScreen extends StatefulWidget {
  var recentStops;
  var truckNo;
  var imei;
  var deviceId;
  var runningTimeVar;

  truckAnalysisScreen(
      {required this.recentStops,
        required this.truckNo,
        required this.imei,
        this.deviceId,
        this.runningTimeVar});

  @override
  _truckAnalysisScreenState createState() => _truckAnalysisScreenState();
}

class _truckAnalysisScreenState extends State<truckAnalysisScreen>
    with AutomaticKeepAliveClientMixin {
  var recentStops;
  var truckId = 0;
  var truckNo;
  var imei;
  var gpsStoppage;
  var deviceId;
  late String from;
  late String to;
  var timeSpan = 0;
  DateTime selectedDate = DateTime.now();
  var datePickerCall;
  var runningTime;
  var temp;

  AnalysisDataController analysisDataController =
  Get.put(AnalysisDataController());

  AnalysisScreenNavController analysisScreenNavController =
  Get.put(AnalysisScreenNavController());

  List<String> _locations = [
    '24 hours',
    '48 hours',
    '7 days',
    '14 days',
    '30 days'
  ];

  String _selectedLocation = '24 hours';

  // changing vars
  bool loading = true;

  var truckStatusList = [];
  var stopStatusList = [];
  var validStoppageList = [];
  var validAddressList = [];

  //No of specific stops.
  var allNav = 0;
  var loadingNav = 0;
  var unLoadingNav = 0;
  var parkingNav = 0;
  var maintenanceNav = 0;

  /// Date picker Code
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateBasedApiCall(picked: picked);
      });
  }

  /// Api called when Date is selected
  dateBasedApiCall({required var picked}) {
    print("DATE PICKER");
    print(picked.toString());

    var istDate1;
    var istDate2;

    analysisDataController.updateLoadingPointData(0);
    analysisDataController.updateUnLoadingPointData(0);
    analysisDataController.updateMaintenanceData(0);
    analysisDataController.updateParkingData(0);
    analysisDataController.updateRunningTimeData(0);
    analysisDataController.updateUnknownStopData(0);
    timeSpan = 86400000;

    setState(() {
      istDate1 = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(picked.toString());

      istDate2 = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(picked.toString())
          .add(Duration(hours: 11, minutes: 30));
      print(
          "selected date 1 ${istDate1.toIso8601String()} and ${istDate2.toIso8601String()}");
    });

    // Run all APIs using new Date Range
    from = istDate1.toIso8601String();
    to = istDate2.toIso8601String();

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

    initFunctionAfterChange();
  }

  //For scroll.
  final itemKey = GlobalKey();
  Future scrollToLastItem() async {
    final context = itemKey.currentContext;
    await Scrollable.ensureVisible(context!);
  }

  final itemKeyFirst = GlobalKey();
  Future scrollToFirstItem() async {
    final context = itemKeyFirst.currentContext;
    await Scrollable.ensureVisible(context!);
  }

  // Function to fetch the address
  validStoppages() async {

    /// To empty the lists to avoid overlap of Data.
    validStoppageList = [];
    truckStatusList = [];
    stopStatusList = [];
    validAddressList = [];
    allNav = 0;
    loadingNav = 0;
    unLoadingNav = 0;
    parkingNav = 0;
    maintenanceNav = 0;

    /// Filter out stops more than 2 hours and populate lists.
    for (var gp in recentStops) {
      if (gp.duration >= 7200000) {
        print(gp.latitude);
        print(gp.longitude);
        print(gp.duration);
        validStoppageList.add(gp);
        truckStatusList.add(true);
        stopStatusList.add("null");
        // For analysisScreenBar
        allNav = allNav + 1;
      }
    }
    await getValidAddresses();
  }

  // To get valid Addresses
  getValidAddresses() async{
    for (var stopInstance in validStoppageList) {
      var n = await getStoppageAddress(stopInstance);
      validAddressList.add(n);
    }
    await getRouteData();
  }

  /// Function to fetch already posted routeData and compare it with specified
  /// range data and iterate over the list to rectify the lists and determine
  /// if the stop has already been defined.
  getRouteData() async {
    try {

      /// Call for route Data Api
      http.Response response =
      await http.get(Uri.parse("${routeDataApi}?devideId=1"));
      var returnData = await json.decode(response.body);

      if (response.statusCode == 200) {
        /// Check to verify if the stop has already been defined.
        for (int i = 0; i < validStoppageList.length; i++) {
          for (var json in returnData) {
            if (json["latitude"] == validStoppageList[i].latitude &&
                json["longitude"] == validStoppageList[i].longitude &&
                json["duration"] == validStoppageList[i].duration.toString()) {
              truckStatusList[i] = false;
              break;
            }
          }
        }

        /// To know what kind of stoppage the defined Stop is.
        for (int i = 0; i < validStoppageList.length; i++) {
          for (var json in returnData) {
            if (json["latitude"] == validStoppageList[i].latitude &&
                json["longitude"] == validStoppageList[i].longitude &&
                json["duration"] == validStoppageList[i].duration.toString()) {
              stopStatusList[i] = json["stopageStatus"];
              break;
            }
          }
        }

        calculateDoughnutData(returnData);
        calculateAnalysisBarValues();
        calculateUnknownStopData();

        EasyLoading.dismiss();
        setState(() {
          loading = false;
        });
      }
    }
    catch (e) {
      print(e);
      EasyLoading.dismiss();
    }

  }

  void calculateDoughnutData(var returnData){
    /// Calculates the Data for the Analysis Doughnut
    for (int i = 0; i < validStoppageList.length; i++) {
      for (var json in returnData) {
        if (json["latitude"] == validStoppageList[i].latitude &&
            json["longitude"] == validStoppageList[i].longitude &&
            json["duration"] == validStoppageList[i].duration.toString()) {
          if (json["stopageStatus"] == "Loading_Point") {
            analysisDataController.loadingPointData.value =
                validStoppageList[i].duration +
                    analysisDataController.loadingPointData.value;
            break;
          } else if (json["stopageStatus"] == "Unloading_Point") {
            analysisDataController.unLoadingPointData.value =
                validStoppageList[i].duration +
                    analysisDataController.unLoadingPointData.value;
            break;
          } else if (json["stopageStatus"] == "Parking") {
            analysisDataController.parkingData.value =
                validStoppageList[i].duration +
                    analysisDataController.parkingData.value;
            break;
          } else {
            analysisDataController.maintenanceData.value =
                validStoppageList[i].duration +
                    analysisDataController.maintenanceData.value;
            break;
          }
        }
      }
    }
  }

  void calculateAnalysisBarValues(){
    /// To calculate the Analysis Bar Values.
    for (var stop in stopStatusList) {
      stop == "Loading_Point" ? loadingNav++ : null;
      stop == "Unloading_Point" ? unLoadingNav++ : null;
      stop == "Parking" ? parkingNav++ : null;
      stop == "Maintenance" ? maintenanceNav++ : null;
    }
  }

  void calculateUnknownStopData() {
    /// To calculate the Unknown Stop Values.
    var totalStopTime = analysisDataController.loadingPointData.value +
        analysisDataController.unLoadingPointData.value +
        analysisDataController.parkingData.value +
        analysisDataController.maintenanceData.value +
        analysisDataController.runningTimeData.value;

    var unknownStopTime = timeSpan - totalStopTime;
    analysisDataController.updateUnknownStopData(unknownStopTime);
  }

  getRunningTime(var routeHistory) {
    var duration = 0;
    for (var instance in routeHistory) {
      duration += (instance.duration) as int;
    }
    return duration;
  }

  void initFunctionAfterChange() async {
    setState(() {
      loading = true;
    });

    var s = getTraccarStoppagesByDeviceId(deviceId:deviceId, from: from,to: to);
    var t = getTraccarTripsByDeviceId(deviceId:deviceId, from: from,to: to);

    var newGpsStoppageHistory = await s;
    var gpsRoute = await t;

    setState(() {
      recentStops = newGpsStoppageHistory;
      analysisDataController.runningTimeData.value = getRunningTime(gpsRoute);
    });

    await validStoppages();
  }

  customSelection(String? choice) async {
    String startTime = DateTime.now().subtract(Duration(days: 1)).toString();
    String endTime = DateTime.now().toString();

    analysisDataController.updateLoadingPointData(0);
    analysisDataController.updateUnLoadingPointData(0);
    analysisDataController.updateMaintenanceData(0);
    analysisDataController.updateParkingData(0);
    analysisDataController.updateRunningTimeData(0);
    analysisDataController.updateUnknownStopData(0);
    timeSpan = 86400000;

    switch (choice) {
      case '48 hours':
        print("48");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 2)).toString();
          timeSpan = 172800000;
          print("NEW start $startTime and $endTime");
        });
        break;
      case '7 days':
        print("7");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 7)).toString();
          timeSpan = 604800000;
          print("NEW start $startTime and $endTime");
        });
        break;
      case '14 days':
        print("14");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 14)).toString();
          timeSpan = 1209600000;
          print("NEW start $startTime and $endTime");
        });
        break;
      case '30 days':
        print("30");
        setState(() {
          endTime = DateTime.now().toString();
          startTime = DateTime.now().subtract(Duration(days: 30)).toString();
          timeSpan = 2592000000;
          print("NEW start $startTime and $endTime");
        });
        break;
    }

    var istDate1;
    var istDate2;

    setState(() {
      istDate1 = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(startTime)
          .subtract(Duration(hours: 5, minutes: 30));
      istDate2 = new DateFormat("yyyy-MM-dd hh:mm:ss")
          .parse(endTime)
          .subtract(Duration(hours: 5, minutes: 30));
      print(
          "selected date 1 ${istDate1.toIso8601String()} and ${istDate2.toIso8601String()}");
    });

    //Run all APIs using new Date Range
    from = istDate1.toIso8601String();
    to = istDate2.toIso8601String();

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

    initFunctionAfterChange();
  }

  void initFunction() async {
    setState(() {
      recentStops = widget.recentStops;
      truckNo = widget.truckNo;
      imei = widget.imei;
      deviceId = widget.deviceId;
      timeSpan = 86400000;
    });

    DateTime yesterday =
    DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
    DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
    late String today = yesterday.toIso8601String();
    late String end = now.toIso8601String();
    var t = getTraccarTripsByDeviceId(deviceId: deviceId,from: today,to: end);
    var gpsRoute = await t;
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
    analysisDataController.runningTimeData.value = getRunningTime(gpsRoute);
    validStoppages();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
        initialPage: analysisScreenNavController.upperNavIndex.value);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(

          title: Text(
            "$truckNo",
            style: TextStyle(color: black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: white,
        ),
        body: loading
            ? Container()
            : Container(
          height: height,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Select Date"),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(
                                        color: Color.fromRGBO(64, 64, 64, 1)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5))),
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                    "${formatDate(selectedDate, [d, ' ', M, ' ', yyyy])}",
                                    style: TextStyle(
                                        fontSize: 11, color: black),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          white)),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                              )
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 110,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(
                                    color: Color.fromRGBO(64, 64, 64, 1)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                            child: DropdownButton(
                              underline: Container(),
                              hint: Padding(
                                padding:
                                const EdgeInsets.only(right: 12.0),
                                child: Text('24 hours'),
                              ),
                              icon: Container(
                                width: 36,
                                child: Row(children: [
                                  Expanded(
                                    child: Container(
                                      width: 36,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          size: 25,
                                          color: black),
                                    ),
                                  ),
                                ]),
                              ),
                              style: TextStyle(
                                  color: const Color(0xff3A3A3A),
                                  fontSize: 11,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400),
                              // Not necessary for Option 1
                              value: _selectedLocation,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedLocation = newValue.toString();
                                });
                                customSelection(_selectedLocation);
                              },
                              items: _locations.map((location) {
                                return DropdownMenuItem(
                                  child: Container(
                                      child: new Text(location)),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 280,
                    child: truckAnalysisDoughnut(),
                  )
                ]),
              ),
              Container(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  children: [
                    Container(
                      key: itemKeyFirst,
                      child: AnalysisScreenBarButton(
                          text: 'All (${allNav.toString()})'.tr,
                          value: 0,
                          pageController: pageController),
                    ),
                    AnalysisScreenBarButton(
                        text: 'Loading (${loadingNav.toString()})'.tr,
                        value: 1,
                        pageController: pageController),
                    AnalysisScreenBarButton(
                        text: 'Unloading (${unLoadingNav.toString()})'.tr,
                        value: 2,
                        pageController: pageController),
                    AnalysisScreenBarButton(
                        text: 'Parking (${parkingNav.toString()})'.tr,
                        value: 3,
                        pageController: pageController),
                    Container(
                      key: itemKey,
                      child: AnalysisScreenBarButton(
                          text:
                          'Maintenance (${maintenanceNav.toString()})'
                              .tr,
                          value: 4,
                          pageController: pageController),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      analysisScreenNavController
                          .updateUpperNavIndex(value);
                      value == 3 || value == 4
                          ? scrollToLastItem()
                          : scrollToFirstItem();
                    },
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: validStoppageList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return truckanalysisCard(
                                  validStop: validStoppageList[i],
                                  validAddress: validAddressList[i],
                                  truckId: truckId,
                                  TruckNo: truckNo,
                                  imei: imei,
                                  truckStauts: truckStatusList[i],
                                  stopStatus: stopStatusList[i]);
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: validStoppageList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return stopSpecificCard(
                                validStop: validStoppageList[i],
                                validAddress: validAddressList[i],
                                stopStatus: stopStatusList[i],
                                show: "Loading_Point",
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: validStoppageList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return stopSpecificCard(
                                validStop: validStoppageList[i],
                                validAddress: validAddressList[i],
                                stopStatus: stopStatusList[i],
                                show: "Unloading_Point",
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: validStoppageList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return stopSpecificCard(
                                validStop: validStoppageList[i],
                                validAddress: validAddressList[i],
                                stopStatus: stopStatusList[i],
                                show: "Parking",
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ListView.builder(
                            itemCount: validStoppageList.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              return stopSpecificCard(
                                validStop: validStoppageList[i],
                                validAddress: validAddressList[i],
                                stopStatus: stopStatusList[i],
                                show: "Maintenance",
                              );
                            }),
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
