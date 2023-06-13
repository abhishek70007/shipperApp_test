import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

// ignore: must_be_immutable
class TruckCompanyName extends StatelessWidget {
  String companyName;
  TruckCompanyName({Key? key, required this.companyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: size_3,
      ),
      child: Row(
        children: [
          const Image(image: AssetImage("assets/images/truck.png")),
          const SizedBox(
            width: 4,
          ),
          Text(
            companyName,
            style: TextStyle(
                fontWeight: mediumBoldWeight,
                fontSize: 14,
                color: veryDarkGrey,
                fontFamily: "Montserrat"),
          ),
        ],
      ),
    );
  }
}
