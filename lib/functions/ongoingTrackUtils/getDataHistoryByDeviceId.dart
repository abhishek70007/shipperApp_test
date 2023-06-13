import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/gpsDataModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getTraccarHistoryByDeviceId({
  int? deviceId,
  String? from,
  String? to,
}) async {
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
      Uri.parse(
          "$traccarApi/reports/route?deviceId=$deviceId&from=${from}Z&to=${to}Z"),
      headers: <String, String>{
        'authorization': basicAuth,
        'Accept': 'application/json'
      },
    );
    print(response.statusCode);
    print(response.body);
    var jsonData = await jsonDecode(response.body);
    print(response.body);
    var LatLongList = [];
    if (response.statusCode == 200) {
      for (var json in jsonData) {
        GpsDataModel gpsDataModel = new GpsDataModel();
        // gpsDataModel.id = json["id"] != null ? json["id"] : 'NA';
        gpsDataModel.deviceId =
            json["deviceId"] != null ? json["deviceId"] : 'NA';

        gpsDataModel.latitude = json["latitude"] != null ? json["latitude"] : 0;
        gpsDataModel.longitude =
            json["longitude"] != null ? json["longitude"] : 0;

        gpsDataModel.speed = json["speed"] != null ? json["speed"] : 'NA';
        gpsDataModel.course = json["course"] != null ? json["course"] : 'NA';
        gpsDataModel.deviceTime =
            json["deviceTime"] != null ? json["deviceTime"] : 'NA';
        gpsDataModel.serverTime =
            json["serverTime"] != null ? json["serverTime"] : 'NA';
        // print("Device time : ${gpsDataModel.deviceTime}");

        LatLongList.add(gpsDataModel);
      }
      print("TDH $LatLongList");
      return LatLongList;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
