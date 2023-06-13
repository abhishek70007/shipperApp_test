import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/controller/shipperIdController.dart';

// String traccarPass = FlutterConfig.get("traccarPass");
String traccarPass = dotenv.get('traccarPass');

String? current_lang;
// String traccarUser = FlutterConfig.get("traccarUser");
String traccarUser = dotenv.get('traccarUser');

//to change authorization from admin to user
// shipperIdController shipperIdController =
// Get.put(shipperIdController());
// String traccarUser = shipperIdController.mobileNum.value;

class DeviceApiCalls {
  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.get('traccarApi');

  late String _truckId;

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));

  //POST---------------------------------------------------------------------------
  Future<dynamic> PostDevice(
      {required String truckName, required String uniqueid}) async {

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',
        Uri.parse("$traccarApi/devices"));
    request.body = json.encode({"name": truckName, "uniqueId": uniqueid});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res= await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final decodeData = json.decode(res);
      print(res);
      print(decodeData["id"]);
      _truckId = decodeData["id"].toString();
      return _truckId;    //this post method return id of device
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  //PUT---------------------------------------------------------------------------
  Future<dynamic> UpdateDevice(
      {required String truckId, required String truckType, required String truckTyre,
        required String truckWeight, required String uniqueId, required String truckName}) async{

    var headers = {
      'accept': 'application/json',
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Cookie': 'JSESSIONID=node016u831n3bqeajjbhtb9ohpmcg26.node0'
    };
    var request = http.Request('PUT', Uri.parse('$traccarApi/devices/$truckId'));
    request.body = json.encode({
      "id": truckId,
      "attributes": {
        "truckType": truckType,
        "tyreNo": truckTyre,
        "weight": truckWeight
      },
      "name": truckName,
      "uniqueId": uniqueId
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    // var res= await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // final decodeData = json.decode(res);
      // _truckId = decodeData["id"].toString();
      print(await response.stream.bytesToString());
      // return _truckId;
      return truckId;
    }
    else {
      print(response.reasonPhrase);
      // return null;
    }

  }
}
