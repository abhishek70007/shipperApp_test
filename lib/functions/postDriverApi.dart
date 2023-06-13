// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
//
// postDriverApi(driverName, phoneNum, transporterId, truckId) async {
//   Map data = {
//     "driverName": driverName,
//     "phoneNum": phoneNum,
//     "transporterId": transporterId,
//     "truckId": truckId
//   };
//   String body = json.encode(data);
//   final String driverApiUrl = FlutterConfig.get('driverApiUrl').toString();
//   final response = await http.post(Uri.parse("$driverApiUrl"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: body);
// }

// delete this file
