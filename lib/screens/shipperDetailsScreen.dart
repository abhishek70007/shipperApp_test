import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/functions/textOverFlow.dart';
import '/widgets/buttons/backButtonWidget.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/buttons/completedButton.dart';
import '/widgets/buttons/trackButton.dart';
import '/widgets/headingTextWidget.dart';
import '/widgets/loadLabelValueRowTemplate.dart';
import '/widgets/shipperPosterDetails.dart';
import 'package:get/get.dart';

class ShipperDetails extends StatefulWidget {
  String? loadingPoint;
  String? unloadingPoint;
  String? vehicleNo;
  String? rate;
  String? shipperPosterLocation;
  String? shipperPosterName;
  String? shipperPosterCompanyName;
  bool? shipperPosterCompanyApproved;
  String? posterName;
  String? truckType;
  String? noOfTrucks;
  String? productType;
  String bookingId;
  String? transporterPhoneNum;
  String? driverPhoneNum;
  String? driverName;
  String? transporterName;
  bool? trackApproved;
  var gpsDataList;
  String? totalDistance;

  ShipperDetails(
      {Key? key,
      this.posterName,
      this.truckType,
      this.noOfTrucks,
      this.productType,
      this.loadingPoint,
      this.unloadingPoint,
      this.vehicleNo,
      this.rate,
      this.shipperPosterLocation,
      this.shipperPosterName,
      this.shipperPosterCompanyName,
      this.shipperPosterCompanyApproved,
      required this.bookingId,
      this.transporterPhoneNum,
      this.driverPhoneNum,
      this.driverName,
      this.transporterName,
      this.trackApproved,
      this.gpsDataList,
      this.totalDistance})
      : super(key: key);

  @override
  _ShipperDetailsState createState() => _ShipperDetailsState();
}

class _ShipperDetailsState extends State<ShipperDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: space_2),
          child: Column(
            children: [
              SizedBox(
                height: space_4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButtonWidget(),
                  SizedBox(
                    width: space_3,
                  ),
                  HeadingTextWidget("orderDetails".tr),
                  // HelpButtonWidget(),
                ],
              ),
              SizedBox(
                height: space_3,
              ),
              Stack(
                children: [
                  ShipperPosterDetails(
                    shipperPosterCompanyApproved:
                        widget.shipperPosterCompanyApproved,
                    shipperPosterName: widget.shipperPosterName,
                    shipperPosterLocation: widget.shipperPosterLocation,
                    shipperPosterCompanyName: widget.shipperPosterCompanyName,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: space_8,
                        top: MediaQuery.of(context).size.height * 0.192,
                        right: space_8),
                    child: Container(
                      height: space_10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius_2 - 2)),
                      child: Card(
                        color: white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //TrackButton(truckApproved: widget.trackApproved!),
                            TrackButton(
                              truckApproved: widget.trackApproved!,
                              TruckNo: widget.vehicleNo,
                              DriverName: widget.driverName,
                              gpsData: widget.gpsDataList[0],
                              totalDistance: widget.totalDistance,
                            ),
                            CallButton(
                              directCall: false,
                              transporterPhoneNum: widget.transporterPhoneNum,
                              driverPhoneNum: widget.driverPhoneNum,
                              driverName: widget.driverName,
                              transporterName: widget.transporterName,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: space_5,
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(space_3, space_2, space_3, space_3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LoadLabelValueRowTemplate(
                          value: textOverflowEllipsis(
                              "${widget.loadingPoint}-${widget.unloadingPoint}",
                              20),
                          label: "location".tr),
                      LoadLabelValueRowTemplate(
                          value: widget.vehicleNo, label: "truckNumber".tr),
                      LoadLabelValueRowTemplate(
                          value: widget.truckType, label: "truckType".tr),
                      LoadLabelValueRowTemplate(
                          value: widget.noOfTrucks, label: "numberOfTrucks".tr),
                      LoadLabelValueRowTemplate(
                          value: widget.productType, label: "productType".tr),
                      LoadLabelValueRowTemplate(
                          value: "Rs.${widget.rate}/${"tonne".tr}",
                          label: "price".tr),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: space_2,
              ),
              widget.trackApproved == false
                  ? Container()
                  : CompletedButtonOrders(
                      bookingId: widget.bookingId,
                      fontSize: size_9,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
