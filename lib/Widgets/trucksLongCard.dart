import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/models/truckModel.dart';

class TrucksLongCard extends StatelessWidget {
  final Border? borderCard;
  final TruckModel truckData;

  TrucksLongCard({
    required this.truckData,
    required this.borderCard
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Container(
        padding: EdgeInsets.only(left: space_2),
        width: (space_20 + space_40),
        height: space_12,
        decoration: BoxDecoration(
          border: borderCard,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                spreadRadius: 0,
                blurRadius: radius_2,
                offset: Offset(0, (space_2 - 2)), // changes position of shadow
              ),
            ],
            color: greyishWhiteColor,
            borderRadius: BorderRadius.circular(radius_2 - 2)
        ),
        child: Row(
          children: [
            Image(
              image: AssetImage(
                  'assets/images/TruckListEmptyImage.png'
              ),
              height: (space_7 - 2),
              width: (space_7 - 2),
            ),
            SizedBox(
              width: space_4,
            ),
            Text("${truckData.truckNo}"),
          ],
        ),
      ),
    );
  }
}
