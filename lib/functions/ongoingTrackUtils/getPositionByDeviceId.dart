import 'dart:convert';
import 'package:http/http.dart' as http;
import '/language/localization_service.dart';
import '/models/gpsDataModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart';

Future<List<GpsDataModel>> getPositionByDeviceId(String deviceId) async {
  String? current_lang;
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
        Uri.parse("$traccarApi/positions?deviceId=$deviceId"),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Accept': 'application/json'
        });
    // print(response.statusCode);
    // print("$traccarApi/positions?deviceId=$deviceId");
    // print("from getPositionByDeviceId ${response.body}");
    var jsonData = await jsonDecode(response.body);
    // print("Positions BODY IS${response.body}");
    List<GpsDataModel> LatLongList = [];
    if (response.statusCode == 200) {
      for (var json in jsonData) {

        GpsDataModel gpsDataModel = new GpsDataModel();
        // gpsDataModel.id = json["id"] != null ? json["id"] : 'NA';
        gpsDataModel.deviceId =
            json["deviceId"] != null ? json["deviceId"] : 'NA';
        gpsDataModel.rssi = json["attributes"]["rssi"] != null
            ? json["attributes"]["rssi"]
            : -1;
        gpsDataModel.result = json["attributes"]["result"] != null
            ? json["attributes"]["result"]
            : 'NA';
        gpsDataModel.latitude = json["latitude"] != null ? json["latitude"] : 0;
        gpsDataModel.longitude =
            json["longitude"] != null ? json["longitude"] : 0;
        print(
            "LAT : ${gpsDataModel.latitude}, LONG : ${gpsDataModel.longitude} ");
        gpsDataModel.distance = json["attributes"]["totalDistance"] != null
            ? json["attributes"]["totalDistance"]
            : 0;
        gpsDataModel.motion = json["attributes"]["motion"] != null
            ? json["attributes"]["motion"]
            : false;
        print("Motion : ${gpsDataModel.motion}");
        gpsDataModel.ignition = json["attributes"]["ignition"] != null
            ? json["attributes"]["ignition"]
            : false;
        gpsDataModel.speed =
            json["speed"] != null ? json["speed"] * 1.85 : 'NA';
        gpsDataModel.course = json["course"] != null ? json["course"] : 'NA';
        gpsDataModel.deviceTime =
            json["deviceTime"] != null ? json["deviceTime"] : 'NA';
        gpsDataModel.serverTime =
            json["serverTime"] != null ? json["serverTime"] : 'NA';
        gpsDataModel.fixTime = json["fixTime"] != null ? json["fixTime"] : 'NA';
        //   gpsDataModel.attributes = json["fixTime"] != null ? json["fixTime"] : 'NA';
        var latn = gpsDataModel.latitude =
            json["latitude"] != null ? json["latitude"] : 0;
        var lngn = gpsDataModel.longitude =
            json["longitude"] != null ? json["longitude"] : 0;
        String? addressstring;
        try {
          if(kIsWeb){
            final apiKey = dotenv.get('mapKey');
            http.Response addressResponse = await http.get(
                Uri.parse("http://maps.googleapis.com/maps/api/geocode/json?latlng=$latn,$lngn&key=$apiKey")
            );
            var addressJSONData = await jsonDecode(addressResponse.body);
            if (addressResponse.statusCode == 200) {
              if(addressJSONData['results'].isNotEmpty){
                String? address = addressJSONData['results'][0]['formatted_address'];
                addressstring = address;
              }
            }
          } else {
            List<Placemark> newPlace;
            current_lang = LocalizationService().getCurrentLang();
            if (current_lang == 'Hindi') {
              newPlace = await placemarkFromCoordinates(latn, lngn,
                  localeIdentifier: "hi_IN");
            } else {
              newPlace = await placemarkFromCoordinates(latn, lngn,
                  localeIdentifier: "en_US");
            }

            var first = newPlace.first;

            if (first.subLocality == "")
              addressstring =
              " ${first.street}, ${first.locality}, ${first.administrativeArea}, ${first.postalCode}, ${first.country}";
            else if (first.locality == "")
              addressstring =
              "${first.street}, ${first.subLocality}, ${first.administrativeArea}, ${first.postalCode}, ${first.country}";
            else if (first.administrativeArea == "")
              addressstring =
              "${first.street}, ${first.subLocality}, ${first.locality}, ${first.postalCode}, ${first.country}";
            else
              addressstring =
              "${first.street}, ${first.subLocality}, ${first.locality}, ${first.administrativeArea}, ${first.postalCode}, ${first.country}";
            // print("ADD $addressstring");
          }
        } catch (e) {
          print(e);

          addressstring = "";
        }
        gpsDataModel.address = "$addressstring";
        LatLongList.add(gpsDataModel);
      }
      return LatLongList;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
