import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
// import '/widgets/alertDialog/nextUpdateAlertDialog.dart';

class ReferAndEarnWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      // showDialog(
      //     context: context,
      //     builder: (context) => NextUpdateAlertDialog());
    },
        child: Container(
      height: 100,
      width: 180,
      padding: EdgeInsets.fromLTRB(space_2, space_2, 0, 0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/referAndEarnBackgroundImage.png"),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'refer'.tr,
            // "Refer And earn",
            style: TextStyle(
                fontSize: size_9, fontWeight: mediumBoldWeight, color: white),
          ),
          Row(
            children: [
              Text(
                "referUs".tr,
                // "Refer Liveasy to earn\npremium account",
                style: TextStyle(
                    fontSize: size_6, color: white, fontWeight: regularWeight),
              ),
              Container(
                height: space_13,
                width: space_9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/referAndEarnIcon.png"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
