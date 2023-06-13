import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/CancelLogoutButton.dart';
import '/widgets/buttons/LogoutOkButton.dart';

class LogoutDialogue extends StatelessWidget {
  const LogoutDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text('logoutDialog'.tr,
            // "Are you sure? You want to logout" ,
            style: TextStyle(
                color: liveasyBlackColor,
                fontSize: size_9,
                
                fontWeight: regularWeight)),
        actions: <Widget>[
          LogoutOkButton(),
          CancelLogoutButton(),
          SizedBox(height: space_3)
        ]);
  }
}
