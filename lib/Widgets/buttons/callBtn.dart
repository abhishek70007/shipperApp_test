import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/widgets/ChooseReceiverButton.dart';
import '/widgets/alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class callBtn extends StatelessWidget {
  // final String? transporterPhoneNum;
  // final String? driverPhoneNum;
  // final String? driverName;
  // final String? transporterName;
  final String? phoneNum;
  String? name;

  final bool directCall;

  callBtn(
      {
      //   this.driverName,
      // this.transporterName,
      // this.transporterPhoneNum,
      // this.driverPhoneNum,
      this.name,
      required this.directCall,
      this.phoneNum});

  _makingPhoneCall() async {
    if (phoneNum != null) {
      String url = 'tel:$phoneNum';
      UrlLauncher.launch(url);
    }
  }

  ShipperIdController tIdController = Get.put(ShipperIdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            // side: BorderSide(color: darkBlueColor)
          )),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed:
            //  directCall == true
            // ?
            () async {
          // if (tIdController.transporterApproved.value) {
          _makingPhoneCall();
          // } else {
          //   showDialog(
          //       context: context,
          //       builder: (context) => VerifyAccountNotifyAlertDialog());
          // }
        },
        // : () async {
        //     if (tIdController.transporterApproved.value) {
        //       Get.defaultDialog(
        //         radius: 10,
        //         title: 'Who do you want to call?',
        //         titleStyle: TextStyle(
        //             fontSize: size_8,
        //             color: loadingPointTextColor,
        //             fontWeight: mediumBoldWeight),
        //         middleText: '',
        //         content: Center(
        //           child: Column(
        //             children: [
        //               ChooseReceiverButton(
        //                 label: (transporterName != null)
        //                     ? transporterName!
        //                     : "",
        //                 phoneNum: transporterPhoneNum,
        //               ),
        //               Container(
        //                 margin: EdgeInsets.symmetric(vertical: space_2),
        //                 child: Text(
        //                   'or',
        //                   style: TextStyle(
        //                       fontSize: size_8,
        //                       fontWeight: mediumBoldWeight,
        //                       color: Colors.black),
        //                 ),
        //               ),
        //               ChooseReceiverButton(
        //                 label: (driverName != null) ? driverName! : "",
        //                 phoneNum: driverPhoneNum,
        //               )
        //             ],
        //           ),
        //         ),
        //       );
        //     } else {
        //       showDialog(
        //           context: context,
        //           builder: (context) => VerifyAccountNotifyAlertDialog());
        //     }
        // },
        child: Container(
          margin: EdgeInsets.only(left: space_1),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: space_1),
                child: Image(
                  height: 18,
                  width: 15,
                  image: AssetImage(
                    'assets/icons/callButtonIcon.png',
                  ),
                  color: darkBlueColor,
                ),
              ),
              Text(
                'call'.tr,
                // AppLocalizations.of(context)!.call,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 0.7,
                    color: darkBlueColor,
                    fontSize: size_8,
                    fontWeight: mediumBoldWeight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
