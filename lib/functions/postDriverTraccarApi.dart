import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:intl/intl.dart';
import '/controller/shipperIdController.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


postDriverTraccarApi(DriverName, DriverPhoneNo, TransporterId) async {
  // shipperIdController tIdController = Get.put(shipperIdController());

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));
  var jsonData;
  try {
    Map data = {
      "name": DriverName,
      "attributes": {"phone": DriverPhoneNo},
      "uniqueId": DriverPhoneNo
    };
    String body = json.encode(data);
    final String DriverTraccarApiUrl =
        // FlutterConfig.get('traccarApi').toString();
           dotenv.get('traccarApi');
    final response =
        await http.post(Uri.parse("$DriverTraccarApiUrl" + "/drivers"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': basicAuth,
            },
            body: body);
    print(response.body);
    if (response.statusCode == 400) {
      print("Mobile number already exists");
      return "conflict";
    }
    jsonData = json.decode(response.body);

    // if (jsonData["bookingId"] != null) {
    //   Get.snackbar('Booking Successful', '', snackPosition: SnackPosition.TOP);
    // } else
    //   Get.snackbar('Booking Unsuccessful', '',
    //       snackPosition: SnackPosition.TOP);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return "successful";
    } else if (response.statusCode == 409) {
      print("conflict");
      return "conflict";
    } else {
      return "unsuccessful";
    }
  } catch (e) {
    return e.toString();
  }
}
