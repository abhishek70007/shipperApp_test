import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
import '/controller/truckIdController.dart';
import '/functions/driverApiCalls.dart';
import '/models/driverModel.dart';
import '/models/truckModel.dart';
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TruckApiCalls {
  // retrieving TRUCKAPIURL  from env file
  // final String truckApiUrl = FlutterConfig.get('truckApiUrl');
  final String truckApiUrl = dotenv.get('truckApiUrl');

  // transporterId controller
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  //truckId controller ..used to store truckId for latest truck
  TruckIdController truckIdController = TruckIdController();

  //json data list
  late List jsonData;

  // Truck Model List used to  create cards
  List<TruckModel> truckDataList = [];

  // This variable is used to return truckId to MyTruckScreens
  String? _truckId;

//GET---------------------------------------------------------------------------

  Future<List<TruckModel>> getTruckData() async {
    for (int i = 0;; i++) {
      http.Response response = await http.get(Uri.parse(truckApiUrl +
          '?transporterId=${shipperIdController.shipperId.value}&pageNo=$i'));
      jsonData = json.decode(response.body);
      if (jsonData.isEmpty) {
        break;
      }

      for (var json in jsonData) {
        TruckModel truckModel = TruckModel();
        truckModel.truckId = json["truckId"] != null ? json["truckId"] : 'NA';
        truckModel.transporterId =
            json["transporterId"] != null ? json["transporterId"] : 'NA';
        truckModel.truckNo = json["truckNo"] != null ? json["truckNo"] : 'NA';
        truckModel.truckApproved =
            json["truckApproved"] != null ? json["truckApproved"] : false;
        truckModel.imei = json["imei"] != null ? json["imei"] : 'NA';
        truckModel.passingWeightString = json["passingWeight"] != null
            ? json["passingWeight"].toString()
            : 'NA';
        truckModel.truckType =
            json["truckType"] != null ? json["truckType"] : 'NA';
        truckModel.deviceId =
            json["deviceId"] != null ? int.parse(json["deviceId"]) : 0;
        truckModel.tyres =
            json["tyres"] != null ? json["tyres"].toString() : 'NA';
        truckModel.driverId =
            json["driverId"] != null ? json["driverId"] : 'NA';
        // truckModel.truckLengthString =
        //     json["truckLength"] != null ? json["truckLength"].toString() : 'NA';
        //driver data
        DriverModel driverModel =
            await getDriverByDriverId(driverId: truckModel.driverId);
        truckModel.driverName = driverModel.driverName;
        truckModel.driverNum = driverModel.phoneNum;
        truckDataList.add(truckModel);
      }
    }
    return truckDataList; // list of truckModels
  }

  //GET Truck Data by truckId
  Future<Map> getDataByTruckId(String truckId) async {
    http.Response response = await http.get(Uri.parse('$truckApiUrl/$truckId'));
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      Map data = {
        'driverId': jsonData['driverId'] != null ? jsonData['driverId'] : 'NA',
        'truckNo': jsonData['truckNo'] != null ? jsonData['truckNo'] : 'NA',
        'imei': jsonData['imei'] != null ? jsonData['imei'] : 'NA',
        'truckType':
            jsonData['truckType'] != null ? jsonData['truckType'] : 'NA',
        'truckApproved': jsonData['truckApproved'] != null
            ? jsonData["truckApproved"]
            : false,
      };

      return data;
    } else {
      Map data = {
        'driverId': 'NA',
        'truckNo': 'NA',
        'imei': 'NA',
        'truckType': 'NA',
        'truckApproved': false
      };
      return data;
    }
  }

  //POST------------------------------------------------------------------------
  Future<String?> postTruckData({required String truckNo}) async {
    // json map
    Map<String, dynamic> data = {
      "transporterId": shipperIdController.shipperId.value,
      "truckNo": truckNo,
    };

    String body = json.encode(data);

    //post request
    http.Response response = await http.post(Uri.parse(truckApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);

    _truckId = returnData['truckId'];

    return _truckId;
  } //post truck data

  //PUT-------------------------------------------------------------------------

  Future<String?> putTruckData(
      {required String truckID,
      required String truckType,
      required int totalTyres,
      required int passingWeight,
      // required int truckLength,
      required String driverID}) async {
    //json map
    Map<String, dynamic> data = {
      "driverId": driverID == '' ? null : driverID,
      "imei": null,
      "passingWeight": passingWeight == 0 ? null : passingWeight,
      "transporterId": shipperIdController.shipperId.value,
      "truckApproved": false,
      "truckType": truckType == '' ? null : truckType,
      // "truckLength": truckLength == 0 ? null : truckLength,
      "tyres": totalTyres == 0 ? null : totalTyres
    };

    String body = json.encode(data);

    http.Response response = await http.put(Uri.parse('$truckApiUrl/$truckID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);
    _truckId = returnData['truckId'];
    return _truckId;
  }

  updateDriverIdForTruck(
      {required String? truckID, required String? driverID}) async {
    //json map
    Map<String, dynamic> data = {
      "driverId": driverID == '' ? null : driverID,
    };

    String body = json.encode(data);
    print("run update driver id in truckApiCalls");
    http.Response response = await http.put(Uri.parse('$truckApiUrl/$truckID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    var returnData = json.decode(response.body);
    _truckId = returnData['truckId'];
  }
} //class end
