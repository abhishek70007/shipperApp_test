import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '/constants/borderWidth.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/constants/colors.dart';
import '/controller/navigationIndexController.dart';

class AccountNotVerifiedWidget extends StatelessWidget {
  const AccountNotVerifiedWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    return GestureDetector(
      onTap: () {
        navigationIndexController.updateIndex(2);
      },
      child: Container(
        height: space_8,
        padding: EdgeInsets.fromLTRB(space_3, space_1 - 3, space_3, 0),
        margin: EdgeInsets.symmetric(vertical: space_3, horizontal: space_4),
        decoration: BoxDecoration(
          color: lightYellow,
          border: Border.all(color: darkYellow, width: borderWidth_10),
          borderRadius: BorderRadius.circular(space_1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: space_5 - 2,
                  width: space_5 - 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/errorIcon.png"),
                    ),
                  ),
                ),
                SizedBox(
                  width: space_3,
                ),
                Container(
                  padding: EdgeInsets.only(top: space_1 + 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'accountPending'.tr,
                        // "Account details pending!",
                        style: TextStyle(
                            fontSize: size_5,
                            color: const Color(0xFF212121),
                            fontFamily: "roboto",
                            fontWeight: mediumBoldWeight),
                      ),
                      Text(
                        'getVerified'.tr,
                        // "Get your account verified to proceed further",
                        style: TextStyle(
                            fontSize: size_4,
                            color: darkGreyColor,
                            fontFamily: "roboto"),
                      )
                    ],
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: darkGreyColor,
              size: space_2,
            )
          ],
        ),
      ),
    );
  }
}
