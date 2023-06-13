import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void linkNotificationAndUserTraccar(String? userId, List<String?>? id) async {
  // String traccarUser = FlutterConfig.get("traccarUser");
  String traccarUser = dotenv.get('traccarUser');

  // String traccarPass = FlutterConfig.get("traccarPass");
  String traccarPass = dotenv.get('traccarPass');

  // String traccarApi = FlutterConfig.get("traccarApi");
  String traccarApi = dotenv.get('traccarApi');


  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));

  for (int i = 0; i < id!.length; i++) {
    if (id[i] != null) {
      int notificationId = int.parse(id[i]!);
      Map data = {
        "userId": int.parse(userId!),
        "notificationId": notificationId
      };
      String body = json.encode(data);
      var response = await http.post(Uri.parse("$traccarApi/permissions"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth,
          },
          body: body);
      print(response.body);
    }
  }
}
