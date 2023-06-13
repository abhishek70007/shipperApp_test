import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';

class SearchLoadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      width: space_33,
      child: TextButton(
        child: Text(
          'Search Load',
          style: TextStyle(
              letterSpacing: 1,
              fontSize: size_9,
              color: white,
              fontWeight: mediumBoldWeight),
        ),
        onPressed: () {},
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius_6),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(truckGreen),
        ),
      ),
    );
  }
}
