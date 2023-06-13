import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:shipper_app/screens/LoginScreens/LoginScreenUsingMail.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/functions/shipperApis/runShipperApiPost.dart';


class SplashScreenToLoginScreen extends StatefulWidget {
  const SplashScreenToLoginScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreenToLoginScreen> createState() =>
      _SplashScreenToLoginScreenState();
}

class _SplashScreenToLoginScreenState
    extends State<SplashScreenToLoginScreen> {
  ShipperIdController shipperIdController = Get.put(ShipperIdController(), permanent: true);
  String? shipperId;


  @override
  void initState() {
    super.initState();
    getData();
    Timer(const Duration(seconds: 3), () => Get.off(() => const LoginScreenUsingMail()));
  }

  getData() async   {
    // print();
    // Fluttertoast.showToast(
    //   msg: "shipperIdController ${shipperIdController}",
    //   // toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    // );

    bool? companyApproved;
    String? mobileNum;
    bool? accountVerificationInProgress;
    String? shipperLocation;
    String? name;
    String? companyName;
    String? companyStatus;

    if (shipperId != null){
      print("shipperId is not null");
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
        print("shipper ID is null");
      } else {
        print("It is in else");
        shipperIdController.updateShipperId(shipperId!);
        shipperIdController.updateCompanyApproved(companyApproved!);
        shipperIdController.updateMobileNum(mobileNum!);
        shipperIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress!);
        shipperIdController.updateShipperLocation(shipperLocation!);
        shipperIdController.updateName(name!);
        shipperIdController.updateCompanyName(companyName!);
        shipperIdController.updateCompanyStatus(companyStatus!);
        print("shipperID is $shipperId");
      }
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
            const Image(
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
