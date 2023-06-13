import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shipper_app/screens/LoginScreens/CompanyDetailsForm.dart';
import '../functions/alert_dialog.dart';
import '/controller/hudController.dart';
import '/controller/isOtpInvalidController.dart';
import '/functions/authFunctions.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPInputField extends StatefulWidget {
  String _verificationCode = '';
  // String autoVerificationCode = '';

  OTPInputField(this._verificationCode, {super.key});
  @override
  _OTPInputFieldState createState() => _OTPInputFieldState();
}

class _OTPInputFieldState extends State<OTPInputField> {
  HudController hudController = Get.put(HudController());
  AuthService authService = AuthService();
  IsOtpInvalidController isOtpInvalidController =
  Get.put(IsOtpInvalidController());
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: PinCodeTextField(
        cursorColor: Colors.black,
        appContext: context,
        controller: textEditingController,
        pastedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeFillColor: Colors.white,
          activeColor: Colors.black,
          inactiveColor: Colors.black,
          selectedFillColor: Colors.white,
          selectedColor: Colors.black,
          inactiveFillColor: Colors.white,
          fieldHeight: 48,
          fieldWidth: 48,
        ),
        length: 6,
        enableActiveFill: true,
        keyboardType: TextInputType.phone,
        onCompleted: (pin) async{
          hudController.updateHud(true);
          providerData.updateSmsCode(pin);
          // isOtpInvalidController.updateIsOtpInvalid(false);
          try {
            await FirebaseAuth.instance.currentUser!.updatePhoneNumber(
                PhoneAuthProvider.credential(
                  verificationId: widget._verificationCode,
                  smsCode: providerData.smsCode,
                )
            );
            if(FirebaseAuth.instance.currentUser!.phoneNumber!=null){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const CompanyDetailsForm()));
            }
          }on FirebaseAuthException catch(e){
            switch(e.code){
              case "provider-already-linked":alertDialog("Already Linked", 'The phone number is already linked', context); break;
              case "invalid-credential":alertDialog("Invalid Credential", 'Invalid Credential', context); break;
              case "credential-already-in-use":alertDialog("Linked with different email", 'The phone number is already linked with different email', context); break;
              case "account-exists-with-different-credential":alertDialog("Linked with different email", 'The phone number is already linked with different email', context); break;
              default: alertDialog("Error", '$e', context);
            }
          }
          providerData.updateInputControllerLengthCheck(true);
          providerData.clearAll();
        },
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }
}
