import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '/controller/lockUnlockController.dart';
import '/controller/shipperIdController.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


ShipperIdController shipperIdController =
    Get.put(ShipperIdController());
final lockStorage = GetStorage();
// String? traccarUser = FlutterConfig.get("traccarUser");
String? traccarUser = dotenv.get('traccarUser');

// String traccarPass = FlutterConfig.get("traccarPass");
String traccarPass = dotenv.get('traccarPass');

// String traccarApi = FlutterConfig.get("traccarApi");
String traccarApi = dotenv.get('traccarApi');

String basicAuth =
    'Basic ' + base64Encode(utf8.encode('$traccarUser:$traccarPass'));

LockUnlockController lockUnlockController = Get.put(LockUnlockController());

//TRACCAR API CALLS------------------------------------------------------------
Future<String> postCommandsApi(
  final List gpsData,
  var gpsDataHistory,
  var gpsStoppageHistory,
  //var routeHistory,
  final String? TruckNo,
  final String? driverNum,
  final String? driverName,
  var truckId,
  int? deviceId,
  String? type,
  String? description,
) async {
  try {
    Map attributes = {"data": type};
    Map data = {
      "deviceId": deviceId,
      "type": type,
      "description": description,
      "attributes": attributes
    };
    String body = json.encode(data);

    final response = await http.post(Uri.parse("$traccarApi/commands"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth,
        },
        body: body);

    if (response.statusCode == 200 || response.statusCode == 202) {
      print(response.body);
      print(
          "THE CONTROLLER VALUE IS ${lockUnlockController.lockUnlockStatus.value}");
      //Get.back();
      /*   if (type == "engineResume") {
        Get.to(() => TruckUnlockScreen(
              deviceId: deviceId,
              gpsData: gpsData,
              // position: position,
              TruckNo: TruckNo,
              driverName: driverName,
              driverNum: driverNum,
              gpsDataHistory: gpsDataHistory,
              gpsStoppageHistory: gpsStoppageHistory,
              routeHistory: routeHistory,
              truckId: truckId,
            ));
      } else if (type == "engineStop") {
        Get.to(() => TruckLockScreen(
              deviceId: deviceId,
              gpsData: gpsData,
              // position: position,
              TruckNo: TruckNo,
              driverName: driverName,
              driverNum: driverNum,
              gpsDataHistory: gpsDataHistory,
              gpsStoppageHistory: gpsStoppageHistory,
              routeHistory: routeHistory,
              truckId: truckId,
            ));
      }*/
      return "Success";
    } else {
      return "Error ${response.statusCode} \n Printing Response ${response.body}";
    }
  } catch (e) {
    print("Error is $e");
    Get.snackbar("Error", "$e", snackPosition: SnackPosition.BOTTOM);
    return "Error Occurred";
  }
}

Future<String> getCommandsResultApi(
  int? deviceId,
  var timeNow,
) async {
  print(
      "___________________________________________________________________hello");
  var timeCurrent =
      DateTime.now().toUtc().add(Duration(minutes: 5)).toIso8601String();

  print(
      "=======================================================>Current time $timeNow");
  print(
      "=======================================================>TO time $timeCurrent");
  Get.snackbar("Time", "$timeCurrent", snackPosition: SnackPosition.BOTTOM);
  try {
    http.Response response = await http.get(
      Uri.parse(
          "$traccarApi/reports/events?from=$timeNow&to=$timeCurrent&deviceId=$deviceId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
    );
    print(response.statusCode);
    print(
        "Respone code----------------------------------------------------------${response.statusCode}");
    print(response.body);
    var jsonData = await jsonDecode(response.body);
    print("The DATA FROM EVENTS $jsonData");
    var store;
    if (response.statusCode == 200) {
      print(response.body);
      print(
          "THE CONTROLLER VALUE IS ${lockUnlockController.lockUnlockStatus.value}");
      for (var json in jsonData) {
        store = json["attributes"]["result"];
      }
      print(
          "----------------------------------------------------THE STORE IS $store");
      if (store == "Restore fuel supply:Success!") {
        print("Restore fuel success");
        lockStorage.write('lockState', true);
        lockUnlockController.lockUnlockStatus.value = true;
        lockUnlockController.updateLockUnlockStatus(true);
        return "unlock";
      } else if (store == "Cut off the fuel supply: Success!") {
        print("Cutoff supply successful");
        lockStorage.write('lockState', false);
        lockUnlockController.lockUnlockStatus.value = false;
        lockUnlockController.updateLockUnlockStatus(false);
        return "lock";
      } else if (store ==
          "Already in the state of  fuel supply cut off, the command is not running!") {
        lockStorage.write('lockState', false);
        lockUnlockController.lockUnlockStatus.value = false;
        lockUnlockController.updateLockUnlockStatus(false);
        return "lock";
      } else if (store ==
          "Already in the state of fuel supply to resume, the command is not running!") {
        lockStorage.write('lockState', true);
        lockUnlockController.lockUnlockStatus.value = true;
        lockUnlockController.updateLockUnlockStatus(true);
        return "unlock";
      } else {
        return "null";
      }
    } else {
      return "null";
    }
  } catch (e) {
    print("Error is $e");
    Get.snackbar("Error", "$e", snackPosition: SnackPosition.BOTTOM);
    return "Error Occurred";
  }
}

Future<String> getTruckCommandExist(int? deviceId) async {
  try {
    http.Response response = await http.get(
      Uri.parse("$traccarApi/commands"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
    );
    //print("-----------------------------Status Code:${response.headers}");
    if (response.statusCode == 200) {
      var store;
      var jsonData = await jsonDecode(response.body);
      //print("-----------------------------JSon Data:$jsonData");
      for (var json in jsonData) {
        if (deviceId == json["deviceId"]) {
          store = json["id"];
        }
      }
      //print("----------------------------------Store:$store");
      if (store != null) {
        return "Not Null,$store";
      } else {
        return "Null";
      }
    } else {
      return "Error";
    }
  } catch (e) {
    //print("--------------------------------------------------Error is $e");
    return "Error";
  }
  return "Default";
}

Future<String> putCommands(int? id, String? type) async {
  try {
    http.Response response = await http.get(
      Uri.parse("$traccarApi/commands"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth,
      },
    );
    if (response.statusCode == 200) {
      var tempAttributes;
      var tempDeviceId;
      var tempDescription;
      var dataAttr = "engineResume";
      var result = "Restore fuel supply:Success!";
      var jsonData = await jsonDecode(response.body);
      for (var json in jsonData) {
        if (json["id"] == id) {
          tempDeviceId = json["deviceId"];
          tempDescription = json["description"];
        }
      }
      if (type == "Lock") {
        dataAttr = "engineStop";
        result = "Cut off the fuel supply: Success!";
      }
      Map data = {
        "id": id,
        "deviceId": tempDeviceId,
        "type": type,
        "description": tempDescription,
        "attributes": {"data": dataAttr, "result": result}
      };
      String body = json.encode(data);
      final response1 = await http.put(Uri.parse("$traccarApi/commands/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': basicAuth,
          },
          body: body);
      //print("--------------------------------Response Data:${response1.body}");
      if (response1.statusCode == 200 || response1.statusCode == 202) {
        var timeCurrent = DateTime.now()
            .subtract(Duration(hours: 5, minutes: 30))
            .toIso8601String();
        print(
            "----------------------------------------------TO time $timeCurrent");
        return "Success";
      } else {
        return "Error";
      }
    } else {
      return "Error";
    }
  } catch (e) {
    //print("--------------------------------------------------Error is $e");
    return "Error";
  }
  return "Fail";
}
