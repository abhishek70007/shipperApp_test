import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class BiddingsTitleTextWidget extends StatelessWidget {
  const BiddingsTitleTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Biddings",
      style: TextStyle(
          fontSize: size_10,
          color: blueTitleColor,
          fontWeight: mediumBoldWeight,
          fontFamily: "Montserrat"),
    );
  }
}
