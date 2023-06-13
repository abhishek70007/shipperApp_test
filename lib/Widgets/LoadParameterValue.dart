import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class LoadParameterValue extends StatelessWidget {
  String paraValue;
  LoadParameterValue({Key? key, required this.paraValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      paraValue,
      style: TextStyle(
        fontSize: size_7,
        fontWeight: mediumBoldWeight,
        color: veryDarkGrey,
      ),
    );
  }
}
