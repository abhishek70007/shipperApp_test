import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class AvailableLoadsTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
        height: space_5-3,
        child: Center(
        child: Text(
        "Available Loads",
        style: TextStyle(
        fontSize:  size_11,
              color: black,
              fontWeight: mediumBoldWeight),
        ),
      ),
    );
  }
}