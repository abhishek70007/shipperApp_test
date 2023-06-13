import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuyGPSApiCalls {
  // final String buyGPSApiUrl = FlutterConfig.get('buyGPSApiUrl');
  final String buyGPSApiUrl = dotenv.get('buyGpsApiUrl');

  // transporterId controller
  ShipperIdController shipperIdController = Get.put(ShipperIdController());

  String? _gpsId;

  Future<String?> postByGPSData({required String? truckId, required String? address, required String? rate, required String? duration}) async {

    // json map
    Map<String, dynamic> data = {
      "transporterId": shipperIdController.shipperId.value,
      "truckId": truckId,
      "rate": rate,
      "duration": duration,
      "address": address
    };

    String body = json.encode(data);

    //post request
    http.Response response = await http.post(Uri.parse(buyGPSApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    print("Response is ${response.body}");
    var returnData = json.decode(response.body);

    _gpsId = returnData['gpsId'];

    return _gpsId;
  }

}