import 'dart:developer';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shipper_app/Web/screens/login_phone_no.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import '../../functions/firebaseAuthentication/signIn.dart';
import '../../functions/firebaseAuthentication/signInWithGoogle.dart';
import '/Web/screens/home_web.dart';
import '/Widgets/liveasy_Icon_Widgets.dart';
import 'company_details.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/../functions/alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({Key? key}) : super(key: key);

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool passwordVisible = true;
  bool isChecked = false;
  bool isError = false;
  Iterable<String>? autofillHints = {'@gmail.com','@outlook.in','@yahoo.com'};

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
                  width: kIsWeb ? 35.w : 40.w,
                  height: isError ? 65.h : 60.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //TODO : Email text field title
                      Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 5.h),
                        child: const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //TODO : Email text field
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, top: 1.h, right: 4.w),
                        child: TextFormField(
                          autofocus: true,
                          autofillHints: autofillHints,
                          decoration: const InputDecoration(
                            hintText: 'xyz@gmail.com',
                            labelText: 'Email Id',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              setState(() {
                                isError = true;
                              });
                              return "Enter your email id";
                            }
                            if (!value.toString().contains('@')) {
                              setState(() {
                                isError = true;
                              });
                              return "Invalid Email Id";
                            }
                            setState(() {
                              isError = false;
                            });
                            return null;
                          },
                          onSaved: (value) {
                            email = value.toString();
                          },
                        ),
                      ),
                      //TODO : Password text field title
                      Padding(
                        padding:
                            EdgeInsets.only(left: kIsWeb ? 3.w : 10, top: 3.h),
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      //TODO : Password text field
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, top: 1.h, right: 4.w),
                        child: TextFormField(
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'abc@123',
                            labelText: 'Password',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              setState(() {
                                isError = true;
                              });
                              return "Enter password";
                            }
                            if (value.toString().length < 6) {
                              setState(() {
                                isError = true;
                              });
                              return "Password length should be greater/equal to 6 ";
                            }
                            setState(() {
                              isError = false;
                            });
                            return null;
                          },
                          onSaved: (value) {
                            password = value.toString();
                          },
                        ),
                      ),
                      //TODO : check box for keep me logged in
                      Padding(
                        padding: EdgeInsets.only(left: 3.w, top: 1.h),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          icon: isChecked
                              ? const Icon(
                                  Icons.check_box,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.black,
                                ),
                          label: const Text(
                            "Keep me logged in",
                            style: TextStyle(
                              
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      //TODO : Sign In button
                      Padding(
                        padding:
                            EdgeInsets.only(left: 3.w, top: 5.h, right: 1.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: const Color(0xFF000066),
                            fixedSize: Size(28.w, 7.h),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                UserCredential firebaseUser =
                                    await signIn(email, password, context);
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                if(isChecked){
                                  prefs.setString('uid', firebaseUser.user!.uid);
                                }
                                if (firebaseUser.user!.phoneNumber == null) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginWebPhone()));
                                } else if (firebaseUser.user!.displayName == null) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompanyDetails()));
                                } else if (firebaseUser.user!.emailVerified) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreenWeb()));
                                } else {
                                  alertDialog("Verify Your Mail", "Please verify your \n mail id to continue", context);
                                 // firebaseUser.user!.sendEmailVerification();
                                }
                              } catch (e) {
                                log('in sign in button catch--->$e');
                              }
                            }
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 4.3.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.only(left: 3.w, top: 5.h, right: 1.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.white,
                            fixedSize: Size(28.w, 7.h),
                          ),
                          onPressed: () async {
                              try {
                                UserCredential firebaseUser = await signInWithGoogle();
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('uid', firebaseUser.user!.uid);
                                getShipperIdFromCompanyDatabase();
                                if (firebaseUser.user!.phoneNumber == null) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginWebPhone()));
                                } else if (firebaseUser.user!.displayName == null) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompanyDetails()));
                                } else if (firebaseUser.user!.emailVerified) {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreenWeb()));
                                } else {
                                  alertDialog("Verify Your Mail", "Please verify your \n mail id to continue", context);
                                  // firebaseUser.user!.sendEmailVerification();
                                }
                              } catch (e) {
                                log('in sign in button catch--->$e');
                              }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 5.h,
                                  width: 5.w,
                                  child: const Image(
                                    image: AssetImage("assets/icons/google_icon.png"),
                                  )
                              ),
                              Text(
                                'Sign in Using Google',
                                style: TextStyle(
                                  color: const Color(0xFF000066),
                                  fontSize: 4.3.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
}
