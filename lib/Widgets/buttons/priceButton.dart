import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class PriceButtonWidget extends StatelessWidget {
  String? rate;
  String? unitValue;

  PriceButtonWidget({this.rate, this.unitValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      padding: EdgeInsets.all(space_2-1),
      decoration: BoxDecoration(
          color: lightGrayishBlue, borderRadius: BorderRadius.circular(5)),
      // height: 35,
      // width: 110,
      child: Center(
        child: Text(
          "\u20B9$rate/$unitValue",
          style: TextStyle(
              color: darkBlueColor,
              fontWeight: mediumBoldWeight,
              fontSize: size_7),
        ),
      ),
    );
  }
}
