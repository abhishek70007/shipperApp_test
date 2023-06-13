import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MediumSizedButton extends StatelessWidget {
  dynamic onPressedFunction;
  String text;

  bool optional;

  MediumSizedButton(
      {required this.optional,
      required this.onPressedFunction,
      required this.text});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.053,
      width: MediaQuery.of(context).size.width * 0.3,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(optional
              ? darkBlueColor
              : providerData.resetActive
                  ? darkBlueColor
                  : lightGrayishBlue),
        ),
        onPressed: onPressedFunction,
        child: Text(
          '$text',
          style: TextStyle(
            letterSpacing: 0.7,
            fontWeight: FontWeight.w400,
            color: white,
            fontSize: size_8,
          ),
        ),
      ),
    );
  }
}
