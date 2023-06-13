import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

// ignore: must_be_immutable
class AddTruckSubtitleText extends StatelessWidget {
  final String text;

  AddTruckSubtitleText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        color: liveasyGreen,
        fontWeight: mediumBoldWeight,
        fontSize: size_8,
      ),
    );
  }
}
