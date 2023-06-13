import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getDocName(String bookingId, String docType) async {
  var lrdocs = ["LrPhoto1", "LrPhoto2", "LrPhoto3", "LrPhoto4"];
  var poddocs = ["PodPhoto1", "PodPhoto2", "PodPhoto3", "PodPhoto4"];
  var ewaydocs = [
    "EwayBillPhoto1",
    "EwayBillPhoto2",
    "EwayBillPhoto3",
    "EwayBillPhoto4"
  ];
  var weightdocs = [
    "WeightReceiptPhoto1",
    "WeightReceiptPhoto2",
    "WeightReceiptPhoto3",
    "WeightReceiptPhoto4"
  ];
  bool dataExist = false;
  var jsonData;
  var docNames = [];
  var available = [];
  try {
    final String documentApiUrl =
        // FlutterConfig.get('documentApiUrl').toString();
        dotenv.get('documentApiUrl');

    final response = await http.get(Uri.parse("$documentApiUrl/$bookingId"));

    print(response.body);
    jsonData = json.decode(response.body);
    print(response.body);
    for (var jsondata in jsonData["documents"]) {
      print(jsondata["documentType"]);
      if (jsondata["documentType"][0] == docType) {
        docNames.add(jsondata["documentType"]);
        print("docNames :- ");
        print(docNames);
      }
    }

    if (docType == "L") {
      for (int i = 0; i < 4; i++) {
        dataExist = false;
        for (int j = 0; j < docNames.length; j++) {
          if (docNames[j] == lrdocs[i]) {
            dataExist = true;
          }
        }
        if (!dataExist) {
          available.add(i);
        }
      }
    } else if (docType == "P") {
      for (int i = 0; i < 4; i++) {
        dataExist = false;
        for (int j = 0; j < docNames.length; j++) {
          if (docNames[j] == poddocs[i]) {
            dataExist = true;
          }
        }
        if (!dataExist) {
          available.add(i);
        }
      }
    } else if (docType == "E") {
      for (int i = 0; i < 4; i++) {
        dataExist = false;
        for (int j = 0; j < docNames.length; j++) {
          if (docNames[j] == ewaydocs[i]) {
            dataExist = true;
          }
        }
        if (!dataExist) {
          available.add(i);
        }
      }
    } else if (docType == "W") {
      for (int i = 0; i < 4; i++) {
        dataExist = false;
        for (int j = 0; j < docNames.length; j++) {
          if (docNames[j] == weightdocs[i]) {
            dataExist = true;
          }
        }
        if (!dataExist) {
          available.add(i);
        }
      }
    }
    print("availabe docs names :- ");
    print(available);
    return available;
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}
