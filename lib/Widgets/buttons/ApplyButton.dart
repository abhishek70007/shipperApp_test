import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/providerClass/providerData.dart';
import 'package:get/get.dart';
import '/screens/PostLoadScreens/loadConfirmation.dart';
import 'package:provider/provider.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ShipperIdController());

    ShipperIdController shipperIdController =
        Get.put(ShipperIdController());
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: space_20,
          height: space_8,
          margin: EdgeInsets.fromLTRB(space_8, space_4, space_8, space_0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(space_10),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: providerData.postLoadScreenTwoButton()
                      ? activeButtonColor
                      : deactiveButtonColor,
                ),
                child: Text(
                  'apply'.tr,
                  // AppLocalizations.of(context)!.apply,
                  style: TextStyle(
                    color: white,
                  ),
                ),
                onPressed: () {
                  print(providerData.totalTyresValue.toString());
                  print(providerData.passingWeightValue.toString());
                  print(providerData.productType.toString());
                  print(providerData.truckTypeValue.toString());
                  print(providerData.price.toString());
                  print(providerData.truckNumber.toString());
                  if (providerData.postLoadScreenTwoButton()) {
                    Get.to(() => LoadConfirmation());
                  } else {
                    return null;
                  }
                }),
          ),
        ),
      ],
    );
  }
}
