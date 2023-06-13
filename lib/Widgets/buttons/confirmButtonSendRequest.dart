import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/navigationIndexController.dart';
import '/functions/postBookingApi.dart';
import '/functions/postBookingApiNew.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/biddingModel.dart';
import '/models/loadDetailsScreenModel.dart';
import '/providerClass/providerData.dart';
import '/screens/navigationScreen.dart';
import '/widgets/alertDialog/CompletedDialog.dart';
import '/widgets/alertDialog/conflictDialog.dart';
import '/widgets/alertDialog/loadingAlertDialog.dart';
import '/widgets/alertDialog/orderFailedAlertDialog.dart';
import '/widgets/buttons/elevatedButtonWidgetThree.dart';
import '/widgets/elevatedButtonforAddNewDriver.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class ConfirmButtonSendRequest extends StatefulWidget {
  bool? directBooking;
  String? truckId;
  int? selectedDeviceId;
  BiddingModel? biddingModel;
  String? selectedDriverName;
  String? selectedDriverPhoneno;
  String? postLoadId;
  LoadDetailsScreenModel? loadDetailsScreenModel;

  ConfirmButtonSendRequest(
      {this.directBooking,
      this.truckId,
      this.selectedDeviceId,
      this.biddingModel,
      this.postLoadId,
      this.loadDetailsScreenModel,
      this.selectedDriverName,
      this.selectedDriverPhoneno});

  @override
  _ConfirmButtonSendRequestState createState() =>
      _ConfirmButtonSendRequestState();
}

TruckApiCalls truckApiCalls = TruckApiCalls();

class _ConfirmButtonSendRequestState extends State<ConfirmButtonSendRequest> {
  update_status() async {
    try {
      Map datanew = {"status": "ON_GOING"};
      String body = json.encode(datanew);
      // final String loadApiUrl = FlutterConfig.get('loadApiUrl').toString();
      final String loadApiUrl = dotenv.get('loadApiUrl');

      final response = await http.put(
          Uri.parse("$loadApiUrl/" +
              widget.loadDetailsScreenModel!.loadId.toString()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
      print("put update result ========== ");
      print(response.body);
    } catch (e) {
      print(e.toString());
      // return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    getBookingData() async {
      String? bookResponse = "";
      if (bookResponse == "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingAlertDialog();
          },
        );
      }
      if (widget.directBooking == true) {
        //truckApiCalls.updateDriverIdForTruck(
        //  driverID: widget.selectedDriver, truckID: widget.truckId);
        bookResponse = await postBookingApiNew(
          widget.loadDetailsScreenModel,
          widget.truckId,
          widget.selectedDeviceId,
          widget.selectedDriverName,
          widget.selectedDriverPhoneno,
        );
        print("directBooking");
      } else {
        //truckApiCalls.updateDriverIdForTruck(
        //  driverID: widget.selectedDriver, truckID: widget.truckId);
        bookResponse = await postBookingApi(
          widget.biddingModel!.loadId,
          widget.biddingModel!.currentBid,
          widget.biddingModel!.unitValue,
          widget.truckId,
          widget.postLoadId,
          widget.loadDetailsScreenModel!.rate,
        );
      }
      print("----------------------------->Book response:$bookResponse");
      print(
          "----------------------------->screen model:${widget.loadDetailsScreenModel}");
      print("----------------------------->truck Id:${widget.truckId}");
      print(
          "----------------------------->device id:${widget.selectedDeviceId}");
      print("----------------------------->name:${widget.selectedDriverName}");
      print(
          "----------------------------->phone:${widget.selectedDriverPhoneno}");
      if (bookResponse == "successful") {
        print(bookResponse);
        update_status();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return completedDialog(
              upperDialogText: "Your booking is confirmed",
              lowerDialogText: "",
            );
          },
        );
        Timer(
            Duration(seconds: 3),
            () => {
                  providerData.updateUpperNavigatorIndex(1),
                  Get.offAll(NavigationScreen()),
                  navigationIndexController.updateIndex(3),
                });
      } else if (bookResponse == "conflict") {
        // change this according to the booking response
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ConflictDialog(dialog: 'You have already booked this load');
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return OrderFailedAlertDialog();
          },
        );
        // Get.snackbar("${postLoadErrorController.error.value}", "failed");
        // postLoadErrorController.resetPostLoadError();
        // print(postLoadErrorController.error.value.toString());
        // Timer(
        //     Duration(seconds: 1),
        //     () => {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return OrderFailedAlertDialog(
        //                   postLoadErrorController.error.value.toString());
        //             },
        //           )
        //         });
      }
    }

    if (widget.biddingModel != null) {
      widget.biddingModel!.unitValue =
          widget.biddingModel!.unitValue == 'tonne' ? 'PER_TON' : 'PER_TRUCK';
    }

    // return
    // GestureDetector(
    //   onTap: widget.truckId != null
    //       ? () {
    //           getBookingData();
    //         }
    //       : null,
    //   child:
    return ElevatedButtonWidgetThree(
        condition: widget.truckId != null &&
            widget.selectedDriverName != null &&
            widget.selectedDriverPhoneno != null,
        text: "Continue Booking",
        onPressedConditionTrue: () {
          getBookingData();
        });
    // Container(
    //   margin: EdgeInsets.only(bottom: 50, left: 10, right: 10),
    //   child: Align(
    //     alignment: FractionalOffset.bottomCenter,
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(15),
    //         color: darkBlueColor,
    //       ),
    //       height: 75,
    //       width: 290,
    //       child: Center(
    //         child: Text(
    //           "Continue Booking",
    //           style: TextStyle(
    //             color: white,
    //             fontWeight: FontWeight.bold,
    //             fontSize: size_12,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ),
    // );
  }
}
