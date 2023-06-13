import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/hudController.dart';
import '/constants/spaces.dart';
import '/constants/colors.dart';
import '/constants/borderWidth.dart';
import '/constants/fontWeights.dart';
import '/constants/fontSize.dart';
import '/widgets/linePainter.dart';
import '/constants/radius.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

class PhoneNumberTextField extends StatefulWidget {
  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  HudController hudController = Get.put(HudController());
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    hudController.updateHud(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: borderWidth_20, color: backgroundGrey)),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.only(left: space_1),
              child: SizedBox(
                width: space_3,
                height: space_3,
                child: const Image(
                  image: AssetImage("assets/images/indianFlag.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: space_1, top: space_2),
              child: SizedBox(
                width: space_5,
                height: space_5,
                child: Text(
                  "+91",
                  style: TextStyle(
                      fontWeight: regularWeight,
                      fontSize: size_6,
                      fontFamily: "Roboto"),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 2),
                height: space_6,
                width: space_1,
                child: CustomPaint(
                  foregroundPainter: LinePainter(),
                )),
            SizedBox(
              width: 200,
              child: TextFormField(
                style: const TextStyle(fontWeight: FontWeight.bold),
                onChanged: (_controller) {
                  if (_controller.length == 10) {
                    providerData.updateInputControllerLengthCheck(true);
                    providerData.updateButtonColor(activeButtonColor);
                  } else {
                    providerData.updateInputControllerLengthCheck(false);
                    providerData.updateButtonColor(deactiveButtonColor);
                  }
                  providerData.updatePhoneController(_controller);
                },
                controller: _controller,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp(r'\d')),
                ],
                maxLength: 10,
                validator: (value) =>
                value!.length == 10 ? null : 'EnterPhoneNumber'.tr,
                // 'Enter a valid Phone Number',
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: "",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  filled: true,
                  fillColor: white,
                  hintText: 'EnterPhoneNumber'.tr,
                  // 'Enter Phone Number',
                  hintStyle: TextStyle(color: darkCharcoal, fontSize: size_7),
                ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
