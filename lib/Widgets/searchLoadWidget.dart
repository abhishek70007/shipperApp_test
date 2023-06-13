import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class SearchLoadWidget extends StatelessWidget {
  final String hintText;
  dynamic onPressed;

  SearchLoadWidget({required this.hintText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: space_8,
      decoration: BoxDecoration(
        color: widgetBackGroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 0.8,
          // color: borderBlueColor,
        ),
      ),
      child: TextField(
        onTap: onPressed,
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "$hintText",
          icon: Padding(
            padding: EdgeInsets.only(left: space_2),
            child: Icon(
              Icons.search,
              color: grey,
            ),
          ),
          hintStyle: TextStyle(
            fontSize: size_8,
            color: grey,
          ),
        ),
      ),
    );
  }
}
