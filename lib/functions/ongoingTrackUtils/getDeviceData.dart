import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
import '/functions/BackgroundAndLocation.dart';
import '/language/localization_service.dart';
import '/models/deviceModel.dart';
import '/models/gpsDataModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import '/models/gpsDataModelForHistory.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<List<DeviceModel>> getDeviceByDeviceId(String deviceId) async {
  // String traccarUser = FlutterConfig.get("traccarUser");
  String traccarUser = dotenv.get('traccarUser');

  // String traccarPass = FlutterConfig.get("traccarPass");
  String traccarPass = dotenv.get('traccarPass');

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));
  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.get('traccarApi');

  try {
    http.Response response = await http.get(
        Uri.parse("$traccarApi/devices/$deviceId"),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Accept': 'application/json'
        });
    // print(response.statusCode);
    // print("traccar device api response(from getDeviceByDeviceId): ${response.body}");
    var json = await jsonDecode(response.body);
    List<DeviceModel> devicesList = [];
    if (response.statusCode == 200) {
      DeviceModel deviceModel = new DeviceModel();
      deviceModel.deviceId = json["id"] != null ? json["id"] : 0;
      deviceModel.truckno = json["name"] != null ? json["name"] : 'NA';
      deviceModel.imei = json["uniqueId"] != null ? json["uniqueId"] : 'NA';
      deviceModel.status = json["status"] != null ? json["status"] : 'NA';
      deviceModel.lastUpdate =
          json["lastUpdate"] != null ? json["lastUpdate"] : 'NA';

      devicesList.add(deviceModel);
    }
    return devicesList;
    // } else {
    //   return null;
    // }
  } catch (e) {
    print(e);
    return [];
  }
}
