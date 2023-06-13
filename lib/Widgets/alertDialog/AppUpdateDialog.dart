import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/functions/LaunchURL.dart';

class AppUpdateDialog extends StatefulWidget {
  AppUpdateDialog({Key? key}) : super(key: key);
  static const APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=com.liveasy.transport';

  @override
  _AppUpdateDialogState createState() => _AppUpdateDialogState();
}

class _AppUpdateDialogState extends State<AppUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Dialog(
          backgroundColor: updateAvailableBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
          ),
          child: Container(
            height: 275,
            width: 309,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/updateavailable.gif",
                    height: 124,
                    width: 164,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "We’re getting better!\nUpdate to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: size_9,
                        fontWeight: normalWeight,
                        fontStyle: FontStyle.normal,
                        color: liveasyBlackColor
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 82,
                        height: 32,
                        child: TextButton(
                          onPressed: () => launchURL(AppUpdateDialog.PLAY_STORE_URL),
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: updateAvailableBackgroundColor,
                                fontWeight: mediumBoldWeight,
                                fontStyle: FontStyle.normal,
                                fontSize: size_7
                            ),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: liveasyGreen,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radius_4 + 2)
                              ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 80,
                        height: 30,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                              "Later",
                              style: TextStyle(
                                  color: loadingPointTextColor,
                                  fontWeight: normalWeight,
                                  fontStyle: FontStyle.normal,
                                  fontSize: size_7
                              )
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: updateAvailableBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(radius_4 + 2),
                                  side: BorderSide(
                                      width: 1,
                                      color: bidBackground,
                                      style: BorderStyle.solid
                                  )
                              )
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      onWillPop: () async {
        return true;
      },
    );
  }
}