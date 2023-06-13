import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/variables/truckFilterVariables.dart';

class LoadLabelValueColumnTemplate extends StatelessWidget {
  final String label;
  String value;

  LoadLabelValueColumnTemplate({required this.value, required this.label});

  TruckFilterVariables truckFilterVariables = TruckFilterVariables();

  @override
  Widget build(BuildContext context) {
    if (truckFilterVariables.truckTypeValueList.contains(value)) {
      value = truckFilterVariables.truckTypeTextList[
          truckFilterVariables.truckTypeValueList.indexOf(value)];
    }

    return Container(
      margin: EdgeInsets.only(top: space_1),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label',
            style: TextStyle(
                fontWeight: regularWeight,
                fontSize: size_6,
                color: liveasyBlackColor),
          ),
          Text(
            //TODO
            value != null ? '$value' : 'NA',
            style: TextStyle(
                fontWeight: mediumBoldWeight,
                fontSize: size_7,
                color: veryDarkGrey),
          ),
        ],
      ),
    );
  }
}
