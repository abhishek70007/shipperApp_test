import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';

class CancelLogoutButton extends StatelessWidget {
  const CancelLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius_4),
                  side: const BorderSide(color: darkBlueColor))),
          backgroundColor:
              MaterialStateProperty.all(Colors.white.withOpacity(0)),
        ),
        onPressed: () {
          kIsWeb?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreenWeb())):Get.back();
        },
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: darkShadow,
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0,
              )
            ],
          ),
          child: Text(
            'cancel'.tr,
            // AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              letterSpacing: 0.7,
              fontWeight: normalWeight,
              color: darkBlueColor,
              fontSize: size_7,
            ),
          ),
        ),
      ),
    );
  }
}
