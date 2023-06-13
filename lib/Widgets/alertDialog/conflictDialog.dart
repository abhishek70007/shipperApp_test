import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/alertOkButton.dart';

class ConflictDialog extends StatelessWidget {
  String dialog;
  ConflictDialog({Key? key, required this.dialog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dialog,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: mediumBoldWeight,
                    fontSize: size_8,
                    color: liveasyBlackColor),
              ),
              SizedBox(height: space_4),
              AlertOkButton()
            ],
          )),
    );
  }
}
