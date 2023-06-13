import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import '/functions/shipperApis/shipperApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/screens/TransporterOrders/simpleMap.dart';
import '../trackScreen.dart';

// ignore: must_be_immutable
class navigateToTrackScreen extends StatefulWidget {
  bool truckApproved = false;
  String? phoneNo;
  String? TruckNo;
  String? imei;
  String? DriverName;
  var gpsData;
  var totalDistance;

  String? bookingId;
  String? bookingDate;
  // String? truckNo;
  // String? transporterName;
  // String? transporterPhoneNum;
  // String? driverName;
  // String? driverPhoneNum;
  String? loadingPoint;
  String? unloadingPoint;
  var device;

  navigateToTrackScreen({
    required this.truckApproved,
    this.gpsData,
    this.phoneNo,
    this.TruckNo,
    this.DriverName,
    this.totalDistance,
    this.imei,
    this.bookingId,
    this.loadingPoint,
    this.unloadingPoint,
    this.bookingDate,
    this.device,
  });

  @override
  _navigateToTrackScreenState createState() => _navigateToTrackScreenState();
}

class _navigateToTrackScreenState extends State<navigateToTrackScreen> {
  String? transporterIDImei;
  final ShipperApiCalls shipperApiCalls = ShipperApiCalls();
  final TruckApiCalls truckApiCalls = TruckApiCalls();

  var truckData;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var gpsRoute;
  var endTimeParam;
  var startTimeParam;
  MapUtil mapUtil = MapUtil();
  bool loading = false;
  late String from;
  late String to;

  @override
  void initState() {
    super.initState();
    DateTime yesterday = DateTime.now()
        .subtract(Duration(days: 1, hours: 5, minutes: 30)); //from param
    from = yesterday.toIso8601String();
    DateTime now =
        DateTime.now().subtract(Duration(hours: 5, minutes: 30)); //to param
    to = now.toIso8601String();

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 350,
        child: simpleMap(),
      ),
      Positioned(
        bottom: 150,
        left: 70,
        child: Center(
          child: Opacity(
              opacity: 0.7,
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    TrackScreen(
                      deviceId: widget.gpsData.deviceId,
                      gpsData: widget.gpsData,
                      truckNo: widget.TruckNo,
                      totalDistance: widget.totalDistance,
                      imei: widget.imei,
                      // online: widget.device.status == "online" ? true : false,
                      online: true,
                      active: true,
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: grey, borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 16, bottom: 16, right: 26, left: 26),
                    child: Row(
                      children: [
                        Text(
                          "Click here".tr,
                          style: TextStyle(
                              color: white,
                              decoration: TextDecoration.underline),
                        ),
                        Text(
                          " to track your load".tr,
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
      Positioned(
        bottom: 0,
        child: Opacity(
          opacity: 0.75,
          child: Container(
            padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: darkBlueColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1, right: 10, left: 17),
                        child: Image(
                            image: AssetImage("assets/icons/white_dot.png")),
                      ),
                      Text(
                        "Order Id : " + widget.bookingId.toString(),
                        style: TextStyle(color: white, fontSize: size_5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 8),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1, right: 10, left: 17),
                        child: Image(
                            height: 17,
                            width: 17,
                            image: AssetImage("assets/icons/selectedIcon.png")),
                      ),
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 20,
                                width: MediaQuery.of(context).size.width - 10,
                                // color: Colors.orange,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        widget.loadingPoint.toString().tr,
                                        // "Thane,Mumbai",
                                        style: TextStyle(
                                            color: white,
                                            fontSize: size_7,
                                            fontWeight: boldWeight),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Image(
                                            image: AssetImage("assets/icons/Arrow.png")),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 1, right: 7),
                                        child: Image(
                                            height: 19,
                                            width: 19,
                                            image: AssetImage("assets/icons/location_pin.png")),
                                      ),
                                      Text(
                                        widget.unloadingPoint.toString().tr,
                                        // "Varanasi,Uttarpradesh",
                                        style: TextStyle(
                                            color: white,
                                            fontSize: size_7,
                                            fontWeight: boldWeight),
                                      ),
                                    ],
                                  ),
                                )
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                widget.bookingDate.toString(),
                                // "20 JUN 2022",
                                style: TextStyle(color: white, fontSize: size_6),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "8:47 AM",
                                style: TextStyle(color: white, fontSize: size_6),
                              ),
                            )
                          ],
                        ),
                      ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        color: lightGrey,
        child: Row(children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Container(
                color: white,
                height: 50,
                child: Center(
                  child: Text(
                    "ONGOING".tr,
                    style: TextStyle(
                        color: red,
                        fontSize: size_8,
                        fontWeight: mediumBoldWeight),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Container(
                color: white,
                height: 50,
                child: Center(
                  child: Text(
                    "COMPLETED".tr,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: size_8,
                        fontWeight: mediumBoldWeight),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    ]);
  }
}
