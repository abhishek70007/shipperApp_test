import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/backButtonWidget.dart';
import 'package:provider/provider.dart';
import '/providerClass/providerData.dart';

// ignore: must_be_immutable
class Header extends StatefulWidget {
  final dynamic resetFunction;

  bool reset = true;
  bool backButton = true;
  final text;

  Header({this.resetFunction, required this.reset, required this.text , required this.backButton});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: space_2),
                child: widget.backButton ? BackButtonWidget() : SizedBox()),
            Text('${widget.text}',
                style: TextStyle(
                  fontSize: size_10,
                  fontWeight: mediumBoldWeight,
                )),
          ],
        ),
        widget.reset
            ? TextButton(
                onPressed:
                    providerData.resetActive ? widget.resetFunction : null,
                child: Text('reset'.tr,
                    style: TextStyle(
                      color: providerData.resetActive
                          ? liveasyGreen
                          : lightGrayishBlue,
                      fontSize: size_10,
                      fontWeight: regularWeight,
                    )))
            : SizedBox()
      ],
    );
  }
}
