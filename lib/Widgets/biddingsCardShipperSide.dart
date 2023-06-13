import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/isOtpInvalidController.dart';
import '/screens/myLoadPages/biddingDetails.dart';
import '/widgets/buttons/acceptButton.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/buttons/negotiateButton.dart';
import '/widgets/loadLabelValueRowTemplate.dart';
import '/widgets/newRowTemplate.dart';
import '/widgets/priceContainer.dart';

import 'LoadEndPointTemplate.dart';
import 'linePainter.dart';

class BiddingsCardShipperSide extends StatelessWidget {
  final String? loadId;
  final String? bidId;
  final String? loadingPointCity;
  final String? unloadingPointCity;
  final String? currentBid;
  final String? previousBid;
  String? unitValue;
  final String? companyName;
  final String? biddingDate;
  final String? transporterPhoneNum;
  final String? transporterName;
  final String? transporterLocation;
  final bool? shipperApproved;
  final bool? transporterApproved;
  final bool? isLoadPosterVerified;
  String orderStatus = '';
  Color orderStatusColor = Colors.white;

  BiddingsCardShipperSide({
    required this.loadId,
    required this.isLoadPosterVerified,
    required this.loadingPointCity,
    required this.unloadingPointCity,
    required this.biddingDate,
    required this.unitValue,
    required this.currentBid,
    required this.previousBid,
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
    unitValue = unitValue == 'PER_TON' ? 'tonne' : 'truck';

    if (transporterApproved == true && shipperApproved == true) {
      orderStatus = 'Order confirmed!';
      orderStatusColor = liveasyGreen;
    } else if (transporterApproved == false && shipperApproved == true) {
      orderStatus = 'Waiting for response';
      orderStatusColor = liveasyOrange;
    } else if (transporterApproved == false && shipperApproved == false) {
      orderStatus = 'Order Cancelled';
      orderStatusColor = red;
    }

    return GestureDetector(
      onTap: shipperApproved == false && transporterApproved == false
          ? null
          : () {
              Get.to(() => BiddingDetails(
                    loadId: loadId,
                    bidId: bidId,
                    rate: currentBid,
                    unitValue: unitValue,
                    companyName: companyName,
                    biddingDate: biddingDate,
                    transporterPhoneNum: transporterPhoneNum,
                    transporterName: transporterName,
                    transporterLocation: transporterLocation,
                    shipperApproved: shipperApproved,
                    transporterApproved: transporterApproved,
                    isLoadPosterVerified: isLoadPosterVerified,
                    fromTransporterSide: false,
                  ));
            },
      child: Container(
        margin: EdgeInsets.only(bottom: space_2),
        child: Card(
          elevation: 3,
          child: Container(
            color: shipperApproved == false && transporterApproved == false
                ? cancelledBiddingBackground
                : Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bidding date : $biddingDate',
                              style: TextStyle(
                                  fontSize: size_6, color: veryDarkGrey),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoadEndPointTemplate(
                              text: loadingPointCity, endPointType: 'loading'),
                          Container(
                              padding: EdgeInsets.only(left: 2),
                              height: space_3,
                              width: space_12,
                              child: CustomPaint(
                                foregroundPainter: LinePainter(height: space_3),
                              )),
                          LoadEndPointTemplate(
                              text: unloadingPointCity,
                              endPointType: 'unloading'),
                        ],
                      ),
                      SizedBox(
                        height: space_2,
                      ),
                      NewRowTemplate(
                        label: 'Transporter',
                        value: companyName!.length > 24
                            ? companyName!.substring(0, 22) + '..'
                            : companyName,
                        width: 102,
                      ),
                      previousBid != 'NA'
                          ? NewRowTemplate(
                              label: 'Previous Bidding',
                              value: 'Rs.$previousBid/$unitValue')
                          : Container(),
                      NewRowTemplate(
                        label: 'Current Bidding',
                        value: 'Rs.$currentBid/$unitValue',
                        width: 102,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: space_2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              orderStatus,
                              style: TextStyle(
                                color: orderStatusColor,
                                fontWeight: mediumBoldWeight,
                                fontSize: size_8,
                              ),
                            ),
                            CallButton(
                              directCall: true,
                              phoneNum: transporterPhoneNum,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                shipperApproved == false && transporterApproved == false
                    ? Container()
                    : Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        color: contactPlaneBackground,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NegotiateButton(
                              bidId: bidId,
                              active: !shipperApproved!,
                            ),
                            AcceptButton(
                              isBiddingDetails: false,
                              bidId: bidId,
                              loadId: loadId,
                              fromTransporterSide: false,
                              transporterApproved: transporterApproved,
                              shipperApproved: shipperApproved,
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
