import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/newRowTemplate.dart';

// ignore: must_be_immutable
class RequirementsLoadDetails extends StatelessWidget {
  Map loadDetails;

  RequirementsLoadDetails({required this.loadDetails});

  @override
  Widget build(BuildContext context) {
    loadDetails['unitValue'] =
        loadDetails['unitValue'] == 'PER_TON' ? 'tonne' : 'truck';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'requirement'.tr,
          // AppLocalizations.of(context)!.requirement,
          style: TextStyle(fontWeight: mediumBoldWeight, fontSize: size_7),
        ),
        Container(
          padding: EdgeInsets.only(left: space_3, right: space_3, top: space_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NewRowTemplate(
                  label: 'truckType'.tr,
                  // AppLocalizations.of(context)!.truckType,
                  value: loadDetails['truckType']),
              NewRowTemplate(
                  label: 'tyre'.tr,
                  // AppLocalizations.of(context)!.tyre,
                  value: loadDetails["noOfTyres"] == null
                      ? "NA"
                      : loadDetails["noOfTyres"]),
              NewRowTemplate(
                  label: 'weight'.tr,
                  // AppLocalizations.of(context)!.weight,
                  value: "${loadDetails['weight']} " +"tonnes".tr),
              NewRowTemplate(
                  label: 'productType'.tr,
                  // AppLocalizations.of(context)!.productType,
                  value: loadDetails['productType']),
              NewRowTemplate(
                  label: 'bidPrice'.tr,
                  // 'Bid Price',
                  value: "${loadDetails['rate']}/"+"${loadDetails['unitValue']}".tr),
            ],
          ),
        ),
      ],
    );
  }
}
