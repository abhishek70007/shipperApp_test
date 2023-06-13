import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/controller/postLoadVariablesController.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

class AddCalender extends StatefulWidget {
  final String text;
  final String value;
  bool selected = false;
  AddCalender({Key? key, required this.text, required this.value})
      : super(key: key);

  @override
  _AddCalenderState createState() => _AddCalenderState();
}

class _AddCalenderState extends State<AddCalender> {
  PostLoadVariablesController postLoadVariables = Get.put(PostLoadVariablesController());
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return OutlinedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(2),
          backgroundColor: postLoadVariables.bookingDate.value == widget.value
              ? MaterialStateProperty.all(darkBlueColor)
              : MaterialStateProperty.all(whiteBackgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ))),
      child: Text(
        widget.text,
        style: TextStyle(
            fontWeight: normalWeight,
            fontSize: widget.text == 'High-Cube Container' ||
                    widget.text == 'Standard Container'
                ? size_6
                : size_7,
            color: postLoadVariables.bookingDate.value == widget.text ? white : black),
      ),
      onPressed: () {
        providerData.updateResetActive(true);
        postLoadVariables.updateBookingDate(widget.value);
      },
    );
  }
}
