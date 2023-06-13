import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/functions/driverApiCalls.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddButton extends StatelessWidget {
  var onTap;
  String name;
  String number;

  //Instance  for DriverApiCalls
  DriverApiCalls driverApiCalls = DriverApiCalls();

  AddButton({this.onTap, required this.name, required this.number});

  List listDisplayContact = [];
  var driverName;
  var phoneNum;
  var transporterId;

  // var truckId;
  // shipperIdController tIdController = Get.put(shipperIdController());

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context);

    // if (displayContact.isEmpty == true || displayContact == "") {
    //   driverName = name;
    //   phoneNum = number;
    // } else {
    //   listDisplayContact = displayContact.split("-");
    //   driverName = listDisplayContact[0];
    //   phoneNum = displayContact.replaceAll(new RegExp(r"\D"), "");
    // }
    // transporterId = '${tIdController.transporterId}';
    // truckId = null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            'add'.tr,
            // AppLocalizations.of(context)!.add,
            style: TextStyle(
                color: white, fontWeight: normalWeight, fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
