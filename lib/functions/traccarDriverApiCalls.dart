import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


ShipperIdController shipperIdController =
    Get.put(ShipperIdController());
// final String driverApiUrl = FlutterConfig.get('driverApiUrl');
final String driverApiUrl = dotenv.get('driverApiUrl');

String? traccarUser = shipperIdController.mobileNum.value;
// String traccarPass = FlutterConfig.get("traccarPass");
String traccarPass = dotenv.get('traccarPass');

String basicAuth =
    'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));
late List jsonData;
late List driverList;

getDriverData() async {
  http.Response response = await http.get(
    Uri.parse("$driverApiUrl/api/drivers"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization': basicAuth,
    },
  );
  jsonData = await jsonDecode(response.body);
  for (var json in jsonData) {
    driverList.add(json);
  }
}
