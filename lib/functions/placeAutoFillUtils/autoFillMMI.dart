import 'package:get/get.dart';
import '/controller/tokenMMIController.dart';
import '/functions/placeAutoFillUtils/tokenMMI.dart';
import '/models/autoFillMMIModel.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

getMMIToken()async{
  TokenMMIController tokenMMIController = Get.put(TokenMMIController());
  String token;
  if (tokenMMIController.tokenMMI.value == "") {
    print("getting the token");
    token = await getMapMyIndiaToken();
    print("got the token");
  } else {
    token = tokenMMIController.tokenMMI.value;
  }
  print("hello here");
  print(token);
  return token;
}

// Future<dynamic>fillCityName() async{
//   var headers = {
//     'accept': 'application/json',
//     'Authorization': 'Bearer 44fb8715-32e0-4759-a704-649e139f0e4c'
//   };
//   var request = http.Request('GET', Uri.parse('http://atlas.mapmyindia.com/api/places/search/json?query=varanasi&pod=CITY'));
//   request.body = '''''';
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//
//   if (response.statusCode == 200) {
//     // print(await response.stream.bytesToString());
//     var res=await response.stream.bytesToString();
//     final decodeData = json.decode(res);
//     print(res);
//   }
//   else {
//     print(response.reasonPhrase);
//   }
// }

Future<List<AutoFillMMIModel>> fillCityName(String cityName) async {
  print("*********************fillcityname called");
  if (cityName.length > 1) {
    // TokenMMIController tokenMMIController = Get.put(TokenMMIController());
    // String token;
    // if (tokenMMIController.tokenMMI.value == "") {
    //   token = await getMapMyIndiaToken();
    // } else {
    //   token = tokenMMIController.tokenMMI.value;
    // }
    String token;
    token = await getMMIToken();

    Uri url = Uri.parse(
        "http://atlas.mapmyindia.com/api/places/search/json?query=$cityName&pod=CITY");
    http.Response response1 = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    print(response1.body);
    var address = (jsonDecode(response1.body));
    address = address["suggestedLocations"];
    print("hiiiiiiiii");
    print(address);
    List<AutoFillMMIModel> card = [];
    for (var json in address) {
      AutoFillMMIModel locationCardsModal = new AutoFillMMIModel(
        placeName: json[""],
          placeCityName: json["placeName"],
          placeStateName: json["placeAddress"]);
      card.add(locationCardsModal);
    }
    // card = card
    //   ..sort(
    //           (a, b) => a.placeCityName.toString().compareTo(b.placeStateName.toString()));

    return card;
  } else {
    List<AutoFillMMIModel> card = [];
    return card;
  }
}
