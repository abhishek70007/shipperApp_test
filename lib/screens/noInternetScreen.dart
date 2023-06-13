import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class NoInternetConnection {
  static Column noInternetDialogue() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/wifi.gif',
          width: space_23,
          height: space_23,
        ),
        SizedBox(
          height: 3,
        ),
        Text(
          'Ooops!',
          style: TextStyle(
            fontWeight: mediumBoldWeight,
            
            fontSize: size_9,
            color: black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: space_1,
        ),
        Text(
          'Slow or no internet connection.\n Check your network connection and \n try again.',
          style: TextStyle(
              
              fontWeight: normalWeight,
              fontSize: size_6,
              color: grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
