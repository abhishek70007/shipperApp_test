import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/models/loadDetailsScreenModel.dart';
import '/widgets/sharerequirementsLoadDetailsWidget.dart';

class shareImageWidget extends StatelessWidget {
  LoadDetailsScreenModel loadDetails;
  shareImageWidget(this.loadDetails);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (space_40 * 3) + space_2,
      width: (space_18 * 4) - space_2,
      decoration: BoxDecoration(
          color: darkBlueColor, borderRadius: BorderRadius.circular(space_2)),
      child: Column(
        children: [
          SizedBox(
            height: space_4,
          ),
          Image.asset(
            "assets/icons/liveasyicon.png",
            width: 37,
            height: 26,
          ),
          SizedBox(
            height: space_2,
          ),
          Text(
            "welcomeTo".tr,
            style: TextStyle(
                color: white, fontWeight: mediumBoldWeight, fontSize: size_9),
          ),
          Text(
            "bookings that made your life easy".tr,
            style: TextStyle(
                color: white, fontWeight: mediumBoldWeight, fontSize: size_7),
          ),
          SizedBox(
            height: space_5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/leftyellowtruckicon.png",
                  width: space_10, height: space_10),
              SizedBox(
                width: space_2 - 1,
              ),
              Text(
                "Chalo iss load ko book\nkaren".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: size_7,
                  fontWeight: boldWeight,
                ),
              ),
              SizedBox(
                width: space_2 - 1,
              ),
              Image.asset("assets/icons/rightyellowtruckicon.png",
                  width: space_10, height: space_10),
            ],
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            width: (space_29 * 2),
            height: 1,
            decoration: BoxDecoration(color: lineGreyColor),
          ),
          SizedBox(
            height: (space_2 + 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${loadDetails.loadingPointCity}".tr,
                style: TextStyle(
                    color: white, fontSize: size_10, fontWeight: boldWeight),
              ),
              SizedBox(width: (space_1 - 2)),
              Text(
                "("+ "${loadDetails.loadingPointState}".tr +")",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: (space_2 + 2),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/icons/greenFilledCircleIcon.png",
                  width: space_2, height: space_2),
              SizedBox(
                height: (space_2 - 2),
              ),
              Container(
                width: 1,
                height: (space_5 + 3),
                decoration: BoxDecoration(color: white),
              ),
              SizedBox(
                height: (space_2 - 2),
              ),
              Image.asset("assets/icons/redSemiFilledCircleIcon.png",
                  width: space_2, height: space_2),
            ],
          ),
          SizedBox(
            height: space_2 + 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${loadDetails.unloadingPointCity}".tr,
                style: TextStyle(
                    color: white, fontSize: size_10, fontWeight: boldWeight),
              ),
              SizedBox(width: (space_1 - 2)),
              Text(
                "("+"${loadDetails.unloadingPointState}".tr +")",
                style: TextStyle(
                    color: white, fontWeight: regularWeight, fontSize: size_9),
              )
            ],
          ),
          SizedBox(
            height: space_5,
          ),
          ShareRequirementsLoadDetails(
            loadDetails: {
              "truckType": loadDetails.truckType?.tr,
              "weight": loadDetails.weight?.tr,
              "productType": loadDetails.productType?.tr,
              "rate": loadDetails.rate?.tr,
              "unitValue": loadDetails.unitValue?.tr,
            },
          ),
          SizedBox(
            height: space_4,
          ),
          Text(
            "Hurry up and book this load for your truck!!!".tr,
            style: TextStyle(
                color: white, fontSize: size_6, fontWeight: fontWeight500),
          ),
          SizedBox(
            height: space_4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: space_8,
                height: 1,
                decoration: BoxDecoration(color: white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9, right: 9),
                child: Text(
                  "For bookings and more details click\nthe link below".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white,
                      fontSize: size_6,
                      fontWeight: fontWeight500),
                ),
              ),
              Container(
                width: space_8,
                height: 1,
                decoration: BoxDecoration(color: white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
