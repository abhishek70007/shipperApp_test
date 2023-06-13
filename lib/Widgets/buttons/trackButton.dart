import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../functions/shipperApis/shipperApiCalls.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/screens/trackScreen.dart';

import 'package:logger/logger.dart';

// ignore: must_be_immutable
class TrackButton extends StatefulWidget {
  bool truckApproved = false;
  String? phoneNo;
  String? TruckNo;
  String? imei;
  String? DriverName;
  var gpsData;
  var totalDistance;
  var device;

  TrackButton({
    required this.truckApproved,
    this.gpsData,
    this.phoneNo,
    this.TruckNo,
    this.DriverName,
    this.totalDistance,
    this.imei,
    this.device,
  });

  @override
  _TrackButtonState createState() => _TrackButtonState();
}

class _TrackButtonState extends State<TrackButton> {
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

    var logger = Logger();

    // logger.i("gpsData ${widget.gpsData}");
    // logger.i("gpsDataList ${widget.gpsData.last.latitude}");

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 90,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(darkBlueColor),
        ),
        onPressed: () async {
          Get.to(
            TrackScreen(
              deviceId: widget.gpsData.deviceId,
              gpsData: widget.gpsData,
              truckNo: widget.TruckNo,
              totalDistance: widget.totalDistance,
              imei: widget.imei,
              // online: widget.device.status == "online" ? true : false,
              online:true,
              active: true,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: space_2),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: space_1),
                child: widget.truckApproved
                    ? Container()
                    : Image(
                        height: 16,
                        width: 11,
                        image: AssetImage('assets/icons/lockIcon.png')),
              ),
              Text(
                'Track'.tr,
                style: TextStyle(
                  letterSpacing: 0.7,
                  fontWeight: normalWeight,
                  color: white,
                  fontSize: size_7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
