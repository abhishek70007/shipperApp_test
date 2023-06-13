import 'dart:developer';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Web/screens/home_web.dart';
import '/Widgets/liveasy_Icon_Widgets.dart';
import 'company_details.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '/../functions/alert_dialog.dart';

class LoginWebPhone extends StatefulWidget {
  const LoginWebPhone({Key? key}) : super(key: key);

  @override
  State<LoginWebPhone> createState() => _LoginWebPhoneState();
}

class _LoginWebPhoneState extends State<LoginWebPhone> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController otpController = TextEditingController();
  late String phoneNumber;
  late ConfirmationResult confirmationResult;
  bool passwordVisible = true;
  bool isChecked = false;
  bool isError = false;
  bool isVerified = false;

  @override
  void initState(){
    super.initState();
    log(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const LiveasyIcon(),
              Form(
                key: _formKey,
                child: Container(
                  width: kIsWeb?35.w:40.w,
                  height: isError?55.h:50.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 5.h),
                        child: const Text('Phone Number',
                          style: TextStyle(
                              
                              fontSize: 18,
                              fontWeight: FontWeight.bold,),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w,top: 1.h,right: 4.w),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp(r'\d')),
                          ],
                          decoration: const InputDecoration(
                            hintText: '98xxxxxx12',
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          validator: (value){
                            if(value.toString().isEmpty){
                              setState(() {
                                isError = true;
                              });
                              return "Enter your Phone Number";
                            }
                            if(value.toString().length != 10){
                              setState(() {
                                isError = true;
                              });
                              return "Invalid Phone NUmber";
                            }
                            setState(() {
                              isError = false;
                            });
                            return null;
                          },
                          onSaved: (value){
                            phoneNumber = value.toString();
                          },
                        ),
                      ),
                      isVerified?showOTPField():SizedBox(height: 2.h,),
                      isVerified ? buildButton('Sign In', () async{
                        String temp = await checkOTP(otpController.text.toString());
                        if(temp=="success") {
                          if (auth.currentUser!.displayName == null) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (
                                    context) => const CompanyDetails()));
                          } else if (auth.currentUser!.emailVerified) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (
                                    context) => const HomeScreenWeb()));
                          } else {
                            alertDialog("Verify Your Mail", "Please verify your \n mail id to continue", context);
                          }
                        }
                      }) : buildButton('Send OTP',() async{
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          await sigInUsingPhoneNum(phoneNumber);
                          if(confirmationResult.verificationId.isNotEmpty){
                            setState(() {
                              isVerified = true;
                            });
                          }
                        }
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //Elevated Button for both send otp and sign in functionalities
  buildButton(String text,VoidCallback fun) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w,top: 5.h,right: 1.w),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
          backgroundColor: const Color(0xFF000066),
          fixedSize: Size(28.w, 7.h),
        ),
        onPressed: fun,
        child: Text(text,
          style: TextStyle(
            color: Colors.white,
            
            fontSize: 4.3.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  //OTP field is displayed only when user got otp to his specified number
  showOTPField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left:kIsWeb?3.w:10,top: 3.h),
          child: const Text('OTP',
            style: TextStyle(
              
              fontSize: 18,
              fontWeight: FontWeight.bold,),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 3.w,top: 1.h,right: 4.w),
          child: PinCodeTextField(
            autoFocus: true,
            obscureText: true,
            obscuringCharacter: '*',
            animationType: AnimationType.fade,
            validator: (v){
              if(v!.length<6){
                return "Enter Valid OTP";
              }else{
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: kIsWeb?50:40,
              fieldWidth: kIsWeb?40:30,
              activeColor: Colors.black,
              inactiveColor: Colors.black,
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            controller: otpController,
            appContext: context,
            length: 6,
            onChanged: (value){},
          ),
        ),
      ],
    );
  }

  //Sign In functionality
  sigInUsingPhoneNum(String phoneNumber) async{
    await auth.signInWithPhoneNumber("+91$phoneNumber")
        .then((value) => {
          confirmationResult = value,
          alertDialog('OTP sent','OTP has been sent to +91$phoneNumber',context),
        })
        .catchError((error)=>{
          alertDialog('Error','Try again Later',context)
        });
  }

  //User entered otp verification and signing in
  checkOTP(String otp) async{
    try {
      await FirebaseAuth.instance.currentUser!.updatePhoneNumber(
          PhoneAuthProvider.credential(
              verificationId: confirmationResult.verificationId, smsCode: otp));
      return 'success';
    }on FirebaseAuthException catch(e){
      switch(e.code){
        case "provider-already-linked":alertDialog("Already Linked", 'The phone number is already linked', context); break;
        case "invalid-credential":alertDialog("Invalid Credential", 'Invalid Credential', context); break;
        case "credential-already-in-use":alertDialog("Linked with different email", 'The phone number is already linked with different email', context); break;
        case "account-exists-with-different-credential":alertDialog("Linked with different email", 'The phone number is already linked with different email', context); break;
        default: alertDialog("Error", '$e', context);
      }
    }
  }
}
