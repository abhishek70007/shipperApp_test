import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/controller/navigationIndexController.dart';
import '/functions/bidApiCalls.dart';
import '/models/biddingModel.dart';
import '/providerClass/providerData.dart';
import '/screens/navigationScreen.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CancelBidButton extends StatelessWidget {
  BiddingModel biddingModel;

  final bool? active;

  CancelBidButton({required this.biddingModel, required this.active});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(
              active! ? bidBackground : inactiveBidding),
        ),
        onPressed: active!
            ? () {
                declineBidFromTransporterSideSide(
                    bidId: biddingModel.bidId!,
                    approvalVariable: biddingModel.transporterApproval == true
                        ? 'transporterApproval'
                        : 'shipperApproval');
                Get.offAll(NavigationScreen());
                navigationIndexController.updateIndex(3);
              }
            : null,
        child: Container(
          child: Text(
            "cancel".tr,
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
