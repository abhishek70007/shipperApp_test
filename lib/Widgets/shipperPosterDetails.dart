import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/widgets/unverifiedWidget.dart';
import '/widgets/verifiedWidget.dart';

class ShipperPosterDetails extends StatefulWidget {
  String? shipperPosterLocation;
  String? shipperPosterName;
  String? shipperPosterCompanyName;
  bool? shipperPosterCompanyApproved;
  ShipperPosterDetails({
    Key? key,
    this.shipperPosterLocation,
    this.shipperPosterName,
    this.shipperPosterCompanyName,
    this.shipperPosterCompanyApproved,
  }) : super(key: key);

  @override
  _ShipperPosterDetailsState createState() => _ShipperPosterDetailsState();
}

class _ShipperPosterDetailsState extends State<ShipperPosterDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.225,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius_2 - 2),
        color: darkBlueColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: space_2, right: space_3),
            child: CircleAvatar(
              radius: radius_11,
              backgroundImage:
                  AssetImage("assets/images/defaultDriverImage.png"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  "${widget.shipperPosterName}",
                  style: TextStyle(
                      fontWeight: mediumBoldWeight,
                      color: white,
                      fontSize: size_9),
                ),
              ),
              SizedBox(
                height: space_1,
              ),
              Row(
                children: [
                  Image(
                    image: AssetImage("assets/icons/TruckIcon.png"),
                    height: space_3 + 1,
                    width: space_3,
                  ),
                  SizedBox(
                    width: space_1 - 2,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      "${widget.shipperPosterCompanyName}",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          color: white,
                          fontSize: size_6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: space_1,
              ),
              Row(
                children: [
                  Container(
                    height: space_3,
                    width: space_3 - 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/icons/locationIcon.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: space_1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      "${widget.shipperPosterLocation}",
                      style: TextStyle(
                          fontWeight: normalWeight,
                          color: white,
                          fontSize: size_6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: space_1 + 1,
              ),
              widget.shipperPosterCompanyApproved!
                  ? VerifiedWidget()
                  : UnverifiedWidget()
            ],
          ),
        ],
      ),
    );
  }
}
