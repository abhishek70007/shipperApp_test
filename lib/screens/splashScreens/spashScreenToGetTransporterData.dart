import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
//import '/functions/trasnporterApis/runShipperApiPost.dart';
import 'package:get/get.dart';
import '/screens/navigationScreen.dart';

class SplashScreenToGetTransporterData extends StatefulWidget {
  final String mobileNum;

  SplashScreenToGetTransporterData({super.key, required this.mobileNum});

  @override
  _SplashScreenToGetTransporterDataState createState() =>
      _SplashScreenToGetTransporterDataState();
}

class _SplashScreenToGetTransporterDataState
    extends State<SplashScreenToGetTransporterData> {
  GetStorage sidstorage = GetStorage('ShipperIDStorage');
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController(), permanent: true);

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    bool? companyApproved;
    String? mobileNum;
    bool? accountVerificationInProgress;
    String? transporterLocation;
    String? name;
    String? companyName;
    String? companyStatus;

    String? transporterId;
    //= await runTransporterApiPost(mobileNum: widget.mobileNum);

    // String? transporterId = sidstorage.read("transporterId");
    // runTransporterApiPost(mobileNum: widget.mobileNum);

    if (transporterId != null) {
      Timer(const Duration(milliseconds: 1200),
          () => Get.off(() => NavigationScreen()));
    } else {
      setState(() {
        transporterId = sidstorage.read("transporterId");
        companyApproved = sidstorage.read("companyApproved");
        mobileNum = sidstorage.read("mobileNum");
        accountVerificationInProgress =
            sidstorage.read("accountVerificationInProgress");
        transporterLocation = sidstorage.read("transporterLocation");
        name = sidstorage.read("name");
        companyName = sidstorage.read("companyName");
        companyStatus = sidstorage.read("companyStatus");
      });
      if (transporterId == null) {
        print("Transporter ID is null");
      } else {
        print("It is in else");
        shipperIdController.updateShipperId(transporterId!);
        shipperIdController.updateCompanyApproved(companyApproved!);
        shipperIdController.updateMobileNum(mobileNum!);
        shipperIdController.updateAccountVerificationInProgress(
            accountVerificationInProgress!);
        shipperIdController.updateShipperLocation(transporterLocation!);
        shipperIdController.updateName(name!);
        shipperIdController.updateCompanyName(companyName!);
        shipperIdController.updateCompanyName(companyStatus!);
        print("transporterID is $transporterId");
        
        Timer(const Duration(milliseconds: 1200), () => Get.off(() => NavigationScreen()));
      }
      //Timer(Duration(milliseconds: 1), () => Get.off(() => NavigationScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [shadowGrey, white])),
          padding: EdgeInsets.only(right: space_2, top: space_35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/images/liveasyTruck.png")),
              SizedBox(
                height: space_2,
              ),
              Container(
                child: Column(
                  children: [
                    Image(
                      image: const AssetImage("assets/images/logoSplashScreen.png"),
                      height: space_12,
                    ),
                    SizedBox(
                      height: space_3,
                    ),
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
