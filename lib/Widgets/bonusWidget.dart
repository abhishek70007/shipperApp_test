import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
// import '/widgets/alertDialog/nextUpdateAlertDialog.dart';

class BonusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showDialog(
        //     context: context,
            // builder: (context) => NextUpdateAlertDialog());
      },
      child: Container(
        height: 100,
        width: 180,
        padding: EdgeInsets.fromLTRB(space_2, space_2, 0, 0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bonusBackgroundImage.png"),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "bonus".tr,
                  // "Bonus",
                  style: TextStyle(
                      fontSize: size_10,
                      fontWeight: mediumBoldWeight,
                      color: white),
                ),
                SizedBox(
                  height: space_2,
                ),
                Text(
                  'bookingtitle'.tr,
                  // "Keep booking\nusing Liveasy to\nearn more",
                  style: TextStyle(fontSize: size_6, color: white),
                ),
              ],
            ),
            Container(
              height: space_13,
              width: space_13,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icons/bonusIcon.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
