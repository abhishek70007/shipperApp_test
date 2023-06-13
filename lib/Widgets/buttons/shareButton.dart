import 'dart:typed_data';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/models/WidgetLoadDetailsScreenModel.dart';
import '/models/loadDetailsScreenModel.dart';
import '/widgets/shareImageWidget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:package_info/package_info.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: must_be_immutable
class ShareButton extends StatefulWidget {
  LoadDetailsScreenModel loadDetails;
  String? loadingPointCity;
  WidgetLoadDetailsScreenModel widgetLoadDetailsScreenModel;

  ShareButton(
      {this.loadingPointCity,
      required this.loadDetails,
      required this.widgetLoadDetailsScreenModel});

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  ByteData? bytes;

  bool _isCreateLink = false;

  String? _stringUrl;

  ScreenshotController screenshotController = ScreenshotController();

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
      link: Uri.parse('$shareUrl/${widget.loadDetails.loadId}'),
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

    setState(() {
      _stringUrl = url.toString();
      _isCreateLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
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
        await screenshotController
            .captureFromWidget(InheritedTheme.captureAll(
                context, Material(child: shareImageWidget(widget.loadDetails))))
            .then((capturedImage) async {
          var pngBytes = capturedImage.buffer.asUint8List();
          await WcFlutterShare.share(
                  sharePopupTitle: 'share',
                  subject: 'This is subject',
                  text:
                      "loadAvailable".tr +"\n$_stringUrl\n\n" +"callonthisnum".tr +" ${widget.widgetLoadDetailsScreenModel.phoneNo} \n\n"+ "moreLoad".tr,
                  fileName: 'share.png',
                  mimeType: 'image/png',
                  bytesOfFile: pngBytes)
              .then((value) => EasyLoading.dismiss());
        });
      },
      child: Container(
        height: space_8,
        width: (space_10 * 2) + 6,
        decoration: BoxDecoration(
            color: liveasyGreen, borderRadius: BorderRadius.circular(space_6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage("assets/icons/whatsappGreenIcon.png"),
                height: size_9 - 1,
                width: size_9 - 1),
            SizedBox(
              width: space_1 - 0.5,
            ),
            Text(
              'share'.tr,
              // AppLocalizations.of(context)!.share,
              style: TextStyle(
                  fontSize: size_8, fontWeight: normalWeight, color: white),
            )
          ],
        ),
      ),
    );
  }
}
