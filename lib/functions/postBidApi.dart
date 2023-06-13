// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
// import 'package:intl/intl.dart';
//
// postBidAPi(loadId, rate, shipperIdController, unit) async {
//   String now = DateFormat("dd-MM-yyyy").format(DateTime.now());
//
//   if (unit == "RadioButtonOptions.PER_TON") {
//     unit = "PER_TON";
//   }
//   if (unit == "RadioButtonOptions.PER_TRUCK") {
//     unit = "PER_TRUCK";
//   }
//   Map data = {
//     "transporterId": shipperIdController.toString(),
//     "loadId": loadId.toString(),
//     "rate": rate.toString(),
//     "unitValue": unit.toString(),
//     "biddingDate": now.toString(),
//     "transporterApproval": true,
//     "shipperApproval": false,
//     "truckId": []
//   };
//   String body = json.encode(data);
//   final String bidApiUrl = FlutterConfig.get('biddingApiUrl').toString();
//   final response = await http.post(Uri.parse("$bidApiUrl"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: body);
// }
