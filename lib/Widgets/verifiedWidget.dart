import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';

class VerifiedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_3,
      width: space_10 - 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_1 - 2),
        color: lightishGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            height: space_1 + 3,
            width: space_1 + 3,
            image: AssetImage("assets/icons/verifiedButtonIcon.png"),
          ),
          Text(
            "verified",
            style: TextStyle(fontWeight: normalWeight, fontSize: size_3 + 1),
          ),
        ],
      ),
    );
  }
}
