import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class PriceContainer extends StatelessWidget {
  String? rate;
  String? unitValue;

  PriceContainer({ required this.rate, required this.unitValue});

  @override
  Widget build(BuildContext context) {
    unitValue = unitValue == 'PER_TON' ? 'tonne'.tr : 'truck'.tr;
    return
     Center(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 7),
              child: Image(
                height: 18,
                width: 18,
                image: AssetImage('assets/icons/creditCard.png'),
              ),
            ),
            Text(
              "\u20B9$rate/$unitValue",
              style: TextStyle(
                  color: darkBlueColor,
                  fontWeight: mediumBoldWeight,
                  ),
            ),
          ],
        ),
      );


  }
}
