import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/controller/CompletedDateController.dart';
import 'package:get/get.dart';

class CompletedTextField extends StatefulWidget {
  const CompletedTextField({Key? key}) : super(key: key);

  @override
  _CompletedTextFieldState createState() => _CompletedTextFieldState();
}

TextEditingController completedController = TextEditingController();
CompletedDateController completedDateController =
    Get.put(CompletedDateController());

class _CompletedTextFieldState extends State<CompletedTextField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 10, 0, 0));
    Jiffy nextDay = Jiffy(picked);

    String date = nextDay.date < 10
        ? "0${nextDay.date.toString()}"
        : nextDay.date.toString();
    String month = nextDay.month < 10
        ? "0${nextDay.month.toString()}"
        : nextDay.month.toString();
    String year = nextDay.year.toString();

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        completedController.text = "$date-$month-$year";
        completedDateController
            .updateCompletedDateController("$date-$month-$year");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(space_3, space_0, space_0, space_0),
      height: space_8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space_6),
        border: Border.all(color: darkBlueColor, width: borderWidth_8),
        color: widgetBackGroundColor,
      ),
      child: TextField(
        controller: completedController,
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                  right: size_4, top: size_2, bottom: size_2, left: size_4),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(space_10),
                    color: blueTitleColor),
                child: Icon(
                  Icons.calendar_today,
                  color: white,
                  size: space_3,
                ),
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Enter Date"),
        onTap: () {
          _selectDate(context);
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
