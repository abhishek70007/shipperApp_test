import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '../../constants/screens.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:provider/provider.dart';
import '/providerClass/providerData.dart';
import '/constants/spaces.dart';
import '/screens/PostLoadScreens/postloadnavigation.dart';

// ignore: must_be_immutable
class PostButtonLoad extends StatelessWidget {
  ShipperIdController shipperIdController = Get.put(ShipperIdController());

  PostButtonLoad({super.key});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return SizedBox(
      height: space_8,
      width: space_33,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
          backgroundColor: MaterialStateProperty.all<Color>(liveasyGreen),
        ),
        onPressed: () {
          providerData.resetPostLoadScreenOne();
          providerData.resetPostLoadFilters();
          providerData.resetPostLoadScreenMultiple();
          providerData.updateEditLoad(false, "");
          shipperIdController.companyStatus.value == 'verified'
              ? kIsWeb
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreenWeb(
                                index: screens.indexOf(postLoadNav),
                                selectedIndex: screens.indexOf(postLoadScreen),
                              )))
                  : Get.to(() => const PostLoadNav())
              : showDialog(
                  context: context,
                  builder: (context) => VerifyAccountNotifyAlertDialog());
        },
        child: Text(
          'postLoad'.tr,
          // AppLocalizations.of(context)!.postLoad,
          style: TextStyle(
            fontWeight: mediumBoldWeight,
            color: white,
            fontSize: size_8,
          ),
        ),
      ),
    );
  }
}
