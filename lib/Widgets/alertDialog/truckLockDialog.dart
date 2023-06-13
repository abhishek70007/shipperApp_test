import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/colors.dart';
import '/constants/fontWeights.dart';
import '/controller/lockUnlockController.dart';
import '/functions/truckApis/truckLockApiCalls.dart';
import '/screens/tryAgainLaterScreen.dart';
import '/widgets/alertDialog/nextUpdateAlertDialog.dart';

class TruckLockDialog extends StatefulWidget {
  final List gpsData;
  final List gpsDataHistory;
  final List gpsStoppageHistory;
  //final List routeHistory;
  final String? TruckNo;
  final int? deviceId;
  final String? driverNum;
  final String? driverName;
  final String? truckId;
  String? value;

  TruckLockDialog(
      {required this.gpsData,
      required this.gpsDataHistory,
      required this.gpsStoppageHistory,
      //required this.routeHistory,
      // required this.position,
      this.TruckNo,
      this.driverName,
      this.driverNum,
      this.deviceId,
      this.truckId,
      this.value});

  @override
  _TruckLockDialogState createState() => _TruckLockDialogState();
}

class _TruckLockDialogState extends State<TruckLockDialog> {
  final lockStorage = GetStorage();
  LockUnlockController lockUnlockController = Get.put(LockUnlockController());
  var lockState;
  var routeHistory;
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
                    "Kya aap pakka truck ko ${widget.value} karna chahte hai?"
                        .tr,
                    style: TextStyle(fontSize: 20, fontWeight: boldWeight),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Aapke lock karne tak truck unlock hi rahega".tr,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 22,
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
                            "${widget.value}".tr,
                            // AppLocalizations.of(context)!.next,
                            style: TextStyle(
                              color: white,
                            ),
                          ),
                          onPressed: () async {
                            // var testTime = DateTime.now().toUtc();
                            // var testTime1 = DateTime.now()
                            //     .toUtc()
                            //     .add(Duration(minutes: 1));
                            // print(
                            //     "_____________________________________________testTime:$testTime");
                            // print(
                            //     "_____________________________________________testTime1:$testTime1");
                            if (widget.value == "Unlock") {
                              await getTruckCommandExist(widget.deviceId)
                                  .then((boolValue) async {
                                var temp = "";
                                if (boolValue.length > 9) {
                                  temp = boolValue.toString().substring(9);
                                }
                                if (boolValue != "Null" &&
                                    boolValue != "Error" &&
                                    temp != "") {
                                  print(int.parse(temp));
                                  await putCommands(
                                          int.parse(temp), widget.value)
                                      .then((value) async {
                                    EasyLoading.instance
                                      ..indicatorType =
                                          EasyLoadingIndicatorType.ring
                                      ..indicatorSize = 45.0
                                      ..radius = 10.0
                                      ..maskColor = darkBlueColor
                                      ..userInteractions = false
                                      ..backgroundColor = darkBlueColor
                                      ..dismissOnTap = false;
                                    EasyLoading.show(
                                      status: "Loading...",
                                    );
                                    Timer(Duration(seconds: 10), () {
                                      if (value == "Success") {
                                        EasyLoading.dismiss();
                                        print("THE COMMAND WENT PROPERLY");
                                        setState(() {
                                          lockState = true;
                                          lockStorage.write(
                                              'lockState', lockState);
                                          lockUnlockController
                                              .lockUnlockStatus.value = true;
                                          lockUnlockController
                                              .updateLockUnlockStatus(true);
                                        });
                                        Get.back();
                                      }
                                    });
                                  });
                                }
                              });
                            } else if (widget.value == "Lock") {
                              await getTruckCommandExist(widget.deviceId)
                                  .then((boolValue) async {
                                var temp = "";
                                if (boolValue.length > 9) {
                                  temp = boolValue.toString().substring(9);
                                }
                                if (boolValue != "Null" &&
                                    boolValue != "Error" &&
                                    temp != "") {
                                  print(int.parse(temp));
                                  await putCommands(
                                          int.parse(temp), widget.value)
                                      .then((value) async {
                                    EasyLoading.instance
                                      ..indicatorType =
                                          EasyLoadingIndicatorType.ring
                                      ..indicatorSize = 45.0
                                      ..radius = 10.0
                                      ..maskColor = darkBlueColor
                                      ..userInteractions = false
                                      ..backgroundColor = darkBlueColor
                                      ..dismissOnTap = false;
                                    EasyLoading.show(
                                      status: "Loading...",
                                    );
                                    Timer(Duration(seconds: 10), () {
                                      if (value == "Success") {
                                        EasyLoading.dismiss();
                                        print("THE COMMAND WENT PROPERLY");
                                        setState(() {
                                          lockState = false;
                                          lockStorage.write(
                                              'lockState', lockState);
                                          lockUnlockController
                                              .lockUnlockStatus.value = false;
                                          lockUnlockController
                                              .updateLockUnlockStatus(false);
                                        });
                                        Get.back();
                                      }
                                    });
                                  });
                                } else {
                                  await postCommandsApi(
                                          widget.gpsData,
                                          widget.gpsDataHistory,
                                          widget.gpsStoppageHistory,
                                          //routeHistory,
                                          widget.driverNum,
                                          widget.TruckNo,
                                          widget.driverName,
                                          widget.truckId,
                                          widget.deviceId,
                                          "engineResume",
                                          "sendingUnlock")
                                      .then((uploadstatus) async {
                                    if (uploadstatus == "Success") {
                                      print("SENT UNLOCK TO DEVICE");
                                      EasyLoading.instance
                                        ..indicatorType =
                                            EasyLoadingIndicatorType.ring
                                        ..indicatorSize = 45.0
                                        ..radius = 10.0
                                        ..maskColor = darkBlueColor
                                        ..userInteractions = false
                                        ..backgroundColor = darkBlueColor
                                        ..dismissOnTap = false;
                                      EasyLoading.show(
                                        status: "Loading...",
                                      );
                                      Timer(Duration(seconds: 10), () {
                                        if (uploadstatus == "Success") {
                                          EasyLoading.dismiss();
                                          print("THE COMMAND WENT PROPERLY");
                                          setState(() {
                                            lockState = false;
                                            lockStorage.write(
                                                'lockState', lockState);
                                            lockUnlockController
                                                .lockUnlockStatus.value = false;
                                            lockUnlockController
                                                .updateLockUnlockStatus(false);
                                          });
                                          Get.back();
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            }

                            //---------------------------------------------------------------------------
                            // if (widget.value == "Unlock") {
                            //   await postCommandsApi(
                            //           widget.gpsData,
                            //           widget.gpsDataHistory,
                            //           widget.gpsStoppageHistory,
                            //           //routeHistory,
                            //           widget.driverNum,
                            //           widget.TruckNo,
                            //           widget.driverName,
                            //           widget.truckId,
                            //           widget.deviceId,
                            //           "engineResume",
                            //           "sendingUnlock")
                            //       .then((uploadstatus) async {
                            //     // setState(() {});
                            //     if (uploadstatus == "Success") {
                            //       print("SENT UNLOCK TO DEVICE");
                            //       EasyLoading.instance
                            //         ..indicatorType =
                            //             EasyLoadingIndicatorType.ring
                            //         ..indicatorSize = 45.0
                            //         ..radius = 10.0
                            //         ..maskColor = darkBlueColor
                            //         ..userInteractions = false
                            //         ..backgroundColor = darkBlueColor
                            //         ..dismissOnTap = false;
                            //       EasyLoading.show(
                            //         status: "Loading...",
                            //       );
                            //       var timeNow =
                            //           DateTime.now().toUtc().toIso8601String();
                            //       Future.delayed(Duration(minutes: 2), () {
                            //         Timer(Duration(seconds: 50), () {
                            //           getCommandsResultApi(
                            //                   widget.deviceId, timeNow)
                            //               .then((lockStatus) {
                            //             if (lockStatus == "unlock") {
                            //               EasyLoading.dismiss();
                            //               print("THE COMMAND WENT PROPERLY");
                            //               setState(() {
                            //                 lockState = true;
                            //                 lockStorage.write(
                            //                     'lockState', lockState);
                            //                 lockUnlockController
                            //                     .lockUnlockStatus.value = true;
                            //                 lockUnlockController
                            //                     .updateLockUnlockStatus(true);
                            //               });
                            //               // lockState = true;
                            //               // lockStorage.write(
                            //               //     'lockState', lockState);
                            //             } else if (lockStatus == "null") {
                            //               print("THE COMMAND WENT NULL");
                            //               Get.back();
                            //               print("HERE");
                            //               // showDialog(
                            //               //     context: context,
                            //               //     builder: (dialogcontext) =>
                            //               //         NextUpdateAlertDialog());
                            //               Get.to(() => TryAgainLaterScreen(
                            //                   deviceId: widget.deviceId,
                            //                   gpsData: widget.gpsData,
                            //                   // position: position,
                            //                   TruckNo: widget.TruckNo,
                            //                   driverName: widget.driverName,
                            //                   driverNum: widget.driverNum,
                            //                   gpsDataHistory:
                            //                       widget.gpsDataHistory,
                            //                   gpsStoppageHistory:
                            //                       widget.gpsStoppageHistory,
                            //                   //routeHistory: widget.routeHistory,
                            //                   truckId: widget.truckId));
                            //             }
                            //           });
                            //           EasyLoading.dismiss();
                            //           Navigator.pop(context, true);
                            //         });
                            //       });
                            //       //lockState = true;
                            //       //lockStorage.write('lockState', lockState);
                            //     } else {
                            //       print("PROBLEM IN SENDING TO DEVICE");
                            //     }
                            //   });
                            // } else if (widget.value == "Lock") {
                            //   // setState(() {});
                            //   await postCommandsApi(
                            //           widget.gpsData,
                            //           widget.gpsDataHistory,
                            //           widget.gpsStoppageHistory,
                            //           //routeHistory,
                            //           widget.driverNum,
                            //           widget.TruckNo,
                            //           widget.driverName,
                            //           widget.truckId,
                            //           widget.deviceId,
                            //           "engineStop",
                            //           "sendingLock")
                            //       .then((uploadstatus) async {
                            //     if (uploadstatus == "Success") {
                            //       print("SENT LOCK TO DEVICE");
                            //       EasyLoading.instance
                            //         ..indicatorType =
                            //             EasyLoadingIndicatorType.ring
                            //         ..indicatorSize = 45.0
                            //         ..radius = 10.0
                            //         ..maskColor = darkBlueColor
                            //         ..userInteractions = false
                            //         ..backgroundColor = darkBlueColor
                            //         ..dismissOnTap = false;
                            //       EasyLoading.show(
                            //         status: "Loading...",
                            //       );
                            //       var timeNow = DateTime.now()
                            //           .subtract(Duration(hours: 5, minutes: 30))
                            //           .toIso8601String();
                            //       Timer(Duration(seconds: 15), () {
                            //         getCommandsResultApi(
                            //                 widget.deviceId, timeNow)
                            //             .then((lockStatus) {
                            //           if (lockStatus == "lock") {
                            //             EasyLoading.dismiss();
                            //             print("THE COMMAND WENT PROPERLY");
                            //             setState(() {
                            //               lockState = false;
                            //               lockStorage.write(
                            //                   'lockState', lockState);
                            //               lockUnlockController
                            //                   .lockUnlockStatus.value = false;
                            //               lockUnlockController
                            //                   .updateLockUnlockStatus(false);
                            //             });
                            //             // lockState = false;
                            //             // lockStorage.write(
                            //             //     'lockState', lockState);
                            //           } else if (lockStatus == "null") {
                            //             print("THE COMMAND WENT NULL");
                            //             Get.back();
                            //             print("HERE");
                            //             // showDialog(
                            //             //     context: context,
                            //             //     builder: (dialogcontext) =>
                            //             //         NextUpdateAlertDialog());
                            //             Get.to(() => TryAgainLaterScreen(
                            //                 deviceId: widget.deviceId,
                            //                 gpsData: widget.gpsData,
                            //                 // position: position,
                            //                 TruckNo: widget.TruckNo,
                            //                 driverName: widget.driverName,
                            //                 driverNum: widget.driverNum,
                            //                 gpsDataHistory:
                            //                     widget.gpsDataHistory,
                            //                 gpsStoppageHistory:
                            //                     widget.gpsStoppageHistory,
                            //                 //routeHistory: widget.routeHistory,
                            //                 truckId: widget.truckId));
                            //           }
                            //         });
                            //         EasyLoading.dismiss();
                            //         Navigator.pop(context, true);
                            //       });
                            //       //lockState = false;
                            //       //lockStorage.write('lockState', lockState);
                            //     } else {
                            //       print("PROBLEM IN SENDING TO DEVICE");
                            //     }
                            //   });
                            // }
                            // Navigator.pop(context, true);
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
                      boxShadow: [
                        //color: Colors.white, //background color of box
                        BoxShadow(
                          color: darkBlueColor,
                          blurRadius: 50.0, // soften the shadow
                          spreadRadius: 50.0, //extend the shadow
                          offset: Offset(
                            15.0, // Move to right 10  horizontally
                            15.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/smallTruckLockIcon.png",
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
