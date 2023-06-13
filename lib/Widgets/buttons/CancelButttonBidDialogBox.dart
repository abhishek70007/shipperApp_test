import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class CancelButtonBidDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                      color: darkBlueColor))),
          backgroundColor:                MaterialStateProperty.all(Colors.white),
        ),
        onPressed: (){
          Navigator.pop(context);
        },
        child: Container(
          child: Text(
            'Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: mediumBoldWeight,
              color: black,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
