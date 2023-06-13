import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class OrderSectionTitleName extends StatelessWidget {
  String name;
  OrderSectionTitleName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontWeight: normalWeight,
          fontSize: size_7,
          color: liveasyBlackColor,
          fontFamily: "Montserrat"),
    );
  }
}
