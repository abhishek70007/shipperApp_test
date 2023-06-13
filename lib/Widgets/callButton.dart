import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/ChooseReceiverButton.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CallButton extends StatelessWidget {
  final String? transporterPhoneNum;
  final String? driverPhoneNum;
  final String? driverName;
  final String? transporterName;

  final bool directCall;

  CallButton(
      {this.driverName,
      this.transporterName,
      this.transporterPhoneNum,
      this.driverPhoneNum,
      required this.directCall});

  _makingPhoneCall() async {
    print('in makingPhoneCall');
    String url = 'tel:$driverPhoneNum';
    UrlLauncher.launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      width: 80,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: darkBlueColor),
          )),
        ),
        onPressed: directCall == true
            ? () {
                _makingPhoneCall();
              }
            : () {
                Get.defaultDialog(
                  radius: 10,
                  title: 'Who do you want to call?',
                  titleStyle: TextStyle(
                      fontSize: size_8,
                      color: loadingPointTextColor,
                      fontWeight: mediumBoldWeight),
                  middleText: '',
                  content: Center(
                    child: Column(
                      children: [
                        ChooseReceiverButton(
                          label: transporterName,
                          phoneNum: transporterPhoneNum,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: space_2),
                          child: Text(
                            'or',
                            style: TextStyle(
                                fontSize: size_8,
                                fontWeight: mediumBoldWeight,
                                color: Colors.black),
                          ),
                        ),
                        ChooseReceiverButton(
                          label: driverName,
                          phoneNum: driverPhoneNum,
                        )
                      ],
                    ),
                  ),
                );
              },
        child: Container(
          margin: EdgeInsets.only(left: space_1),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: space_1),
                child: Image(
                  height: 16,
                  width: 11,
                  image: AssetImage(
                    'assets/icons/callButtonIcon.png',
                  ),
                ),
              ),
              Text(
                'Call',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0.7,
                  fontWeight: mediumBoldWeight,
                  color: Colors.black,
                  fontSize: size_7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
