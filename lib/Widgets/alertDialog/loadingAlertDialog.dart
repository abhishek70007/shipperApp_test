import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/loadingWidget.dart';

class LoadingAlertDialog extends StatelessWidget {
  const LoadingAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LoadingWidget(),
              Text(
                "Loading!",
                style: TextStyle(
                    fontWeight: mediumBoldWeight,
                    fontSize: size_15,
                    color: liveasyBlackColor),
              ),
            ],
          )),
    );
  }
}
