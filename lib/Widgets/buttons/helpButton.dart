import 'package:flutter/material.dart';
import '../../screens/HelpScreen.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import 'package:get/get.dart';
// import '/screens/HelpScreen.dart';

class HelpButtonWidget extends StatelessWidget {
  const HelpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HelpScreen()),
        );
      },
      child: Container(
        height: space_6,
        width: space_16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: borderWidth_10, color: darkBlueColor)),
        padding: EdgeInsets.only(left: space_3),
        child: Center(
          child: Row(
            children: [
              Container(
                height: space_3,
                width: space_3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/helpIcon.png"))),
              ),
              SizedBox(
                width: space_1,
              ),
              Text(
                'help'.tr,
                // AppLocalizations.of(context)!.help,
                style: TextStyle(fontSize: size_7, color: darkBlueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
