import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CallUs extends StatelessWidget {
  String number;

  CallUs({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: darkBlueColor))),
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: () {
          String url = 'tel:$number';
          UrlLauncher.launch(url);
        },
        child: Container(
          margin: EdgeInsets.only(left: space_1),
          padding: EdgeInsets.only(right: 10),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: space_1),
                child: Image(
                  height: 16,
                  width: 11,
                  image: AssetImage(
                    'assets/icons/callButtonIcon.png',
                  ),
                  color: black,
                ),
              ),
              Text(
                'callUs'.tr,
                // "Call Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0.7,
                  fontWeight: mediumBoldWeight,
                  color: black,
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
