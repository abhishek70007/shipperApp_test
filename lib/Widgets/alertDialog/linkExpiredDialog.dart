import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontWeights.dart';

class LinkExpiredDialog extends StatefulWidget {
  const LinkExpiredDialog({Key? key}) : super(key: key);

  @override
  _LinkExpiredDialogState createState() => _LinkExpiredDialogState();
}

class _LinkExpiredDialogState extends State<LinkExpiredDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: 20, top: 45 + 20, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'linkExpired'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: boldWeight),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'linkExpiredInstruction'.tr,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: activeButtonColor,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: darkBlueColor)))),
                    child: Text(
                      'cancel'.tr,
                      // AppLocalizations.of(context)!.next,
                      style: TextStyle(
                        color: white,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    })
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
                          "assets/icons/sadSmileIcon.png",
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
}
