import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getDocumentApiCall(String bookingId, String docType) async {
  // shipperIdController tIdController = Get.put(shipperIdController());
  // String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
  // String now = DateFormat("dd-MM-yyyy").format(DateTime.now().subtract(Duration(hours: 5, minutes: 30))
  //     .toIso8601String())
  // ;
  bool dataExist = false;
  var jsonData;
  var docLinks = [];
  try {
    // Map datanew = {
    //   "entityId": bookingId,
    //   "documents": [
    //     {"documentType": documentType, "data": photo64code}
    //   ],
    // };
    // print(datanew2);
    // String body = json.encode(datanew2);
    final String documentApiUrl =
        // FlutterConfig.get('documentApiUrl').toString();
        dotenv.get('documentApiUrl');

    // print("api from getDocumentApiCall $documentApiUrl/$bookingId");
    final response = await http.get(Uri.parse("$documentApiUrl/$bookingId"));
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    // body: body);
    if (response.statusCode == 404) {
      return [];
    }
    print("from getDocumentApiCall ${response.body}");
    jsonData = json.decode(response.body);
    print("from getDocumentApiCall ${response.body}");
    for (var jsondata in jsonData["documents"]) {
      print(jsondata["documentType"]);
      if (jsondata["documentType"][0] == docType) {
        docLinks.add(jsondata["documentLink"]);
        // dataExist = true;
        // return true;
      }
    }

    return docLinks;
    // return dataExist;
    // print(jsonData["documents"][1]["documentType"]);
    // return jsonData;
    // return response;
    // if (jsonData["bookingId"] != null) {
    //   Get.snackbar('Booking Successful', '', snackPosition: SnackPosition.TOP);
    // } else
    //   Get.snackbar('Booking Unsuccessful', '',
    //       snackPosition: SnackPosition.TOP);
    // if (response.statusCode == 201) {
    //   print(response);
    //   return "successful";
    // } else if (response.statusCode == 409) {
    //   print("conflict");
    //   return "conflict";
    // } else if (response.statusCode == 422) {
    //   print("already exist");
    //   return "put";
    // } else {
    //   return "unsuccessful";
    // }
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
