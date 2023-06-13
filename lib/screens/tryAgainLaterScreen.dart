import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '../constants/colors.dart';
import '../constants/fontSize.dart';
import '../constants/fontWeights.dart';

class TryAgainLaterScreen extends StatefulWidget {
  final List gpsData;
  final List gpsDataHistory;
  final List gpsStoppageHistory;
  //final List routeHistory;
  final String? TruckNo;
  final int? deviceId;
  final String? driverNum;
  final String? driverName;
  final String? truckId;

  const TryAgainLaterScreen(
      {super.key, required this.gpsData,
      required this.gpsDataHistory,
      required this.gpsStoppageHistory,
      //required this.routeHistory,
      // required this.position,
      this.TruckNo,
      this.driverName,
      this.driverNum,
      this.deviceId,
      this.truckId});

  @override
  State<TryAgainLaterScreen> createState() => _TryAgainLaterScreenState();
}

class _TryAgainLaterScreenState extends State<TryAgainLaterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image(
                    height: space_9 + 2,
                    width: space_11,
                    image: AssetImage("assets/icons/retryIcon.png")),
                SizedBox(
                  height: space_5,
                  width: MediaQuery.of(context).size.width,
                ),
                Text(
                  "Try Again Later",
                  // "You can use this feature",
                  style: TextStyle(
                    fontWeight: mediumBoldWeight,
                    fontSize: size_9,
                  ),
                ),
                SizedBox(
                  height: space_6 - 2,
                ),
                // Text(
                //   'alertLine2'.tr,
                //   // "in next update",
                //   style:
                //       TextStyle(fontWeight: mediumBoldWeight, fontSize: size_9),
                // ),
                // SizedBox(
                //   height: space_6 - 2,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        // Get.to(() => TruckLockUnlock(
                        //     deviceId: widget.deviceId,
                        //     gpsData: widget.gpsData,
                        //     // position: position,
                        //     TruckNo: widget.TruckNo,
                        //     //   driverName: widget.driverName,
                        //     //   driverNum: widget.driverNum,
                        //     gpsDataHistory: widget.gpsDataHistory,
                        //     gpsStoppageHistory: widget.gpsStoppageHistory,
                        //     routeHistory: widget.routeHistory));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: space_3),
                        height: space_8,
                        width: (space_16 * 3) - 8,
                        decoration: BoxDecoration(
                            color: darkBlueColor,
                            borderRadius: BorderRadius.circular(radius_6),
                            boxShadow: [
                              BoxShadow(
                                  color: darkGreyColor,
                                  offset: Offset(2.0, 2.0))
                            ]),
                        child: Center(
                          child: Text(
                            "ok1".tr,
                            style: TextStyle(
                                color: white,
                                fontWeight: mediumBoldWeight,
                                fontSize: size_8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
