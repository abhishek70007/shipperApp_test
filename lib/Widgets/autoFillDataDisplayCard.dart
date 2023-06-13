import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AutoFillDataDisplayCard extends StatelessWidget {
  String placeName;
  String placeCity;
  String? addresscomponent;
  String placeAddress;
  var onTap;

  AutoFillDataDisplayCard(
      this.placeName,
    this.addresscomponent,
    this.placeCity,
    this.placeAddress,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: space_12,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.5,
              color: greyBorderColor,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: space_2,
            bottom: space_2,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: space_1),
                child: Icon(
                  Icons.location_on_outlined,
                  color: darkBlueColor,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // height: 170,
                      child: Text(
                        '''$placeName'''.tr,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style:
                        TextStyle(fontSize: size_7, color: liveasyBlackColor),
                      ),
                    ),
                    Container(
                      child: Text(
                        addresscomponent==null?
                        placeAddress==placeCity?'$placeCity'.tr:'$placeCity'.tr + '$placeAddress'.tr:
                        '$addresscomponent'.tr+','+ '$placeCity'.tr+','+ '$placeAddress'.tr,
                        style: TextStyle(fontSize: size_6, color: darkGreyColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
