import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class ElevatedButtonWidgetTwo extends StatelessWidget {
  final bool condition;
  final String text;
  var onPressedConditionTrue;

  ElevatedButtonWidgetTwo(
      {required this.condition,
      required this.text,
      required this.onPressedConditionTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: space_4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(space_5),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  condition ? activeButtonColor : deactiveButtonColor,
            ),
            child: Container(
              height: space_10,
              width: space_34,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: white,
                      fontSize: size_11,
                      fontWeight: mediumBoldWeight),
                ),
              ),
            ),
            onPressed: condition ? onPressedConditionTrue : null,
          )),
    );
  }
}
