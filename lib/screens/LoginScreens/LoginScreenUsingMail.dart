import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shipper_app/functions/alert_dialog.dart';
import 'package:shipper_app/functions/firebaseAuthentication/signIn.dart';
import 'package:shipper_app/functions/shipperApis/runShipperApiPost.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import 'package:shipper_app/screens/LoginScreens/loginScreenUsingPhone.dart';
import 'package:shipper_app/screens/navigationScreen.dart';
import '../../functions/firebaseAuthentication/signInWithGoogle.dart';
import '/constants/spaces.dart';
import '/constants/colors.dart';
import '/widgets/buttons/signUpWithGoogleButton.dart';
import 'CompanyDetailsForm.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';
import '/constants/elevation.dart';

class LoginScreenUsingMail extends StatefulWidget {
  const LoginScreenUsingMail({Key? key}) : super(key: key);

  @override
  State<LoginScreenUsingMail> createState() => _LoginScreenUsingMailState();
}

class _LoginScreenUsingMailState extends State<LoginScreenUsingMail> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      image:
                          AssetImage("assets/background/login_page_wave.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: space_12, right: space_12, top: space_15),
                      child: const Image(
                          image: AssetImage("assets/icons/liveasy.png")))
                ],
              ),

              //TODO : Email fields in email login screen
              Padding(
                padding: EdgeInsets.only(
                    left: space_4, right: space_4, top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                          fontSize: size_9,
                          color: white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(radius_6)),
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: space_2,
              ),

              //TODO : Password fields in email login screen
              Padding(
                padding: EdgeInsets.only(
                    left: space_4, right: space_4, top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password : ",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Poppins",
                          fontSize: size_9,
                          color: white),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: !isVisible,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(radius_6)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: space_10,
              ),

              //TODO : Login Button at email login screen
              Padding(
                padding: EdgeInsets.only(
                  left: space_4,
                  right: space_4,
                ),
                child: Container(
                  height: space_9,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: widgetBackGroundColor,
                    borderRadius: BorderRadius.circular(radius_6),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith(
                          (states) => elevation_0),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black.withOpacity(0.01)),
                    ),
                    onPressed: () async {
                      String email = emailController.text.toString();
                      String password = passwordController.text.toString();
                      if (email.isNotEmpty && email.contains('@')) {
                        if (password.length > 5) {
                          UserCredential firebaseUser =
                              await signIn(email, password, context);
                          getShipperIdFromCompanyDatabase();
                          if(!mounted) return ;
                          if (firebaseUser.user!.phoneNumber == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreenUsingPhone()));
                          } else if (firebaseUser.user!.displayName == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CompanyDetailsForm()));
                          } else {
                            runShipperApiPost(emailId: firebaseUser.user!.email.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavigationScreen()));
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  'Password must contain at least 6 characters',
                              fontSize: size_8,
                              backgroundColor: Colors.white,
                              textColor: Colors.black);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Invalid email',
                            fontSize: size_8,
                            backgroundColor: Colors.white,
                            textColor: Colors.black);
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: size_9,
                          color: const Color(0xFF002087),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: space_8,
              ),

              //TODO : This is for OR text in email login screen
              Container(
                margin: EdgeInsets.only(
                  left: space_4,
                  right: space_4,
                ),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      // width: space_26,
                      height: 1,
                      color: widgetBackGroundColor,
                    )),
                    SizedBox(
                      width: space_3,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: size_10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.normal,
                        color: white,
                      ),
                    ),
                    SizedBox(
                      width: space_3,
                    ),
                    Expanded(
                        child: Container(
                      // width: space_26,
                      height: 1,
                      color: widgetBackGroundColor,
                    )),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    left: space_6,
                    right: space_6,
                    bottom: space_2,
                    top: space_8),
                decoration: BoxDecoration(
                  color: widgetBackGroundColor,
                  borderRadius: BorderRadius.circular(radius_3),
                ),
                child: SignUpWithGoogleButton(
                  onPressed: () async{
                    try {
                      UserCredential firebaseUser = await signInWithGoogle();
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString('uid', firebaseUser.user!.uid);
                      prefs.setBool('isGoogleLogin', true);
                      getShipperIdFromCompanyDatabase();
                      if(!mounted) return ;
                      if(firebaseUser.user!.phoneNumber==null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreenUsingPhone()));
                      }else if(firebaseUser.user!.displayName == null){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CompanyDetailsForm()));
                      }else{
                        runShipperApiPost(emailId: firebaseUser.user!.email.toString());
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
                      }
                    }on FirebaseAuthException catch (e){
                      alertDialog("Error", '$e', context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
