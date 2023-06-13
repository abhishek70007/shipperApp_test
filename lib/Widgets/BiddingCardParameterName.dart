import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

// ignore: must_be_immutable
class BiddingCardParameterName extends StatelessWidget {
  String paraName;
  BiddingCardParameterName({Key? key, required this.paraName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      paraName,
      style: TextStyle(
          fontWeight: mediumBoldWeight,
          fontSize: size_7,
          color: veryDarkGrey,
          fontFamily: "Montserrat"),
    );
  }
}
