import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/screens/ForceUpdateScreen.dart';
import '/widgets/alertDialog/AppUpdateDialog.dart';
import 'package:package_info/package_info.dart';

Future<void> versionCheck(BuildContext context) async {
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  try {
    RemoteConfig _remoteConfig = RemoteConfig.instance;
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(
          seconds: 1),
      minimumFetchInterval: Duration(
          seconds:
          10),
    ));
    await _remoteConfig.fetchAndActivate();
    double normalversion = double.parse(
        (_remoteConfig.getString("normal_update_version"))
            .replaceAll('"', "")
            .replaceAll(".", ""));
    double forceupdateversion = double.parse(
        (_remoteConfig.getString("force_update_version"))
            .replaceAll('"', "")
            .replaceAll(".", ""));
    if (currentVersion < forceupdateversion) {
      Get.to(() => ForceUpdateScreen());
    } else if (currentVersion < normalversion) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context)=> AppUpdateDialog());
    } else {
      print("You can go");
    }
  } catch (e) {
    print("Exception in App Version Check is $e");
  }
}