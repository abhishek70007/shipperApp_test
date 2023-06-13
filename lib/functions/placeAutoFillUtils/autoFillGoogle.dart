import 'dart:convert';

import '/functions/googleAutoCorrectionApi.dart';
import '/models/autoFillMMIModel.dart';
import '../googleAutoCorrectionApi.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// String kGoogleApiKey = FlutterConfig.get('mapKey').toString();
String kGoogleApiKey = dotenv.get('mapKey');

// Future<List<AutoFillMMIModel>> fillCityGoogle(String cityName,Position position) async {
//   print(      Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?'
//       'input=$cityName&location=${position.latitude},${position.longitude}&radius=50000&language=en&components=country:in&key=$kGoogleApiKey')
//   );
//
//   var request = http.Request(
//       'GET',
//       Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?'
//           'input=$cityName&location=${position.latitude},${position.longitude}&radius=50000&language=en&components=country:in&key=$kGoogleApiKey'));
//
//   print("request $request");
//
//   http.StreamedResponse response = await request.send();
//
//   print("resonse $response");
//
//
//
//   List<AutoFillMMIModel> card = [];
//   if (response.statusCode == 200) {
//     // print(await response.stream.bytesToString());
//     var res = await response.stream.bytesToString();
//     var address = json.decode(res);
//     address = address["predictions"];
//     //print(address);
//     for (var json in address) {
//       print("json Description From fillCity ${json["description"]}");
//       List<String> result = json["description"]!.split(",");
//       //print(result);
//       int resultLength = 0;
//       for (var r in result) {
//         resultLength++;
//         r = r.trimLeft();
//         r = r.trimRight();
//         //print(r);
//       }
//       if(resultLength==2)
//         {
//           AutoFillMMIModel locationCardsModal = AutoFillMMIModel(
//               placeName: "${result[0].toString()}",
//               placeCityName: "${result[0].toString()}",
//               // placeStateName: json["placeAddress"]\
//               placeStateName: "${result[0].toString()}");
//           card.add(locationCardsModal);
//         }
//       else if(resultLength==3)
//       {
//         AutoFillMMIModel locationCardsModal = AutoFillMMIModel(
//             placeName: "${result[0].toString()}",
//             placeCityName: "${result[0].toString()}",
//             // placeStateName: json["placeAddress"]\
//             placeStateName: "${result[1].toString()}");
//         card.add(locationCardsModal);
//       }
//       else {
//         AutoFillMMIModel locationCardsModal = new AutoFillMMIModel(
//             placeName: "${result[0].toString()}",
//             addresscomponent1: "${result[1].toString()}",
//             placeCityName: "${result[resultLength - 3].toString()}",
//             // placeStateName: json["placeAddress"]\
//             placeStateName: "${result[resultLength - 2].toString()}");
//         card.add(locationCardsModal);
//         print(card[0]);
//       }
//     }
//     return card;
//   } else {
//     List<AutoFillMMIModel> card = [];
//     return card;
//   }
// }

Future<List<AutoFillMMIModel>> fillCityGoogle(String cityName,Position position) async {
  http.Response response = await http.get(
    Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'input=$cityName&location=${position.latitude},${position.longitude}&radius=50000&language=en&components=country:in&key=$kGoogleApiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );

  var address = await jsonDecode(response.body);

  List<AutoFillMMIModel> card = [];
  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    // var res = await response.stream.bytesToString();
    // var address = json.decode(response.body);
    address = address["predictions"];
    //print(address);
    for (var json in address) {
      List<String> result = json["description"]!.split(",");
      //print(result);
      int resultLength = 0;
      for (var r in result) {
        resultLength++;
        r = r.trimLeft();
        r = r.trimRight();
        //print(r);
      }
      if(resultLength==2)
      {
        AutoFillMMIModel locationCardsModal = AutoFillMMIModel(
            placeName: "${result[0].toString()}",
            placeCityName: "${result[0].toString()}",
            // placeStateName: json["placeAddress"]\
            placeStateName: "${result[0].toString()}");
        card.add(locationCardsModal);
      }
      else if(resultLength==3)
      {
        AutoFillMMIModel locationCardsModal = AutoFillMMIModel(
            placeName: "${result[0].toString()}",
            placeCityName: "${result[0].toString()}",
            // placeStateName: json["placeAddress"]\
            placeStateName: "${result[1].toString()}");
        card.add(locationCardsModal);
      }
      else {
        AutoFillMMIModel locationCardsModal = new AutoFillMMIModel(
            placeName: "${result[0].toString()}",
            addresscomponent1: "${result[1].toString()}",
            placeCityName: "${result[resultLength - 3].toString()}",
            // placeStateName: json["placeAddress"]\
            placeStateName: "${result[resultLength - 2].toString()}");
        card.add(locationCardsModal);
        // print(card[0]);
        }
    }
    return card;
  } else {
    List<AutoFillMMIModel> card = [];
    return card;
  }

}


