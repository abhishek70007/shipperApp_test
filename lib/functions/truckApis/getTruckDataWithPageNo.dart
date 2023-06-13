import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/functions/driverApiCalls.dart';
import '/models/driverModel.dart';
import '/models/truckModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getTruckDataWithPageNo(int i) async {
  //TransporterId controller
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  // retrieving TRUCKAPIURL  from env file
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl');
  final String truckApiUrl = dotenv.get('truckApiUrl');


  http.Response response = await http.get(Uri.parse(
      '$truckApiUrl?transporterId=${shipperIdController.shipperId.value}&pageNo=$i'));
  var jsonData = json.decode(response.body);
  var truckDataList = [];
  for (var json in jsonData) {
    TruckModel truckModel = TruckModel();
    truckModel.truckId = json["truckId"] != null ? json["truckId"] : 'NA';
    truckModel.transporterId =
        json["transporterId"] != null ? json["transporterId"] : 'NA';
    truckModel.truckNo = json["truckNo"] != null ? json["truckNo"] : 'NA';
    truckModel.truckApproved =
        json["truckApproved"] != null ? json["truckApproved"] : false;
    truckModel.imei = json["imei"] != null ? json["imei"] : 'NA';
    truckModel.passingWeightString =
        json["passingWeight"] != null ? json["passingWeight"].toString() : 'NA';
    truckModel.truckType = json["truckType"] != null ? json["truckType"] : 'NA';
    truckModel.deviceId =
        json["deviceId"] != null ? int.parse(json["deviceId"]) : 0;
    truckModel.tyres = json["tyres"] != null ? json["tyres"].toString() : 'NA';
    truckModel.driverId = json["driverId"] != null ? json["driverId"] : 'NA';
    truckModel.truckLengthString =
        json["truckLength"] != null ? json["truckLength"].toString() : 'NA';
    //driver data
    DriverModel driverModel =
        await getDriverByDriverId(driverId: truckModel.driverId);
    truckModel.driverName = driverModel.driverName;
    truckModel.driverNum = driverModel.phoneNum;
    truckDataList.add(truckModel);
  }
  return truckDataList;
}

getGPSTruckDataWithPageNo(int i) async {
  //TransporterId controller
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  // retrieving TRUCKAPIURL  from env file
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl');
  final String truckApiUrl = dotenv.get('truckApiUrl');

  http.Response response = await http.get(Uri.parse(
      '$truckApiUrl?transporterId=${shipperIdController.shipperId.value}&pageNo=$i'));
  var jsonData = json.decode(response.body);
  var truckDataList = [];
  for (var json in jsonData) {
    TruckModel truckModel = TruckModel();
    truckModel.truckId = json["truckId"] != null ? json["truckId"] : 'NA';
    truckModel.transporterId =
        json["transporterId"] != null ? json["transporterId"] : 'NA';
    truckModel.truckNo = json["truckNo"] != null ? json["truckNo"] : 'NA';
    truckModel.truckApproved =
        json["truckApproved"] != null ? json["truckApproved"] : false;
    truckModel.imei = json["imei"] != null ? json["imei"] : 'NA';
    truckModel.deviceId =
        json["deviceId"] != null ? int.parse(json["deviceId"]) : 0;
    truckModel.passingWeightString =
        json["passingWeight"] != null ? json["passingWeight"].toString() : 'NA';
    truckModel.truckType = json["truckType"] != null ? json["truckType"] : 'NA';
    truckModel.driverId = json["driverId"] != null ? json["driverId"] : 'NA';
    truckModel.tyres = json["tyres"] != null ? json["tyres"].toString() : 'NA';
    truckModel.truckLengthString =
        json["truckLength"] != null ? json["truckLength"].toString() : 'NA';
    truckDataList.add(truckModel);
  }
  return truckDataList;
}
