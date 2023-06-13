import 'dart:async';

import 'package:get/get.dart';
import '/controller/tokenMMIController.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

Future<String> getMapMyIndiaToken() async {
  String? clientIdMapMyIndia;
  String? clientSecretMapMyIndia;
  try {

    await FirebaseDatabase.instance
        .reference()
        .child('clientSecretMapMyIndia')
        .once()
        .then((DataSnapshot snapshot) {
      clientSecretMapMyIndia = snapshot.value as String?;
      print("clientSecretMapMyIndia = $clientSecretMapMyIndia");
    } as FutureOr Function(DatabaseEvent value));

    // await FirebaseDatabase.instance
    //     .reference()
    //     .child('clientSecretMapMyIndia')
    //     .onValue
    //     .listen((event) {
    //   String? clientSecretMapMyIndia = event.snapshot.value as String?;
    //   print("clientSecretMapMyIndia = $clientSecretMapMyIndia");
    // });

    // print("first Executed");
    await FirebaseDatabase.instance
        .reference()
        .child('clientIdMapMyIndia')
        .once()
        .then((DataSnapshot snapshot) {
          clientIdMapMyIndia = snapshot.value as String?;
          print("clientIdMapMyIndia = $clientIdMapMyIndia");
        } as FutureOr Function(DatabaseEvent value));
    // await FirebaseDatabase.instance
    //     .reference()
    //     .child('clientIdMapMyIndia')
    //     .onValue
    //     .listen((event) {
    //       clientIdMapMyIndia = event.snapshot.value as String?;
    //       print("clientIdMapMyIndia = $clientIdMapMyIndia");
    //     });


  } catch (e){
    print("Exception ${e.toString()}");
  } finally {
    // print("clientIdMapMyIndia $clientIdMapMyIndia, clientSecretMapMyIndia $clientSecretMapMyIndia");

    TokenMMIController tokenMMIController = Get.put(TokenMMIController());
    // print("tokenController Created**********");
    Uri tokenUrl = Uri(
        scheme: "https",
        host: "outpost.mapmyindia.com",
        path: 'api/security/oauth/token',
        queryParameters: {
          "grant_type": "client_credentials",
          "client_id": "$clientIdMapMyIndia",
          "client_secret": "$clientSecretMapMyIndia"
        });

    // print("tokenURL $tokenUrl");
    http.Response tokenGet = await http.post(tokenUrl);
    print("got the response");
    var body = jsonDecode(tokenGet.body);
    print("body $body");
    var token = body["access_token"];
    print("token = $token");
    tokenMMIController.updateTokenMMI(token);
    return token;
  }
}
