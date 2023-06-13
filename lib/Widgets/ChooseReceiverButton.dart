import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ChooseReceiverButton extends StatelessWidget {
   String? label;

  // final dynamic function ;
  final String? phoneNum;

  ChooseReceiverButton({super.key, required this.label, required this.phoneNum});

  _makingPhoneCall() async {
    print('in makingPhoneCall');
    String url = 'tel:$phoneNum';
    UrlLauncher.launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {

    label = label!.length >= 12
        ? label!.substring(0, 10) + '..'
        : label;
    return SizedBox(
      width: 163,
      height: 40,
      child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: darkBlueColor),
            )),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: space_1),
                child: const Image(
                  height: 16,
                  width: 11,
                  image: AssetImage(
                    'assets/icons/callButtonIcon.png',
                  ),
                ),
              ),
              Text(
                label != null ? '$label' : 'NA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 0.7,
                  fontWeight: mediumBoldWeight,
                  color: bidBackground,
                  fontSize: size_8,
                ),
              ),
            ],
          ),
          onPressed: () {
            _makingPhoneCall();
          }),
    );
  }
}
