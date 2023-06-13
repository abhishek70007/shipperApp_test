import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getDocApiCallVerify(String bookingId, String docType) async {
  var jsonData;
  try {
    final String documentApiUrl =
        // FlutterConfig.get('documentApiUrl').toString();
        dotenv.get('documentApiUrl');

    print("from getDocApiCallVerify $documentApiUrl/$bookingId");
    final response = await http.get(Uri.parse("$documentApiUrl/$bookingId"));

    print("from getDocApiCallVerify" + response.body);
    jsonData = json.decode(response.body);
    print(response.body);
    for (var jsondata in jsonData["documents"]) {
      print(jsondata["documentType"]);
      if (jsondata["documentType"][0] == docType) {
        if (jsondata["verified"] == false) {
          return false;
        }
      }
    }

    return true;
  } catch (e) {
    print("exception from getDocApiCallVerify ${e.toString()}");
    return e.toString();
  }
}
