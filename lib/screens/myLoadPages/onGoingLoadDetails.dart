import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/models/onGoingCardModel.dart';
import '/widgets/buttons/trackButton.dart';
import '/widgets/Header.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/loadPosterDetails.dart';
import '/widgets/newRowTemplate.dart';
import 'package:get/get.dart';

class OnGoingLoadDetails extends StatelessWidget {
  final OngoingCardModel loadALlDataModel;
  bool? trackIndicator = false;

  OnGoingLoadDetails({required this.loadALlDataModel, this.trackIndicator});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.all(space_4),
        child: Column(
          children: [
            Header(reset: false, text: "orderDetails".tr, backButton: true),
            Container(
              margin: EdgeInsets.only(top: space_4),
              child: Stack(
                children: [
                  LoadPosterDetails(
                    loadPosterLocation: loadALlDataModel.shipperLocation,
                    loadPosterName: loadALlDataModel.shipperName,
                    loadPosterCompanyName: loadALlDataModel.companyName,
                    loadPosterCompanyApproved:
                        loadALlDataModel.transporterApproved,
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
                            TrackButton(
                              truckApproved: trackIndicator!,
                            ),
                            CallButton(
                              directCall: false,
                              driverPhoneNum: loadALlDataModel.driverPhoneNum,
                              driverName: loadALlDataModel.driverName,
                              transporterPhoneNum:
                                  loadALlDataModel.shipperPhoneNum,
                              transporterName: loadALlDataModel.shipperName,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(space_3),
                child: Column(
                  children: [
                    NewRowTemplate(
                        label: "location".tr,
                        value:
                            '${loadALlDataModel.loadingPointCity} - ${loadALlDataModel.unloadingPointCity}'),
                    NewRowTemplate(
                        label: "truckNumber".tr,
                        value: loadALlDataModel.truckNo),
                    NewRowTemplate(
                        label: "truckType".tr,
                        value: loadALlDataModel.truckType),
                    NewRowTemplate(
                        label: "numberOfTrucks".tr,
                        value: loadALlDataModel.noOfTrucks),
                    NewRowTemplate(
                        label: "productType".tr,
                        value: loadALlDataModel.productType),
                    NewRowTemplate(
                        label: "price".tr,
                        value:
                            '${loadALlDataModel.rate}/${loadALlDataModel.unitValue}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
