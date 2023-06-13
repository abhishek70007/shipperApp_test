import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipper_app/Web/screens/login.dart';
import 'package:shipper_app/screens/LoginScreens/LoginScreenUsingMail.dart';
import '../../functions/shipperApis/runShipperApiPost.dart';
import '/constants/colors.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutOkButton extends StatelessWidget {
  const LogoutOkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        SharedPreferences prefs =await SharedPreferences.getInstance();
        prefs.remove('uid');
        sidstorage.erase();
        if(prefs.getBool('isGoogleLogin')==true) {
          await GoogleSignIn().disconnect();
        }
        prefs.clear();
        FirebaseAuth.instance.signOut().then((value) =>
            sidstorage.erase().then((value) => print('Storage is erased')));
        kIsWeb ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginWeb())) : Get.offAll(LoginScreenUsingMail());
      },
      child: Container(
        height: 31,
        width: 80,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: darkShadow,
            offset: Offset(0, 0),
            blurRadius: 16,
            spreadRadius: 0,
          )
        ], color: darkBlueColor, borderRadius: BorderRadius.circular(radius_4)),
        child: Center(
          child: Text(
            "ok".tr,
            style: TextStyle(
                color: backgroundColor,
                fontWeight: mediumBoldWeight,
                fontSize: 13),
          ),
        ),
      ),
    );
  }
}
