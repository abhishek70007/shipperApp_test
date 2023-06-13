import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/widgets/alertDialog/nextUpdateAlertDialog.dart';

class FilterButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context, builder: (context) => NextUpdateAlertDialog());
      },
      child: Container(
        height: space_6,
        width: space_16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: borderWidth_10, color: darkBlueColor)),
        padding: EdgeInsets.only(left: space_3),
        child: Center(
          child: Row(
            children: [
              Container(
                height: space_3,
                width: space_3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/filterIcon.png"))),
              ),
              SizedBox(
                width: space_1,
              ),
              Text(
                'filter'.tr,
                // AppLocalizations.of(context)!.filter,
                style: TextStyle(fontSize: size_7, color: darkBlueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
