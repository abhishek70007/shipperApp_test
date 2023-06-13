import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/models/driverModel.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

Future<String> getDriverNameFromDriverApi(
    BuildContext context, driverId) async {
  var providerData = Provider.of<ProviderData>(context, listen: false);
  var jsonData;
  String? tempDropDownValue2;
  // final String driverApiUrl = FlutterConfig.get('driverApiUrl').toString();
  final String driverApiUrl = dotenv.get('driverApiUrl');

  try {
    http.Response response =
        await http.get(Uri.parse(driverApiUrl + '/$driverId'));
    jsonData = json.decode(response.body);
    DriverModel driverModel = DriverModel();
    driverModel.phoneNum = jsonData["phoneNum"];
    driverModel.driverName = jsonData["driverName"];
    tempDropDownValue2 = "${driverModel.driverName} - ${driverModel.phoneNum}";
  } catch (e) {
    print(e);
  }
  providerData.updateSelectedDriver( tempDropDownValue2.toString());
  return tempDropDownValue2.toString();
}
