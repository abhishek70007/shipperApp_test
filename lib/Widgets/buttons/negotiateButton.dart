import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/widgets/alertDialog/bidButtonAlertDialog.dart';

// ignore: must_be_immutable
class NegotiateButton extends StatelessWidget {

  final String? bidId;

  final bool active;

  NegotiateButton(
      {
        required this.bidId,
        required this.active
      }
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 90,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
          backgroundColor: MaterialStateProperty.all<Color>(
              active ? darkBlueColor : inactiveBidding),
        ),
        onPressed: active
          ? () {
            showDialog(
                context: context,
                builder: (context) =>  BidButtonAlertDialog(
                  isNegotiating: true,
                  isPost: false ,
                  bidId:  bidId,
                )
            );
        }
        : null,
        child: Container(
          child : Text(
                'Negotiate',
                style: TextStyle(
                  fontWeight: normalWeight,
                  color: white,
                  fontSize: size_6,
                ),
              ),
        ),
      ),
    );
  }
}
