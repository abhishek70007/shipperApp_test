import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

postNotification(
    String loadingPointCityPostLoad, String unloadingPointCityPostLoad) async {
  print("post Notification triggered");
  String oneSignalAppId = dotenv.get("oneSignalAppId").toString();

  String oneSignalApiKey = dotenv.get("oneSignalApiKey").toString();

  Map data = {
    "included_segments": ["Subscribed Users"],
    "app_id": oneSignalAppId,
    "contents": {"en": "New load for you!"},
    "headings": {
      "en":
          "$loadingPointCityPostLoad to $unloadingPointCityPostLoad. Book NOW!"
    }
  };
  String body = json.encode(data);
  var jsonData;

  final String oneSignalApiUrl = "https://onesignal.com/api/v1/notifications";

  final response = await http.post(Uri.parse(oneSignalApiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic $oneSignalApiKey'
      },
      body: body);
  jsonData = json.decode(response.body);

  //   if (response.statusCode == 201) {
  //     print("LOAD API Response-->$jsonData");
  //     if (jsonData["loadId"] != null) {
  //       String loadId = jsonData["loadId"];
  //       return loadId;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // } catch (e) {
  //   postLoadErrorController.updatePostLoadError(e.toString());
  //   return null;
  // }
}
