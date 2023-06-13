import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/navigationIndexController.dart';
import '/controller/shipperIdController.dart';
import '/functions/bidApiCalls.dart';
import '/providerClass/providerData.dart';
import '/screens/myLoadPages/biddingScreen.dart';
import '/screens/navigationScreen.dart';
import '/widgets/alertDialog/conflictDialog.dart';
import '/widgets/alertDialog/loadingAlertDialog.dart';
import '/widgets/alertDialog/CompletedDialog.dart';
import '/widgets/alertDialog/orderFailedAlertDialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BidButtonSendRequest extends StatelessWidget {
  String? loadId;
  String? bidId;
  bool? isPost;
  bool? isNegotiating;

  BidButtonSendRequest({
    this.loadId,
    this.bidId,
    required this.isPost,
    required this.isNegotiating,
  });

  ShipperIdController tIdController = Get.put(ShipperIdController());

  @override
  Widget build(BuildContext context) {
    ProviderData providerData =
        Provider.of<ProviderData>(context, listen: false);
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    getBidData() async {
      String? bidResponse = "";
      String? putResponse = "";
      if (bidResponse == "" || putResponse == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingAlertDialog();
          },
        );
      }

      isPost!
          ? bidResponse = await postBidAPi(loadId, providerData.rate1,
              tIdController.shipperId.value, providerData.unitValue1)
          : putResponse = await putBidForNegotiate(
              bidId, providerData.rate1, providerData.unitValue1);

      if (bidResponse == "success" || putResponse == "success") {
        print(bidResponse);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return completedDialog(
              upperDialogText: "You have completed the bid!",
              lowerDialogText: "wait for the shippers response",
            );
          },
        );
        Timer(
            Duration(seconds: 3),
            () => {
                  if (!isPost!)
                    {
                      Get.offAll(() => NavigationScreen()),
                      navigationIndexController.updateIndex(2),
                      Get.to(() => BiddingScreens(
                          loadId: loadId,
                          loadingPointCity: providerData.bidLoadingPoint,
                          unloadingPointCity: providerData.bidUnloadingPoint)),
                      providerData.updateBidButtonSendRequest(false),
                    }
                  else
                    {
                      providerData.updateUpperNavigatorIndex(0),
                      Get.offAll(() => NavigationScreen()),
                      navigationIndexController.updateIndex(3),
                      providerData.updateBidButtonSendRequest(false),
                    }
                });
      } else if (bidResponse == "conflict") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConflictDialog(
              dialog: 'you have already bid on this load',
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderFailedAlertDialog();
          },
        );
        // Get.snackbar("${postLoadErrorController.error.value}", "failed");
        // postLoadErrorController.resetPostLoadError();
        // print(postLoadErrorController.error.value.toString());
        // Timer(
        //     Duration(seconds: 1),
        //     () => {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return OrderFailedAlertDialog(
        //                   postLoadErrorController.error.value.toString());
        //             },
        //           )
        //         });
      }
    }

    return Container(
      margin: EdgeInsets.only(right: space_3),
      height: space_6 + 1,
      width: space_16,
      child: TextButton(
        child: Center(
          child: Text(
            "Bid",
            style: TextStyle(
                color: Colors.white,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
        onPressed: providerData.bidButtonSendRequestState
            ? () {
                getBidData();
              }
            : null,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius_4),
            )),
            overlayColor: providerData.bidButtonSendRequestState == true
                ? null
                : MaterialStateProperty.all(Colors.transparent),
            backgroundColor: providerData.bidButtonSendRequestState == true
                ? activeButtonColor
                : deactiveButtonColor),
      ),
    );
  }
}
