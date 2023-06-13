import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatelessWidget {
  final bool condition;
  final String text;
  var onPressedConditionTrue;

  ElevatedButtonWidget(
      {required this.condition,
      required this.text,
      required this.onPressedConditionTrue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: space_4),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(space_6),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  condition ? activeButtonColor : deactiveButtonColor,
            ),
            onPressed: condition
                ? onPressedConditionTrue
                : null,
            child: SizedBox(
              height: space_8,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: white,
                      fontSize: size_8,
                      fontWeight: mediumBoldWeight),
                ),
              ),
            ),
          )),
    );
  }
}
