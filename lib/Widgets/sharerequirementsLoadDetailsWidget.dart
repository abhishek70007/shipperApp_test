import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/shareRowTemplate.dart';

// ignore: must_be_immutable
class ShareRequirementsLoadDetails extends StatelessWidget {
  Map loadDetails;

  ShareRequirementsLoadDetails({required this.loadDetails});

  @override
  Widget build(BuildContext context) {
    loadDetails['unitValue'] =
        loadDetails['unitValue'] == 'PER_TON' ? 'tonne'.tr : 'truck'.tr;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "requirement".tr,
                style: TextStyle(
                    fontSize: size_7,
                    fontWeight: mediumBoldWeight,
                    color: white),
              ),
              SizedBox(
                height: space_2,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: space_3, right: space_3, top: space_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shareNewRowTemplate(
                  label: 'truckType'.tr, value: loadDetails['truckType']),
              shareNewRowTemplate(
                  label: 'weight'.tr, value: "${loadDetails['weight']}" +"tonnes".tr),
              shareNewRowTemplate(
                  label: 'productType'.tr, value: loadDetails['productType']),
              shareNewRowTemplate(
                  label: 'bidPrice'.tr,
                  value: "${loadDetails['rate']}/${loadDetails['unitValue'.tr]}"),
            ],
          ),
        ),
      ],
    );
  }
}
