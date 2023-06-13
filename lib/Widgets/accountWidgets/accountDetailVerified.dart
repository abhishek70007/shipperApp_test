import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/spaces.dart';
import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

class AccountDetailVerified extends StatelessWidget {
  final String mobileNum;
  final String name;
  final String companyName;
  final String address;
  final String mailId;

  const AccountDetailVerified(
      {super.key, required this.mobileNum,
      required this.name,
      required this.address, required this.mailId,
      required this.companyName,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.48,
          child: Text(
            name,
            style: TextStyle(
                fontWeight: mediumBoldWeight, color: white, fontSize: size_9),
          ),
        ),
        SizedBox(
          height: space_1,
        ),
        Row(
          children: [
            Container(
              height: space_3,
              width: space_2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/icons/callIcon.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: space_1 - 2,
            ),
            Text(
              mobileNum,
              style: TextStyle(
                  fontWeight: normalWeight,
                  color: lightGrayishBlue,
                  fontSize: size_6),
            ),
          ],
        ),
        SizedBox(
          height: space_1,
        ),
        Row(
          children: [
            Container(
              height: space_4,
              width: space_3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/icons/mailIcon.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: space_1 - 2,
            ),
            Text(
              mailId,
              style: TextStyle(
                  fontWeight: normalWeight,
                  color: lightGrayishBlue,
                  fontSize: size_6),
            ),
          ],
        ),
        SizedBox(
          height: space_1,
        ),
        Row(
          children: [
            Image(
              image: const AssetImage("assets/icons/buildingIcon.png"),
              height: space_3 + 1,
              width: space_3,
            ),
            SizedBox(
              width: space_1 - 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                companyName,
                style: TextStyle(
                    fontWeight: normalWeight,
                    color: lightGrayishBlue,
                    fontSize: size_6),
              ),
            ),
          ],
        ),
        SizedBox(
          height: space_1 - 1,
        ),
        Row(
          children: [
            Container(
              height: space_3,
              width: space_3 - 2,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/icons/locationIcon.png",
                ),
              )),
            ),
            SizedBox(
              width: space_1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Text(
                address,
                style: TextStyle(
                    fontWeight: normalWeight,
                    color: lightGrayishBlue,
                    fontSize: size_6),
              ),
            ),
          ],
        ),
        SizedBox(
          height: space_1 + 1,
        ),
        Container(
          height: space_3,
          width: space_10 - 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.81),
            color: lightishGreen,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: space_1 + 3,
                width: space_1 + 3,
                image: const AssetImage("assets/icons/verifiedButtonIcon.png"),
              ),
              Text(
                "verified".tr,
                style:
                    TextStyle(fontWeight: normalWeight, fontSize: size_3 + 1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
