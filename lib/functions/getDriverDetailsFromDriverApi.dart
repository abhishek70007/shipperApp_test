import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
import 'dart:convert';
import '/models/driverModel.dart';
import '/providerClass/providerData.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<List> getDriverDetailsFromDriverApi(
    BuildContext context /*, driverIdList*/) async {
  var providerData = Provider.of<ProviderData>(context, listen: false);
  var jsonData;
  ShipperIdController tIdController = Get.put(ShipperIdController());
  // final String driverApiUrl = FlutterConfig.get('driverApiUrl').toString();
  final String driverApiUrl = dotenv.get('driverApiUrl');

  List<DriverModel> driverDetailsList = [];
  try {
    http.Response response = await http.get(Uri.parse(
        "$driverApiUrl?transporterId=${tIdController.shipperId}"));
    jsonData = json.decode(response.body);
    for (var json in jsonData) {
      DriverModel driverModel = DriverModel();
      driverModel.driverId = json["driverId"];
      driverModel.transporterId = json["transporterId"];
      driverModel.phoneNum = json["phoneNum"];
      driverModel.driverName = json["driverName"];
      driverModel.truckId = json["truckId"];
      driverDetailsList.add(driverModel);
      providerData.updateDriverNameList(
          newValue: "${driverModel.driverName} - ${driverModel.phoneNum}");
    }
  } catch (e) {
    print(e);
  }
  return driverDetailsList;
}
