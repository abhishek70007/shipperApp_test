import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/widgets/buttons/CancelButttonBidDialogBox.dart';
import '/widgets/buttons/bidButtonSendRequest.dart';
import '/widgets/buttons/CancelSelectedTruckDriverButton.dart';
import 'package:provider/provider.dart';

enum RadioButtonOptions { PER_TON, PER_TRUCK }

// ignore: must_be_immutable
class BidButtonAlertDialog extends StatefulWidget {
  String? loadId;
  String? bidId;
  bool? isPost;
  bool? isNegotiating;

  BidButtonAlertDialog({this.loadId, this.bidId, required this.isPost ,  required this.isNegotiating});

  @override
  _BidButtonAlertDialogState createState() => _BidButtonAlertDialogState();
}

class _BidButtonAlertDialogState extends State<BidButtonAlertDialog> {

  RadioButtonOptions unitValue = RadioButtonOptions.PER_TON;


  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: space_4),
      title: Text(
        "Please enter your rate",
        style: TextStyle(fontSize: size_9, fontWeight: normalWeight, color: liveasyBlackColor),
      ),
      titlePadding: EdgeInsets.only(top: space_3, left: space_3),
      contentPadding: EdgeInsets.symmetric(horizontal: space_3),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(right: space_3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      unitValue = RadioButtonOptions.PER_TON;
                    });
                  },
                  child: Row(
                    children: [
                      Radio<RadioButtonOptions>(
                          value: RadioButtonOptions.PER_TON,
                          activeColor: darkBlueColor,
                          groupValue: unitValue,
                          onChanged: (value) {
                            setState(() {
                              unitValue = value!;
                            });
                          }),
                      Text(
                        "Per Tonne",
                        style: TextStyle(
                            fontWeight: mediumBoldWeight,
                            fontSize: size_7,
                            color: darkBlueColor),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      unitValue = RadioButtonOptions.PER_TRUCK;
                      print(unitValue);
                    });
                  },
                  child: Row(
                    children: [
                      Radio<RadioButtonOptions>(
                          value: RadioButtonOptions.PER_TRUCK,
                          activeColor: darkBlueColor,
                          groupValue: unitValue,
                          onChanged: (value) {
                            setState(() {
                              print(value);
                              unitValue = value!;
                            });
                          }),
                      Text(
                        "Per Truck",
                        style: TextStyle(
                            fontWeight: mediumBoldWeight,
                            fontSize: size_7,
                            color: darkBlueColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: space_2,),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4+2),
                border: Border.all(color: darkGreyColor)),
            child: Container(
              height: space_7+2,
              padding: EdgeInsets.only(
                left: space_3,
                right: space_3,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                // controller: rate,
                decoration: InputDecoration(
                  hintText: "Eg 4000",
                  hintStyle: TextStyle(color: textLightColor),
                  border: InputBorder.none,
                ),
                onChanged: (String? rate) {
                  if (rate == null || rate == "") {
                    providerData.updateBidButtonSendRequest(false);
                  } else {
                    //TODO: bug: if we change unt value without changing rate then previous unitValue will be passed
                    providerData.updateRate(rate , unitValue.toString());
                    providerData.updateBidButtonSendRequest(true);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: space_2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BidButtonSendRequest(
                isNegotiating: widget.isNegotiating,
                loadId: widget.loadId ,
                bidId: widget.bidId,
                isPost: widget.isPost,
              ),
              CancelButtonBidDialogBox(),
            ],
          ),
        )
      ],
      buttonPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.only(top: space_4, bottom: space_3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
    );
  }
}
