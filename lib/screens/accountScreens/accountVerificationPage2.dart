import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/hudController.dart';
import '/controller/navigationIndexController.dart';
import '/controller/shipperIdController.dart';
import '/functions/documentApi/postAccountVerificationDocuments.dart';
import '/functions/shipperApis/updateShipperApi.dart';
import '/providerClass/providerData.dart';
import '/screens/navigationScreen.dart';
import '/widgets/accountVerification/companyIdInputWidget.dart';
import '/widgets/accountVerification/elevatedButtonWidget.dart';
import '/widgets/alertDialog/conflictDialog.dart';
import '/widgets/buttons/backButtonWidget.dart';
import '/widgets/buttons/helpButton.dart';
import '/widgets/headingTextWidget.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountVerificationPage2 extends StatelessWidget {
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  HudController hudController = Get.put(HudController());

  @override
  Widget build(BuildContext context) {
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    var providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
          child: Obx(
        () => ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
          ),
          inAsyncCall: hudController.showHud.value,
          child: Container(
            padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BackButtonWidget(),
                          SizedBox(
                            width: space_3,
                          ),
                          HeadingTextWidget("my_account".tr),
                        ],
                      ),
                      HelpButtonWidget(),
                    ],
                  ),
                  SizedBox(
                    height: space_4,
                  ),
                  Row(
                    children: [
                      Text(
                        "forPostingLoad".tr,
                        style: TextStyle(
                            fontSize: size_9,
                            color: liveasyBlackColor,
                            fontWeight: mediumBoldWeight),
                      ),
                      Text(
                        "optional".tr,
                        style: TextStyle(
                            fontSize: size_9, color: liveasyBlackColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: space_5,
                  ),
                  CompanyIdInputWidget(
                    providerData: providerData,
                  ),
                  ElevatedButtonWidget(
                      condition: true,
                      text: "verify".tr,
                      onPressedConditionTrue: () async {
                        hudController.updateHud(true);
                        await postAccountVerificationDocuments(
                                profilePhoto: providerData.profilePhoto64,
                                addressProofFront:
                                    providerData.addressProofFrontPhoto64,
                                addressProofBack:
                                    providerData.addressProofBackPhoto64,
                                panFront: providerData.panFrontPhoto64,
                                companyIdProof:
                                    providerData.companyIdProofPhoto64)
                            .then((uploadstatus) async {
                          if (uploadstatus == "Success") {
                            final status = await updateShipperApi(
                                comapnyStatus: "inProgress",
                                transporterId: shipperIdController
                                    .shipperId.value);
                            if (status == "Success") {
                              hudController.updateHud(false);
                              Get.offAll(NavigationScreen());
                              // providerData.updateIndex(4);
                            } else {
                              hudController.updateHud(false);
                              showDialog(
                                  context: context,
                                  builder: (context) => ConflictDialog(
                                      dialog: "Failed Please try again"));
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => ConflictDialog(
                                    dialog: "Failed Please try again"));
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
