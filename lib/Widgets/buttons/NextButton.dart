import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import 'package:get/get.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoadDetails.dart';
import 'package:provider/provider.dart';

class nextButton extends StatelessWidget {
  nextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: space_8,
        margin: EdgeInsets.fromLTRB(space_8, space_0, space_8, space_20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(space_10),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: providerData.postLoadScreenOneButton()
                    ? activeButtonColor
                    : deactiveButtonColor,
              ),
              child: Text(
                'next'.tr,
                // AppLocalizations.of(context)!.next,
                style: TextStyle(
                  color: white,
                ),
              ),
              onPressed: () {
                providerData.postLoadScreenOneButton()
                    ? Get.to(() => PostLoadScreenTwo())
                    : null;
              }),
        ),
      ),
    ]);
  }
}
