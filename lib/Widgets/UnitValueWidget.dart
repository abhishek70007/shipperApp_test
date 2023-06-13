import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

class UnitValueWidget extends StatelessWidget {
  const UnitValueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Padding(
      padding: EdgeInsets.only(left: space_4),
      child: Row(
        children: [
          OutlinedButton(
            style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(2),
            backgroundColor: providerData.PER_TRUCK
                ? MaterialStateProperty.all(darkBlueColor)
                : MaterialStateProperty.all(whiteBackgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ))),
            onPressed: () {
          if (!providerData.PER_TRUCK) {
            providerData.PerTruckTrue(true, false);
            providerData.updateResetActive(true);
            if (providerData.price == 0) {
              providerData.updateHintText('enterprice'.tr
                  // "enter price"
                  );
              providerData.updateBorderColor(red);
            }
          } else {
            providerData.updateResetActive(false);
            providerData.PerTruckTrue(false, false);
            providerData.updateBorderColor(darkBlueColor);
          }
            },
            child: Text(
          'perTruck'.tr,
          // AppLocalizations.of(context)!.perTruck,
          style: TextStyle(
              fontSize: size_7,
              fontWeight: regularWeight,
              color: providerData.PER_TRUCK ? white : black),
            ),
          ),
          SizedBox(width: space_8),
          OutlinedButton(
            style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(2),
            backgroundColor: providerData.PER_TON
                ? MaterialStateProperty.all(darkBlueColor)
                : MaterialStateProperty.all(whiteBackgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ))),
            onPressed: () {
          if (!providerData.PER_TON) {
            providerData.PerTonTrue(true, false);
            providerData.updateResetActive(true);
            if (providerData.price == 0) {
              providerData.updateHintText('enterprice'.tr
                  // "enter price"
                  );
              providerData.updateBorderColor(red);
            }
          } else {
            providerData.updateResetActive(false);
            providerData.PerTonTrue(false, false);
            providerData.updateBorderColor(darkBlueColor);
          }
            },
            child: Text(
          'perTon'.tr,
          // AppLocalizations.of(context)!.perTon,
          style: TextStyle(
              fontSize: size_7,
              fontWeight: regularWeight,
              color: providerData.PER_TON ? white : black),
            ),
          ),
        ],
      ),
    );
  }
}
