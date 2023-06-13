import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/alertOkButton.dart';

class OrderFailedAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          height: MediaQuery.of(context).size.height / 3.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage("assets/images/alert.png"),
                width: space_10,
                height: space_10,
              ),
              SizedBox(height: space_4),
              Text(
                "Something went Wrong.\nPlease Try Again!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: normalWeight, fontSize: size_8, color: red),
              ),
              SizedBox(height: space_3),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: AlertOkButton(),
              )
            ],
          )),
    );
  }
}
