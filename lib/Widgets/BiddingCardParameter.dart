import 'package:flutter/material.dart';
import '/constants/colors.dart';

class BiddingCardParameter extends StatelessWidget {
  String parameter;
  BiddingCardParameter({Key? key, required this.parameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      parameter,
      style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: liveasyBlackColor,
          fontFamily: "Montserrat"),
    );
  }
}
