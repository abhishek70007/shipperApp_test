import 'dart:async';

import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/screens/LoginScreens/loginScreenUsingPhone.dart';
import 'package:get/get.dart';
import '/screens/languageSelectionScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () => Get.off(() => LanguageSelectionScreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [shadowGrey, white])),
          padding: EdgeInsets.only(right: space_2, top: space_35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/liveasyTruck.png")),
              SizedBox(
                height: space_2,
              ),
              Container(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/images/logoSplashScreen.png"),
                      height: space_12,
                    ),
                    SizedBox(
                      height: space_3,
                    ),
                    // Image(
                    //   image: AssetImage("assets/images/tagLine.png"),
                    //   height: space_3,
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
