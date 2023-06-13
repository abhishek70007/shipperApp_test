import 'package:flutter/material.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;


class ContactUsWidget extends StatefulWidget {

  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(left: space_1),
        child: GestureDetector(
          onTap: () {
            _callUs();
          },
          child: Container(
            padding: EdgeInsets.only(left: space_2),
            height: space_6,
            width: space_16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border:
                Border.all(width: borderWidth_10, color: darkBlueColor)),
            child: Center(
              child: Row(
                children: [
                  Container(
                    height: space_3,
                    width: space_3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/icons/helpIcon.png"))),
                  ),
                  SizedBox(
                    width: space_1,
                  ),
                  Text(
                    'Call Us',
                    style: TextStyle(fontSize: size_6, color: darkBlueColor),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
_callUs() async {
  String url = 'tel:8290748131';
  UrlLauncher.launch(url);
}
