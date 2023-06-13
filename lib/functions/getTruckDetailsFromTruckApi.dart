import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
import 'dart:convert';
import '/models/truckModel.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List> getTruckDetailsFromTruckApi(BuildContext context) async {
  var providerData = Provider.of<ProviderData>(context, listen: false);
  List<TruckModel> truckDetailsList = [];
  ShipperIdController tIdController = Get.put(ShipperIdController());
  var jsonData;
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl').toString();
  final String truckApiUrl = dotenv.get('truckApiUrl');

  try {
    http.Response response = await http.get(Uri.parse(
        truckApiUrl + '?transporterId=${tIdController.shipperId}'));
    jsonData = json.decode(response.body);

    for (var json in jsonData) {
      TruckModel truckModel = TruckModel(truckApproved: false);
      truckModel.truckId = json["truckId"];
      truckModel.transporterId = json["transporterId"];
      truckModel.truckNo = json["truckNo"];
      truckModel.truckApproved = json["truckApproved"];
      truckModel.imei = json["imei"];
      truckModel.driverId = json["driverId"];
      truckDetailsList.add(truckModel);
      providerData.updateTruckNoList(newValue: truckModel.truckNo.toString());
      // driverIdList.add(truckModel.driverId);
    }
  } catch (e) {
    print("hi getTruckDetailsFromApi has some error" + '$e');
  }
  // truckAndDriverList.add(truckDetailsList);

  // driverDetailsList =
  //     await getDriverDetailsFromDriverApi(context, driverIdList);
  //
  // truckAndDriverList.add(driverDetailsList);

  return truckDetailsList;
}
