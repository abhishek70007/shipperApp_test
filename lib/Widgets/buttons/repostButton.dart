import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';
import '/screens/myLoadPages/biddingScreen.dart';
import '/screens/PostLoadScreens/postloadnavigation.dart';

// ignore: must_be_immutable
class RepostButton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              )),
          backgroundColor: MaterialStateProperty.all<Color>(declineButtonRed),
        ),
        onPressed: () { Get.to(PostLoadNav()); },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0 , horizontal: space_5),
          child:  Text(
            'repost'.tr,
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: mediumBoldWeight,
              color: white,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
