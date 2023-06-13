import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class NoCardDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: space_7,
        ),
        Image(
          image: AssetImage("assets/icons/errorIcon.png"),
          height: size_15 + 6,
          width: size_15 + 11,
        ),
        SizedBox(
          height: space_3,
        ),
        Text(
          "Sorry! We could not find a load",
          style: TextStyle(
              color: veryDarkGrey, fontWeight: regularWeight, fontSize: size_8),
        ),
        Text(
          "on this route",
          style: TextStyle(
              color: veryDarkGrey, fontWeight: regularWeight, fontSize: size_8),
        )
      ],
    );
  }
}
