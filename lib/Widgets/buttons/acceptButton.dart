import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/navigationIndexController.dart';
import '/functions/bidApiCalls.dart';
import '/providerClass/providerData.dart';
import '/screens/myLoadPages/biddingScreen.dart';
import '/screens/navigationScreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AcceptButton extends StatelessWidget {
  String? bidId;
  String? loadId;
  bool? isBiddingDetails;
  bool? shipperApproved;
  bool? transporterApproved;
  bool? fromTransporterSide;
  bool? activeButtonCondition;

  AcceptButton(
      {required this.bidId,
      required this.isBiddingDetails,
      this.shipperApproved,
      this.fromTransporterSide,
      this.loadId,
      this.transporterApproved});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    if (fromTransporterSide!) {
      activeButtonCondition =
          (transporterApproved == false && shipperApproved == true);
    } else {
      activeButtonCondition =
          (transporterApproved == true && shipperApproved == false);
    }

    // print('bid id : $bidId');
    return Container(
      height: isBiddingDetails! ? null : 31,
      width: isBiddingDetails! ? null : 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              activeButtonCondition! ? liveasyGreen : inactiveBidding),
        ),
        onPressed: activeButtonCondition!
            ? () {
                putBidForAccept(bidId);
                if (fromTransporterSide!) {
                  // providerData.updateIndex(3);
                  providerData.updateLowerAndUpperNavigationIndex(3, 0);
                  navigationIndexController.updateIndex(3);
                  Get.offAll(NavigationScreen());
                } else {
                  Get.offAll(NavigationScreen());
                  navigationIndexController.updateIndex(2);
                  Get.to(() => BiddingScreens(
                      loadId: loadId,
                      loadingPointCity: providerData.bidLoadingPoint,
                      unloadingPointCity: providerData.bidUnloadingPoint));
                }
              }
            : null,
        child: Container(
          margin: isBiddingDetails!
              ? EdgeInsets.symmetric(vertical: space_1, horizontal: space_3)
              : null,
          child: Text(
            "accept".tr,
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: mediumBoldWeight,
              color: white,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
