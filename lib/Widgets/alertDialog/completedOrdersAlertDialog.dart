import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/CompletedDateController.dart';
import '/widgets/buttons/OKButtonCompletedDate.dart';
import '/widgets/buttons/cancelCompletedDateButton.dart';
import 'package:get/get.dart';
import '../completedTextField.dart';

class CompletedOrdersAlertDialog extends StatefulWidget {
  final String bookingId;
  CompletedOrdersAlertDialog({Key? key, required this.bookingId})
      : super(key: key);

  @override
  _CompletedOrdersAlertDialogState createState() =>
      _CompletedOrdersAlertDialogState();
}

class _CompletedOrdersAlertDialogState
    extends State<CompletedOrdersAlertDialog> {
  @override
  void initState() {
    Get.put(CompletedDateController());
    Jiffy initialDay = Jiffy(DateTime.now());
    String idate = initialDay.date < 10
        ? "0${initialDay.date.toString()}"
        : initialDay.date.toString();
    String imonth = initialDay.month < 10
        ? "0${initialDay.month.toString()}"
        : initialDay.month.toString();
    String iyear = initialDay.year.toString();
    completedDateController
        .updateCompletedDateController("$idate-$imonth-$iyear");
    completedController.text = "$idate-$imonth-$iyear";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Completed Date",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          fontSize: size_9,
                          color: liveasyBlackColor),
                    ),
                    SizedBox(
                      height: space_3,
                    ),
                    CompletedTextField()
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OkButtonCompletedDate(bookingId: widget.bookingId),
                  SizedBox(width: space_4),
                  CancelCompletedDateButton(),
                ],
              )
            ],
          )),
    );
  }
}
