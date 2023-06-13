import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/models/loadDetailsScreenModel.dart';
import '/widgets/alertDialog/bidButtonAlertDialog.dart';
import '/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';

// ignore: must_be_immutable
class BidButton extends StatefulWidget {
  LoadDetailsScreenModel loadDetails;

  BidButton({required this.loadDetails});

  @override
  _BidButtonState createState() => _BidButtonState();
}

class _BidButtonState extends State<BidButton> {
  ShipperIdController sIdController = Get.put(ShipperIdController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (sIdController.companyStatus.value == 'verified') {
          await showDialog(
              context: context,
              builder: (context) => BidButtonAlertDialog(
                    isNegotiating: false,
                    isPost: true,
                    loadId: widget.loadDetails.loadId,
                  ));
        } else {
          showDialog(
              context: context,
              builder: (context) => VerifyAccountNotifyAlertDialog());
        }
      },
      child: Container(
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            'bids'.tr,
            // AppLocalizations.of(context)!.bids,
            style: TextStyle(
                color: white, fontWeight: normalWeight, fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
