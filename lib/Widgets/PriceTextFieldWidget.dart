import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoadDetails.dart';
import 'package:provider/provider.dart';

class PriceTextFieldWidget extends StatelessWidget {
  const PriceTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(space_4, space_0, space_4, space_0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: space_2),
        height: space_8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space_6),
          border:
              Border.all(color: providerData.borderColor, width: borderWidth_8),
          color: widgetBackGroundColor,
        ),
        child: TextField(
          decoration: InputDecoration(
            hintStyle: TextStyle(color: providerData.borderColor),
            hintText: providerData.price.toString() == "0"
                ? providerData.hintText
                : providerData.price.toString(),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(space_6),
                borderSide:
                    BorderSide(color: darkBlueColor, width: borderWidth_8)),
            disabledBorder: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          controller: controller,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            if (providerData.PER_TON != providerData.PER_TRUCK) {
              if (providerData.price == 0) {
                providerData.updateHintText('enterprice'.tr
                    // "enter price"
                    );
                providerData.updateBorderColor(red);
              } else {
                providerData.updateHintText("0");
                providerData.updateBorderColor(darkBlueColor);
              }
            }
          },
          onChanged: (value) {
            if (value.length < 1) {
              providerData.updateResetActive(false);
              providerData.updatePrice(0);
              if (providerData.price == 0 &&
                  (providerData.unitValue != providerData.unitValue1)) {
                providerData.updateHintText('enterprice'.tr
                    // "enter price"
                    );
                providerData.updateBorderColor(red);
              } else if (providerData.unitValue == providerData.unitValue1) {
                providerData.updateHintText("0");
                providerData.updateBorderColor(darkBlueColor);
              }
            } else {
              providerData.updateResetActive(true);
              providerData.updateBorderColor(darkBlueColor);
              providerData.updatePrice(int.parse(value));
            }
          },
        ),
      ),
    );
  }
}
