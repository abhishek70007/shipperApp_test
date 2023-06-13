import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shipper_app/screens/LoginScreens/CompanyDetailsForm.dart';
import '/constants/colors.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/hudController.dart';
import '/controller/isOtpInvalidController.dart';
import '/controller/timerController.dart';
import '/functions/shipperApis/runShipperApiPost.dart';
import '/providerClass/providerData.dart';
import 'package:flutter/material.dart';
import '/widgets/otpInputField.dart';
import 'package:get/get.dart';
import '/functions/authFunctions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import '/constants/fontWeights.dart';
import '/constants/fontSize.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';

class NewOTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  NewOTPVerificationScreen(this.phoneNumber);

  @override
  _NewOTPVerificationScreenState createState() =>
      _NewOTPVerificationScreenState();
}

class _NewOTPVerificationScreenState
    extends VisibilityAwareState<NewOTPVerificationScreen> {
//--------------------------------------------------------------------------------------------------------------------
  late AppLifecycleState go = AppLifecycleState.resumed;

//objects
  AuthService authService = AuthService();

  //keys
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //variables
  String _verificationCode = '';
  late int _forceResendingToken = 0;

  //controllers

  TimerController timerController = Get.put(TimerController());
  HudController hudController = Get.put(HudController());
  IsOtpInvalidController isOtpInvalidController =
      Get.put(IsOtpInvalidController());

  //--------------------------------------------------------------------------------------------------------------------
  @override
  void onVisibilityChanged(WidgetVisibility visibility) {
    print('Visibility state : $visibility');
    super.onVisibilityChanged(visibility);
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bidBackground,
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: space_8, bottom: space_12),
                    child: Container(
                      width: space_34,
                      height: space_8,
                      child: Image(
                        image: AssetImage("assets/icons/liveasy.png"),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radius_3),
                            topRight: Radius.circular(radius_3))),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          space_0, size_12, space_0, size_0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                space_2, space_0, space_0, space_4),
                            child: Text(
                              'OTPverify'.tr,
                              // 'OTP Verification',
                              style: TextStyle(
                                fontSize: size_10,
                                fontWeight: boldWeight,
                                color: black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: space_5),
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'OTPsent'.tr,
                                  // 'OTP sent to',
                                  style: TextStyle(
                                    fontSize: size_6,
                                    fontWeight: regularWeight,
                                    color: darkCharcoal,
                                  ),
                                ),
                                Text(' +91${widget.phoneNumber} ',
                                    style: TextStyle(
                                        fontSize: size_7,
                                        fontWeight: regularWeight,
                                        color: black,
                                        fontFamily: "Roboto")),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'change'.tr,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: size_6,
                                      fontWeight: regularWeight,
                                      color: bidBackground,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          OTPInputField(_verificationCode),
                          Padding(
                              padding: EdgeInsets.only(top: space_3),
                              child: Obx(
                                () => Container(
                                  child:
                                      isOtpInvalidController.isOtpInvalid.value
                                          ? Text(
                                              'Wrong OTP. Try Again!',
                                              style: TextStyle(
                                                letterSpacing: 0.5,
                                                color: red,
                                              ),
                                            )
                                          : Text(""),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: space_3),
                            child: Obx(
                              () => Container(
                                child: timerController.timeOnTimer.value == 0
                                    ? Obx(() => TextButton(
                                        onPressed: () {
                                          timerController.startTimer();
                                          // hudController.updateHud(true);

                                          _verifyPhoneNumber();
                                        },
                                        child: Text(
                                          'Resendotp'.tr,
                                          // 'Resend OTP',
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: timerController
                                                    .resendButton.value
                                                ? navygreen
                                                : unselectedGrey,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        )))
                                    : Obx(
                                        () => Text(
                                          'Resendotp'.tr +
                                              '${timerController.timeOnTimer}',
                                          // 'Resend OTP in ${timerController.timeOnTimer}',
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            color: veryDarkGrey,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: space_5),
                              child: Obx(
                                () => Container(
                                  child: hudController.showHud.value
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Verifying OTP"),
                                            SizedBox(
                                              width: space_1,
                                            ),
                                            Container(
                                                width: space_3,
                                                height: space_3,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ))
                                          ],
                                        )
                                      : Text(""),
                                ),
                              )),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       print(hudController.showHud.value);
                          //     },
                          //     child: Container(
                          //       width: 100,
                          //       height: 100,
                          //     ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timerController.startTimer();
    isOtpInvalidController.updateIsOtpInvalid(false);
    // hudController.updateHud(false);
    _verifyPhoneNumber();
  }

  void _verifyPhoneNumber() async {
    // try {
    print('in verify phone');
    print(widget.phoneNumber);
    print(widget.phoneNumber.runtimeType);
    await FirebaseAuth.instance.verifyPhoneNumber(
        //this value changes runtime
        forceResendingToken: _forceResendingToken,
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print(credential.smsCode);
          hudController.updateHud(true);
          print(credential.smsCode);
          _verificationCode = credential.verificationId!;
          await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);

          timerController.cancelTimer();
          if(FirebaseAuth.instance.currentUser!.emailVerified) {
            await runShipperApiPost(
                emailId: FirebaseAuth.instance.currentUser!.email.toString()
            );
          }
          Get.offAll(() => CompanyDetailsForm());
        },
        verificationFailed: (FirebaseAuthException e) {
          print('in verification failed');
          hudController.updateHud(false);
          print(e.message);
        },
        codeSent: (String? verificationId, int? resendToken) {
          setState(() {
            print('in codesent');
            _forceResendingToken = resendToken!;
            print(_forceResendingToken);
            _verificationCode = verificationId!;
            print(_verificationCode);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('in auto retrieval timeout');
          if (mounted) {
            hudController.updateHud(false);
            timerController.cancelTimer();
            setState(() {
              _verificationCode = verificationId;
            });
          }
        },
        timeout: Duration(seconds: 60));
    // } catch (e) {
    //   hudController.updateHud(false);
    // }
  }
} // class end
