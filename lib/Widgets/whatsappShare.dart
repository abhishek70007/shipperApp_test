import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WhatsappShare extends StatefulWidget {
  int deviceId;
 // String? truckId;
  String? truckNo;
  WhatsappShare({
    required this.deviceId,
   // required this.truckId,
    required this.truckNo,
  });
  @override
  _WhatsappShareState createState() => _WhatsappShareState();
}

class _WhatsappShareState extends State<WhatsappShare> {
  var timeDuration = 24;

  var currentDate = DateTime.now();

  var expiryTime;

  int selectedIndex = 0;

  ByteData? bytes;

  bool _isCreateLink = false;

  String? _stringUrl;

  List<String> lst = ['1Day'.tr, '2Days'.tr, '7Days'.tr];
  List<int> expiryHours = [24, 48, 168];

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> _createDynamicLink(bool short) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _isCreateLink = true;
    });
    String packageName = packageInfo.packageName;
    // String shareUrl = FlutterConfig.get('shareUrl').toString();
    String shareUrl = dotenv.get('shareUrl');

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: shareUrl,
      link: Uri.parse(
          '$shareUrl/track?deviceId=${widget.deviceId}&truckno=${widget.truckNo}&duration=${expiryTime}'),
      androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: 0,
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
      print("Dynamic URL is $url");
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    //   url = await parameters.buildUrl();
    print("Dynamic URL is $url");
    setState(() {
      _stringUrl = url.toString();
      _isCreateLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    expiryTime = currentDate.add(
        Duration(hours: expiryHours[selectedIndex], minutes: 0, seconds: 0));
    print("SELECTED EXPIRY: ${expiryHours[selectedIndex]} hours");
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(space_4)),
      elevation: space_0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, top: 45, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.black,
              //       offset: Offset(0, 10),
              //       blurRadius: 10),
              // ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'whatsappShare'.tr,
                  style: TextStyle(fontSize: size_10, fontWeight: boldWeight),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: space_4,
                ),
                Text(
                  'setExpiry'.tr,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: space_2,
                ),
                Container(
                  alignment: Alignment.center,
                  //width: space_16,
                  //height: space_8,
                  //margin:
                  //EdgeInsets.fromLTRB(space_8, space_0, space_8, space_0),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        customExpiryButton(lst[0], 0),
                        customExpiryButton(lst[1], 1),
                        customExpiryButton(lst[2], 2),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: space_8,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: activeButtonColor,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: darkBlueColor)))),
                          child: Text(
                            'share'.tr,
                            // AppLocalizations.of(context)!.next,
                            style: TextStyle(
                              color: white,
                            ),
                          ),
                          onPressed: () async {
                            await _createDynamicLink(true);
                            EasyLoading.instance
                              ..indicatorType = EasyLoadingIndicatorType.ring
                              ..indicatorSize = 45.0
                              ..radius = 10.0
                              ..maskColor = darkBlueColor
                              ..userInteractions = false
                              ..backgroundColor = darkBlueColor
                              ..dismissOnTap = false;
                            EasyLoading.show(
                              status: "Loading...",
                            );
                            await Share.share(
                              "To check the location of ${widget.truckNo},click on the link $_stringUrl",
                            ).then((value) => EasyLoading.dismiss());
                          }),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: calendarColor,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: darkBlueColor)))),
                          child: Text(
                            'cancel'.tr,
                            // AppLocalizations.of(context)!.next,
                            style: TextStyle(
                              color: darkBlueColor,
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkBlueColor,
                    ),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/whatsappWhiteBorderIcon.png",
                          width: 38,
                          height: 38,
                        )),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget customExpiryButton(String txt, int index) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(space_10),
    //   child:
    return OutlinedButton(
        onPressed: () => changeIndex(index),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                        color:
                            selectedIndex == index ? white : darkBlueColor))),
            backgroundColor: MaterialStateProperty.all<Color>(
                selectedIndex == index ? darkBlueColor : white)),
        child: Text(txt,
            style: TextStyle(
                color: selectedIndex == index ? white : darkBlueColor)));
    //);
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
