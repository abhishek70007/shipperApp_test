import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/navigationIndexController.dart';
import '/providerClass/providerData.dart';
import '/screens/navigationScreen.dart';
import '/widgets/accountVerification/accountPageUtil.dart';
import 'package:provider/provider.dart';

class VerifyNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    return GestureDetector(
      onTap: () {
        if(kIsWeb){
          Get.offAll(const HomeScreenWeb(index:3,selectedIndex: 3,));
        }else {
          Get.offAll(NavigationScreen(initScreen: 2));
          navigationIndexController.updateIndex(2);
        }
      },
      child: Container(
        height: space_8,
        padding: EdgeInsets.symmetric(horizontal: space_3),
        decoration: BoxDecoration(
            color: darkBlueColor,
            borderRadius: BorderRadius.circular(radius_6)),
        child: Center(
          child: Text(
            'verifyButton'.tr,
            // "Verify Now",
            style: TextStyle(
                color: white, fontWeight: mediumBoldWeight, fontSize: size_8),
          ),
        ),
      ),
    );
  }
}
