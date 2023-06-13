import 'package:flutter/material.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/acceptButton.dart';
import '/widgets/buttons/declineButton.dart';
import '/widgets/loadLabelValueRowTemplate.dart';
import 'package:get/get.dart';

class BiddingDecisionCard extends StatelessWidget {
  final String? rate;
  String? unitValue;
  String? loadId;
  final String? biddingDate;
  final String? bidId;
  final bool? shipperApproved;
  final bool? transporterApproved;
  bool? fromTransporterSide;

  BiddingDecisionCard(
      {required this.biddingDate,
      this.loadId,
      required this.transporterApproved,
      this.fromTransporterSide,
      required this.unitValue,
      required this.rate,
      required this.bidId,
      required this.shipperApproved});

  @override
  Widget build(BuildContext context) {
    unitValue = unitValue == 'PER_TON' ? "tonne".tr : "truck".tr;

    return Container(
      child: Card(
        elevation: 3,
        child: Container(
          margin: EdgeInsets.all(space_3),
          child: Column(
            children: [
              LoadLabelValueRowTemplate(
                  value: 'Rs.$rate/$unitValue', label: "bidding".tr),
              LoadLabelValueRowTemplate(
                  value: biddingDate, label: "biddingDate".tr),
              Container(
                margin: EdgeInsets.symmetric(vertical: space_2),
                child: Divider(
                  thickness: 2,
                ),
              ),
              fromTransporterSide!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AcceptButton(
                          isBiddingDetails: true,
                          bidId: bidId,
                          shipperApproved: shipperApproved,
                          transporterApproved: transporterApproved,
                          fromTransporterSide: fromTransporterSide,
                        ),
                        DeclineButton(
                          isBiddingDetails: true,
                          bidId: bidId,
                          shipperApproved: shipperApproved,
                          transporterApproved: transporterApproved,
                          fromTransporterSide: fromTransporterSide,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AcceptButton(
                          isBiddingDetails: true,
                          bidId: bidId,
                          loadId: loadId,
                          shipperApproved: shipperApproved,
                          transporterApproved: transporterApproved,
                          fromTransporterSide: fromTransporterSide,
                        ),
                        DeclineButton(
                          isBiddingDetails: true,
                          bidId: bidId,
                          loadId: loadId,
                          shipperApproved: shipperApproved,
                          transporterApproved: transporterApproved,
                          fromTransporterSide: fromTransporterSide,
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
