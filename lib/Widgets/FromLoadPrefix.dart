import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';

class FromLoadPrefix extends StatelessWidget {
  const FromLoadPrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(space_0, space_0, space_2, space_0),
      height: space_2,
      width: space_2,
      decoration: BoxDecoration(
        color: flagGreen,
        borderRadius: BorderRadius.circular(space_20),
      ),
    );
  }
}
