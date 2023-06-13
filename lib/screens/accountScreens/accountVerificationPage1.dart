import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/functions/getImageFromCamera.dart';
import '/providerClass/providerData.dart';
import '/screens/accountScreens/accountVerificationPage2.dart';
import '/widgets/accountVerification/elevatedButtonWidget.dart';
import '/widgets/headingTextWidget.dart';
import '/widgets/buttons/helpButton.dart';
import '/widgets/accountVerification/idInputWidget.dart';
import '/widgets/accountVerification/profilePhoto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../widgets/accountVerification/image_display.dart';

class AccountVerificationPage1 extends StatefulWidget {
  @override
  _AccountVerificationPage1State createState() =>
      _AccountVerificationPage1State();
}

class _AccountVerificationPage1State extends State<AccountVerificationPage1> {
  @override
  void initState() {
    super.initState();
    Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: space_2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingTextWidget("my_account".tr),
                    HelpButtonWidget(),
                  ],
                ),
              ),
              SizedBox(
                height: space_3,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    providerData.profilePhotoFile!=null?
                    Get.to(ImageDisplay(providerData: providerData.profilePhotoFile,imageName: "profilePhoto64"))
                        :showPicker(providerData.updateProfilePhoto,
                        providerData.updateProfilePhotoStr, context);
                  },
                  child: ProfilePhotoWidget(
                    providerData: providerData,
                  ),
                ),
              ),
              SizedBox(
                height: space_4,
              ),
              IdInputWidget(
                providerData: providerData,
              ),
              ElevatedButtonWidget(
                  condition: providerData.profilePhoto64 != null &&
                      providerData.addressProofFrontPhoto64 != null &&
                      providerData.addressProofBackPhoto64 != null &&
                      providerData.panFrontPhoto64 != null,
                  text: "next".tr,
                  onPressedConditionTrue: () {
                    Get.to(() => AccountVerificationPage2());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
