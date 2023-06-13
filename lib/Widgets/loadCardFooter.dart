import 'package:flutter/material.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/callButton.dart';

// ignore: must_be_immutable
class LoadCardFooter extends StatelessWidget {
  String? loadPosterCompanyName;
  String? loadPosterPhoneNo;

  LoadCardFooter({this.loadPosterCompanyName, this.loadPosterPhoneNo});

  @override
  Widget build(BuildContext context) {

    loadPosterCompanyName = loadPosterCompanyName!.length > 25 ? loadPosterCompanyName!.substring(0 , 22) + '..' : loadPosterCompanyName;
    return Container(
      height: 47,
      padding: EdgeInsets.symmetric(horizontal: space_3),
      color: contactPlaneBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: space_1),
                child: Image(
                  image: AssetImage("assets/icons/buildingIconBlack.png"),
                  height: size_8,
                  width: size_8 - 1,
                ),
              ),
              Text(
                "$loadPosterCompanyName",
                style:
                    TextStyle(fontSize: size_7, fontWeight: mediumBoldWeight),
              )
            ],
          ),
          CallButton(
            directCall: true,
            phoneNum: loadPosterPhoneNo,
          )
        ],
      ),
    );
  }
}
