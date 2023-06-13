import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/functions/shipperApis/runShipperApiPost.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String?> createUserTraccar(String? token, String? mobileNum) async {
  // String traccarUser = FlutterConfig.get("traccarUser");
  String traccarUser = dotenv.get('traccarUser');

  // String traccarPass = FlutterConfig.get("traccarPass");
  String traccarPass = dotenv.get('traccarPass');

  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.get('traccarApi');

  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));

  Map data = {
    "name": mobileNum,
    "password": traccarPass,
    "email": mobileNum,
    "phone": mobileNum,
    "attributes": {"notificationTokens": "$token", "timezone": "Asia/Kolkata"}
  };
  String body = json.encode(data);

  var response = await http.post(Uri.parse("$traccarApi/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
      body: body);
  if (response.statusCode == 200) {
    var decodedResponse = json.decode(response.body);
    String id = decodedResponse["id"].toString();
    sidstorage
        .write("traccarUserId", id)
        .then((value) => print("traccarUserId \" $id \" saved in cache"));
    return id;
  } else if (response.statusCode == 400) {
    //update notification token
    var response = await http.get(
      Uri.parse("$traccarApi/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
    );
    var jsonData = json.decode(response.body);
    for (var user in jsonData) {
      if (user["phone"].toString() == mobileNum) {
        String id = user["id"].toString();
        data = {
          "id": id,
          "name": mobileNum,
          "password": traccarPass,
          "email": mobileNum,
          "phone": mobileNum,
          "attributes": {
            "notificationTokens": "$token",
            "timezone": "Asia/Kolkata"
          }
        };
        body = json.encode(data);

        var response = await http.put(Uri.parse("$traccarApi/users/$id"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'authorization': basicAuth,
            },
            body: body);
      }
    }
    return null;
  }
  return null;
}
