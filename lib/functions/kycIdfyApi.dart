import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'shipperApis/isolatedShipperGetData.dart';
import 'dart:math';

final String idfyAccountId = dotenv.get('idfyAccountId');
final String idfyApiKey = dotenv.get('idfyApiKey');
final String idfyKeyId = dotenv.get('idfyKey_id');
final String idfyOuId = dotenv.get('idfyOu_id');
final String idfySecretKey = dotenv.get('idfySecret_Key');
final String webHookUrl = dotenv.get('webHookUrl');

var headers = {
  'Content-Type': 'application/json',
  'account-id': idfyAccountId,
  'api-key': idfyApiKey
};

String randomGenerator() {
  Random random = new Random();
  return random.nextInt(10000).toString();
}

Future<String> postCallingIdfy() async {
  var body = json.encode({
    "task_id": "74f4c926-250c-43ca-9c53-453e87ceacd1",
    "group_id": "8e16424a-58fc-4ba4-ab20-5bc8e7c3c41e",
    "data": {
      //"reference_id": "${shipperIdController.transporterId.value}",
      "reference_id": "12jdsgjdsbvjsb3251242123451542821465",
      "key_id": idfyKeyId,
      "ou_id": idfyOuId,
      "secret": idfySecretKey,
      "callback_url": webHookUrl,
      "doc_type": "ADHAR",
      "file_format": "xml",
      "extra_fields": {}
    }
  });
  var response = await http.post(
      Uri.parse(
          'https://eve.idfy.com/v3/tasks/async/verify_with_source/ind_digilocker_fetch_documents'),
      body: body,
      headers: headers);

  print(
      "Status Code------------------------------------------>${response.statusCode}");
  print(
      "Status Body------------------------------------------>${response.body}");
  var decodedData = json.decode(response.body);
  print(decodedData['request_id']);
  return getCallingIdfy(decodedData['request_id']);
}

Future<String> getCallingIdfy(String requestID) async {
  var response = await http.get(
    Uri.parse("https://eve.idfy.com/v3/tasks?request_id=$requestID"),
    headers: headers,
  );
  print(
      "Status Code------------------------------------------>${response.statusCode}");
  print(
      "Status Body------------------------------------------>${response.body}");
  var decodedData = json.decode(response.body);
  print(decodedData[0]['result']["source_output"]["redirect_url"]);
  return decodedData[0]['result']["source_output"]["redirect_url"];
}
