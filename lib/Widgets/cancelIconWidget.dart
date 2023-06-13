import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';

class CancelIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_4,
      width: space_4,
      child: Center(
        child: Icon(
          Icons.cancel_rounded,
          color: darkBlueColor,
        ),
      ),
    );
  }
}
