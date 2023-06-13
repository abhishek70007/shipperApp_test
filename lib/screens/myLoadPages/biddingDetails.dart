import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/models/biddingModel.dart';
import '/widgets/Header.dart';
import '/widgets/biddingDesicionCard.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/buttons/negotiateButton.dart';
import '/widgets/loadPosterDetails.dart';
import 'package:get/get.dart';

//TODO:instead of destructuring bidding model we can pass it entirely
class BiddingDetails extends StatelessWidget {
  BiddingModel? biddingModel;
  bool? isLoadPosterVerified;
  bool? fromTransporterSide;
  final String? loadId;
  final String? bidId;
  final String? rate;
  final String? unitValue;
  final String? companyName;
  final String? biddingDate;
  final String? transporterPhoneNum;
  final String? transporterName;
  final String? transporterLocation;
  final bool? shipperApproved;
  final bool? transporterApproved;

  BiddingDetails({
    this.isLoadPosterVerified,
    this.biddingModel,
    this.fromTransporterSide,
    required this.loadId,
    required this.biddingDate,
    required this.unitValue,
    required this.rate,
    required this.companyName,
    required this.transporterPhoneNum,
    required this.bidId,
    required this.transporterName,
    required this.transporterLocation,
    required this.shipperApproved,
    required this.transporterApproved,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(vertical: space_4, horizontal: space_2),
          child: Column(
            children: [
              Header(reset: false, text: "biddingDetails".tr, backButton: true),
              Container(
                margin: EdgeInsets.symmetric(vertical: space_3),
                child: Stack(
                  children: [
                    LoadPosterDetails(
                      loadPosterLocation: transporterLocation != null
                          ? transporterLocation
                          : 'NA',
                      loadPosterName:
                          transporterName != null ? transporterName : 'NA',
                      loadPosterCompanyName:
                          companyName != null ? companyName : 'NA',
                      loadPosterCompanyApproved: isLoadPosterVerified != null
                          ? isLoadPosterVerified
                          : false,
                      imageUrl: "no profile",
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: space_6,
                          top: (space_14 * 2) + 3,
                          right: space_6),
                      child: Container(
                        // height: 51,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(space_1 + 3)),
                        child: Card(
                            color: white,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: space_2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  fromTransporterSide!
                                      ? NegotiateButton(
                                          active: false, bidId: bidId)
                                      : NegotiateButton(
                                          active: !shipperApproved!,
                                          bidId: bidId),
                                  CallButton(
                                    directCall: true,
                                    phoneNum: transporterPhoneNum,
                                  )
                                ],
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              BiddingDecisionCard(
                transporterApproved: transporterApproved,
                loadId: loadId,
                fromTransporterSide: fromTransporterSide,
                shipperApproved: shipperApproved,
                biddingDate: biddingDate,
                bidId: bidId,
                rate: rate,
                unitValue: unitValue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
