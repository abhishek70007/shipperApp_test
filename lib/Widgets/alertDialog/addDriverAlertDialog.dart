import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/functions/getDriverDetailsFromDriverApi.dart';
import '/functions/getTruckDetailsFromTruckApi.dart';
import '/functions/loadOnGoingData.dart';
import '/functions/postDriverTraccarApi.dart';
import '/models/responseModel.dart';
import '/providerClass/providerData.dart';
import '/widgets/buttons/addButton.dart';
// import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import '/widgets/buttons/cancelButtonForAddNewDriver.dart';
import 'package:provider/provider.dart';
import 'CompletedDialog.dart';
import 'conflictDialog.dart';
import 'loadingAlertDialog.dart';
import 'orderFailedAlertDialog.dart';

// ignore: must_be_immutable
class AddDriverAlertDialog extends StatefulWidget {
  final Function() notifyParent;

  AddDriverAlertDialog({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  _AddDriverAlertDialogState createState() => _AddDriverAlertDialogState();
}

class _AddDriverAlertDialogState extends State<AddDriverAlertDialog> {
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    ResponseModel returnResponse = ResponseModel();
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'driverName'.tr,
            // AppLocalizations.of(context)!.driverName,
            style: TextStyle(
                fontSize: size_9,
                fontWeight: normalWeight,
                color: liveasyBlackColor),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space_2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: driverNameController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'typeHere'.tr,
                        hintStyle: TextStyle(
                            color: textLightColor,
                            fontSize: size_8,
                            fontWeight: regularWeight),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        // print(driverNameController.text);
                        // print(driverNumberController.text);
                        //
                        // // if (await Permission.contacts.request().isGranted) {
                        //
                        // final PhoneContact contact =
                        //     await FlutterContactPicker.pickPhoneContact(
                        //         askForPermission: true);
                        // print("picked contact: $contact");
                        //
                        // setState(() {
                        //   String contactName = contact.fullName.toString();
                        //   driverNameController =
                        //       TextEditingController(text: contactName);
                        //
                        //   String contactNumber =
                        //       contact.phoneNumber!.number!.contains("+91")
                        //           ? contact.phoneNumber!.number!
                        //               .replaceRange(0, 3, "")
                        //               .replaceAll(new RegExp(r"\D"), "")
                        //           : contact.phoneNumber!.number!.toString();
                        //
                        //   driverNumberController =
                        //       TextEditingController(text: contactNumber);
                        // });
                      },
                      child: Image(
                        image:
                            AssetImage("assets/icons/addFromPhoneBookIcon.png"),
                        height: space_5 + 2,
                        width: space_5 + 2,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: space_2 + 2,
          ),
          Text(
            'driverNumber'.tr,
            // AppLocalizations.of(context)!.driverNumber,
            style: TextStyle(
                fontSize: size_9,
                fontWeight: normalWeight,
                color: liveasyBlackColor),
          ),
          SizedBox(
            height: space_2,
          ),
          Container(
            height: space_7 + 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_4 + 2),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: space_2),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: driverNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'typeHere'.tr,
                  // AppLocalizations.of(context)!.typeHere,
                  hintStyle: TextStyle(
                      color: textLightColor,
                      fontSize: size_8,
                      fontWeight: regularWeight),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AddButton(
                name: driverNameController.text,
                number: driverNumberController.text,
                onTap: () async {
                  if (driverNumberController.text.length == 10 &&
                      (driverNumberController.text
                          .startsWith(RegExp(r'[6-9]')))) {
                    ShipperIdController sIdController = Get.put(ShipperIdController());
                    String shipperId = '${sIdController.shipperId}' ;                // String? driverAdded = driverNameController.text;
                    // if (driverAdded == "") {
                    //   showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return LoadingAlertDialog();
                    //     },
                    //   );
                    // }
                    var uploadStatus = await postDriverTraccarApi(
                        driverNameController.text,
                        driverNumberController.text,
                        shipperId);
                    print(uploadStatus);
                    // ResponseModel? response =
                    //     await driverApiCalls.postDriverApi(
                    //         driverNameController.text,
                    //         driverNumberController.text,
                    //         transporterId);
                    if (uploadStatus != null) {
                      // if (response.statusCode == 201 && response.id != null) {
                      //   // driver added successfully8
                      //   showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return completedDialog(
                      //         upperDialogText: "Driver successfully Added !",
                      //         lowerDialogText: "",
                      //       );
                      //     },
                      //   );
                      if (uploadStatus == "successful") {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return completedDialog(
                              upperDialogText: "Driver successfully Added !",
                              lowerDialogText: "",
                            );
                          },
                        );
                        Timer(
                            Duration(seconds: 3),
                            () => {
                                  Get.back(),
                                  Get.back(),
                                  Get.back(),
                                  widget.notifyParent()
                                });

                        //For Book Now Alert Dialog
                        await getTruckDetailsFromTruckApi(context);
                        await getDriverDetailsFromDriverApi(context);

                        print(
                            "response id of driver ----->>${returnResponse.id}");

                        // providerData.updateDropDownValue(
                        //     );
                      } else if (uploadStatus == "conflict") {
                        // most likely user trying to add same number again
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ConflictDialog(
                                dialog: 'This driver is already added');
                          },
                        );
                      }
                    } else {
                      //response is null so error with api
                      Get.defaultDialog(
                        content: Container(
                          child: Column(
                            children: [
                              Text("Oops!! Error!"),
                              Text("Please Try Again Later")
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    //user entered an invalid mobile number
                    Get.defaultDialog(
                      content: Container(
                        child: Column(
                          children: [
                            Text('error'.tr + '!'
                                // AppLocalizations.of(context)!.error +"!"
                                ),
                            Text('enterValid10DigitNumber'.tr
                                // AppLocalizations.of(context)!.enterValid10DigitNumber
                                )
                          ],
                        ),
                      ),
                    );
                    //user entered an invalid mobile number
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return OrderFailedAlertDialog();
                      },
                    );
                  }
                }),
            CancelButtonForAddNewDriver()
          ],
        )
      ],
      contentPadding:
          EdgeInsets.symmetric(horizontal: space_3, vertical: space_4),
      actionsPadding: EdgeInsets.only(top: space_8, bottom: space_3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
      insetPadding: EdgeInsets.only(left: space_4, right: space_4),
    );
  }
}
