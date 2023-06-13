import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/functions/LaunchURL.dart';
import '/widgets/alertDialog/AppUpdateDialog.dart';

class ForceUpdateScreen extends StatefulWidget {
  const ForceUpdateScreen({Key? key}) : super(key: key);

  @override
  _ForceUpdateScreenState createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen> {
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: updateAvailableBackgroundColor
        ),
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
            Container(
              width: 264,
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We’re getting better!",
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
                  Text(
                    "To keep using Liveasy app, click on update to get new version.",
                    style: TextStyle(
                        fontSize: size_7,
                        fontWeight: normalWeight,
                        fontStyle: FontStyle.normal,
                        color: liveasyBlackColor
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 127,
              height: 38,
              child: TextButton(
                onPressed: () => launchURL(AppUpdateDialog.PLAY_STORE_URL),
                child: Text(
                    "Update",
                    style: TextStyle(
                        color: backgroundColor,
                        fontWeight: mediumBoldWeight,
                        fontStyle: FontStyle.normal,
                        fontSize: size_7
                    )
                ),
                style: TextButton.styleFrom(
                    backgroundColor: liveasyGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius_5 - 2)
                    )
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
