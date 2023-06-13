import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class UnverifiedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_3,
      width: space_10 - 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.81),
        color: liveasyOrange,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "unverified",
            style: TextStyle(fontWeight: normalWeight, fontSize: size_3 + 1),
          ),
        ],
      ),
    );
  }
}
