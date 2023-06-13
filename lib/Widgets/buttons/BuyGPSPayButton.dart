import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/buyGPSboolController.dart';
import '/functions/buyGPSApiCalls.dart';
import '/widgets/alertDialog/CompletedDialog.dart';
import '/widgets/alertDialog/sameTruckAlertDialogBox.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuyGPSPayButton extends StatelessWidget {
  bool isDisable = false;
  BuyGPSHudController updateButtonController = Get.put(BuyGPSHudController());
  // final String buyGPSApiUrl = FlutterConfig.get('buyGPSApiUrl');
  final String buyGPSApiUrl = dotenv.get('buyGpsApiUrl');

  BuyGPSApiCalls buyGPSApiCalls = BuyGPSApiCalls();
  String? groupValue;
  String? gpsId;
  String? durationGroupValue;
  bool locationPermissionis;
  String? currentAddress;
  String? truckID;
  var context;

  BuyGPSPayButton({
    Key? key,
    required this.groupValue,
    required this.durationGroupValue,
    required this.locationPermissionis,
    required this.currentAddress,
    required this.truckID,
    required this.context
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      width: (space_20 + space_40),
      margin: EdgeInsets.only(bottom: space_2),
      child: Obx(() => TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      isDisable
                          ? bidBackground
                          : updateButtonController.updateButton.value
                          ? bidBackground
                          : solidLineColor
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius_6)
                      )
                  )
              ),
              onPressed: updateButtonController.updateButton.value
                  ? () => _payButtonFunction()
                  : null,
              child: updateButtonController.updateButton.value
                  ? Text(
                "Pay $groupValue",
                style: TextStyle(
                  color: greyishWhiteColor,
                  fontWeight: mediumBoldWeight,
                  fontSize: size_9,
                ),
                textAlign: TextAlign.center,
              )
                  : Text(
                "Pay NA",
                style: TextStyle(
                  color: greyishWhiteColor,
                  fontWeight: mediumBoldWeight,
                  fontSize: size_9,
                ),
                textAlign: TextAlign.center,
              )
          ),
      ),
    );
  }
  _payButtonFunction() async {
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
    gpsId = await buyGPSApiCalls.postByGPSData(
        rate: groupValue,
        duration: durationGroupValue,
        address: locationPermissionis
            ? currentAddress
            : "Location not Available",
        truckId: truckID);
    if (gpsId != null) {
      EasyLoading.dismiss();
      showDialog(
          context: context,
          builder: (context) => completedDialog(
            upperDialogText: "You’ve purchased GPS",
            lowerDialogText: "successfully!",
          ));
      Timer(Duration(seconds: 3),
              () => {Get.back()});
    } else {
      EasyLoading.dismiss();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return SameTruckAlertDialogBox();
          });
    }
  }
}
