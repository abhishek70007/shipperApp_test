import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';

class ToLoadPrefix extends StatelessWidget {
  const ToLoadPrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(space_0, space_0, space_2, space_0),
      height: space_2,
      width: space_2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space_10),
        border: Border.all(width: 3, color: Colors.red),
      ),
    );
  }
}
