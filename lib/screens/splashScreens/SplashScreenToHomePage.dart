import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import '/screens/home.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/screens/navigationScreen.dart';
import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/functions/shipperApis/runShipperApiPost.dart';


class SplashScreenToHomePage extends StatefulWidget {
  const SplashScreenToHomePage({Key? key}) : super(key: key);

  @override
  State<SplashScreenToHomePage> createState() =>
      _SplashScreenToHomePageState();
}

class _SplashScreenToHomePageState
    extends State<SplashScreenToHomePage> {

  ShipperIdController shipperIdController = Get.put(ShipperIdController(), permanent: true);
  String? shipperId;

  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(seconds: 3), () => Get.off(() => NavigationScreen()));
  }

  getData() async   {
    bool? companyApproved;
    String? mobileNum;
    bool? accountVerificationInProgress;
    String? shipperLocation;
    String? name;
    String? companyName;
    String? companyStatus;

    if (shipperId != null){
      // setState(() {
      //   _nextScreen=true;
      // });
    }
    else {
      setState(() {
        shipperId = sidstorage.read("shipperId");
        companyApproved = sidstorage.read("companyApproved");
        mobileNum = sidstorage.read("mobileNum");
        accountVerificationInProgress = sidstorage.read("accountVerificationInProgress");
        shipperLocation = sidstorage.read("shipperLocation");
        name = sidstorage.read("name");
        companyName = sidstorage.read("companyName");
        companyStatus = sidstorage.read("companyStatus");
      });

      if (shipperId == null) {
        print("Shipper ID is null");
      } else {
        print("It is in else");
        shipperIdController.updateShipperId(shipperId!);
        shipperIdController.updateCompanyApproved(companyApproved!);
        shipperIdController.updateCompanyStatus(companyStatus!);
        shipperIdController.updateMobileNum(mobileNum!);
        shipperIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress!);
        shipperIdController.updateShipperLocation(shipperLocation!);
        shipperIdController.updateName(name!);
        shipperIdController.updateCompanyName(companyName!);
        print("shipperId is $shipperId");
        // setState(() {
        //   _nextScreen=true;
        // });
      }
      //setState(() {
      //_nextScreen=true;
      //});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [shadowGrey, white]
                )
            ),
            padding: EdgeInsets.only(right: space_2, top: space_35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/liveasyTruck.png"),
                ),
                SizedBox(height: space_2),
                Container(
                    child: Column(
                      children: [
                        Image(
                          image: const AssetImage("assets/images/logoSplashScreen.png"),
                          height: space_12,
                        ),
                        SizedBox(
                          height: space_3,
                        )
                      ],
                    )
                )
              ],
            )
        ));
  }
}
