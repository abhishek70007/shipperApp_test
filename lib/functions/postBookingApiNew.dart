import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:intl/intl.dart';
import '/controller/shipperIdController.dart';
import '/models/loadDetailsScreenModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


postBookingApiNew(LoadDetailsScreenModel? loadDetailsScreenModel, truckId,
    deviceId, driverName, driverPhoneNo) async {
  ShipperIdController tIdController = Get.put(ShipperIdController());
  String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  // String now = DateFormat("dd-MM-yyyy").format(DateTime.now().subtract(Duration(hours: 5, minutes: 30))
  //     .toIso8601String());
  var jsonData;
  try {
    Map datanew = {
      "transporterId": tIdController.shipperId.toString(),
      "loadId": loadDetailsScreenModel!.loadId,
      "postLoadId": loadDetailsScreenModel.postLoadId,
      "loadingPointCity": loadDetailsScreenModel.loadingPointCity,
      "unloadingPointCity": loadDetailsScreenModel.unloadingPointCity,
      "truckNo": truckId,
      "driverName": driverName,
      "driverPhoneNum": driverPhoneNo,
      "deviceId": deviceId,
      "rate": null,
      "unitValue": null,
      "truckId": [truckId],
      "cancel": false,
      "completed": false,
      "bookingDate": now,
      "completedDate": null,
      "timestamp": now
    };
    String body = json.encode(datanew);
    // final String bookingApiUrl = FlutterConfig.get('bookingApiUrl').toString();
    final String bookingApiUrl = dotenv.get('bookingApiUrl');

    final response = await http.post(Uri.parse("$bookingApiUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    print(response.body);
    jsonData = json.decode(response.body);

    // if (jsonData["bookingId"] != null) {
    //   Get.snackbar('Booking Successful', '', snackPosition: SnackPosition.TOP);
    // } else
    //   Get.snackbar('Booking Unsuccessful', '',
    //       snackPosition: SnackPosition.TOP);
    if (response.statusCode == 201) {
      print(response);
      return "successful";
    } else if (response.statusCode == 409) {
      print("conflict");
      return "conflict";
    } else {
      return "unsuccessful";
    }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
