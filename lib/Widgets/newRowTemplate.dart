import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class NewRowTemplate extends StatelessWidget {
  final String? label;
  final String? value;
  double? width;

  NewRowTemplate({ required this.label , required this.value , this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: space_1),
      child: Row(
        children: [
          Container(
            width: width,
            child: Text(
              label!,
              style: TextStyle(
                fontSize: size_6,
              ),
            ),
          ),
          Text(
            ' : ${value!}',
            style: TextStyle(
              color: veryDarkGrey,
              fontWeight: mediumBoldWeight,
              fontSize: size_6,
            ),
          )
        ],
      ),
    );
  }
}
