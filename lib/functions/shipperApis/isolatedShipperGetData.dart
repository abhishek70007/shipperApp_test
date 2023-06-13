import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import '../get_role_of_employee.dart';
import '/controller/shipperIdController.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import '/functions/traccarCalls/createTraccarUserAndNotifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


ShipperIdController shipperIdController =
    Get.put(ShipperIdController(), permanent: true);
bool exe = true;

int count = 0;

late Timer timer;

isolatedShipperGetData() {
  exe = true;
  timer = Timer.periodic(
      Duration(seconds: 15), (Timer t) => exe ? apirun2() : timer.cancel());
}


Future<dynamic> apirun2() async {
  var response = await runShipperApiPostIsolated(
      emailId: FirebaseAuth.instance.currentUser!.email.toString(),phoneNo: FirebaseAuth.instance.currentUser!.phoneNumber.toString().replaceFirst("+91", ""));
  count = count + 1;
  print(count);
  // print("response = ");
  // print(response);
  if (response != null ||
      count == 5 ||
      FirebaseAuth.instance.currentUser == null) {
    // setState(() {
    exe = false;
    // });
  }

  return response;
}

GetStorage sidstorage = GetStorage('ShipperIDStorage');

Future<String?> runShipperApiPostIsolated(
    {required String emailId, String? userLocation,String? phoneNo}) async {
  try {
    // print("in the try block of api file");
    // var mUser = FirebaseAuth.instance.currentUser;
    // String? firebaseToken;
    // await mUser!.getIdToken(true).then((value) {
    //   // log(value);
    //   firebaseToken = value;
    // });

    ShipperIdController shipperIdController =
        Get.put(ShipperIdController(), permanent: true);

    final String shipperApiUrl =
        // FlutterConfig.get("shipperApiUrl").toString();
    dotenv.get('shipperApiUrl');

    Map data = userLocation != null
        ? {"emailId": emailId, "shipperLocation": userLocation}
        : {"emailId": emailId,"phoneNo": phoneNo };
    String body = json.encode(data);
    final response = await http.post(Uri.parse(shipperApiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // HttpHeaders.authorizationHeader: firebaseToken!
        },
        body: body);
    // print(response.body);
    // print("here api call stopped");

    // print(FirebaseAuth.instance.currentUser != null && !kIsWeb);
    if (FirebaseAuth.instance.currentUser != null && !kIsWeb) {
      FirebaseMessaging.instance.getToken().then((value) {
        if (value != null) {
          log("firebase registration token =========> " + value);
        }
        createTraccarUserAndNotifications(value, phoneNo);
      });
    }

    // print("'from runShipperApiPostIsolated' response statue code: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      var decodedResponse = json.decode(response.body);
      // print("isolated data--->${response.body}");
      if (decodedResponse["shipperId"] != null) {
        String shipperId = decodedResponse["shipperId"];

        // debugPrint(shipperId);
        // debugPrint("*********************************************************$shipperId");
        bool companyApproved =
            decodedResponse["companyApproved"].toString() == "true";
        bool accountVerificationInProgress =
            decodedResponse["accountVerificationInProgress"].toString() ==
                "true";
        String shipperLocation = decodedResponse["shipperLocation"] ?? " ";
        String name = decodedResponse["shipperName"] ?? " ";
        String companyName = decodedResponse["companyName"] ?? " ";
        String companyStatus = decodedResponse["companyStatus"] ?? " ";
        String mobileNum = decodedResponse["phoneNo"] ?? " ";
        shipperIdController.updateShipperId(shipperId);
        sidstorage
            .write("shipperId", shipperId)
            .then((value) => print("Written shipperId"));
        shipperIdController.updateCompanyApproved(companyApproved);
        sidstorage
            .write("companyApproved", companyApproved)
            .then((value) => print("Written companyApproved"));
        shipperIdController.updateCompanyStatus(companyStatus);
        sidstorage
            .write("companyStatus", companyStatus)
            .then((value) => print("Written companyStatus"));
        shipperIdController.updateEmailId(emailId);
        sidstorage
            .write("emailId", emailId)
            .then((value) => print("Written emailId"));
        shipperIdController.updateMobileNum(mobileNum);
        sidstorage
            .write("mobileNum", mobileNum)
            .then((value) => print("Written mobile number"));
        shipperIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress);
        sidstorage
            .write(
            "accountVerificationInProgress", accountVerificationInProgress)
            .then((value) => print("Written accountVerificationInProgress"));
        shipperIdController.updateShipperLocation(shipperLocation);
        sidstorage
            .write("shipperLocation", shipperLocation)
            .then((value) => print("Written shipperLocation"));
        shipperIdController.updateName(name);
        sidstorage.write("name", name).then((value) => print("Written name"));
        shipperIdController.updateCompanyName(companyName);
        sidstorage
            .write("companyName", companyName)
            .then((value) => print("Written companyName"));
        if (decodedResponse["token"] != null) {
          shipperIdController
              .updateJmtToken(decodedResponse["token"].toString());
        }
        getRoleOfEmployee(FirebaseAuth.instance.currentUser!.uid.toString());
        getShipperIdFromCompanyDatabase();
        return shipperId;
      }  else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print("from runShipperApiPostIsolated: $e");
    return null;
  }
}

@override
void dispose() {
  timer.cancel();
  // super.dispose();
}
