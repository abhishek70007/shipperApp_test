import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/models/driverModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getDriverDetailsFromDriverId(driverId) async {
  var jsonData;
  // final String driverApiUrl = FlutterConfig.get("driverApiUrl").toString();
  final String driverApiUrl = dotenv.get('driverApiUrl');

  http.Response response = await http.get(Uri.parse("$driverApiUrl/$driverId"));
  try {
    jsonData = json.decode(response.body);

    DriverModel driverModel = DriverModel();

    driverModel.driverName = jsonData["driverName"].toString();

    driverModel.phoneNum = jsonData['phoneNum'].toString();

    return driverModel;
  } catch (e) {
    print(e);
  }
}
