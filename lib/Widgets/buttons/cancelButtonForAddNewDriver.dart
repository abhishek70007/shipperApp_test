import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class CancelButtonForAddNewDriver extends StatefulWidget {
  @override
  _CancelButtonForAddNewDriverState createState() =>
      _CancelButtonForAddNewDriverState();
}

class _CancelButtonForAddNewDriverState
    extends State<CancelButtonForAddNewDriver> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: darkBlueColor)),
        child: Center(
          child: Text(
            'cancel'.tr,
            // AppLocalizations.of(context)!.cancel,
            style: TextStyle(
                color: Colors.black,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
