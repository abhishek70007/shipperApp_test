import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/controller/shipperIdController.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//TODO:all details not fetched
Future<String> updateShipperApi(
    {required String comapnyStatus,
    required String transporterId}) async {
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  final String transporterApiUrl = dotenv.get('shipperApiUrl');


  Map data = {"companyStatus": comapnyStatus};
  String body = json.encode(data);
  final response =
      await http.put(Uri.parse("$transporterApiUrl/$transporterId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
  if (response.statusCode == 200) {
    print(response.body);
    var decodedResponse = json.decode(response.body);
    String shipperId = decodedResponse["shipperId"];
    bool transporterApproved =
        decodedResponse["transporterApproved"].toString() == "true";
    bool companyApproved = decodedResponse["companyApproved"].toString() == "true";
    String companyStatus = decodedResponse["companyStatus"];
    bool accountVerificationInProgress = decodedResponse["accountVerificationInProgress"].toString() == "true";
    String mobileNum = decodedResponse["phoneNo"] != null
        ? decodedResponse["phoneNo"].toString()
        : "";
    shipperIdController.updateShipperId(shipperId);
    shipperIdController.updateCompanyApproved(companyApproved);
    shipperIdController.updateCompanyStatus(companyStatus);
    shipperIdController.updateMobileNum(mobileNum);
    shipperIdController
        .updateAccountVerificationInProgress(accountVerificationInProgress);
    if (decodedResponse["status"].toString() == "Success") {
      return "Success";
    } else {
      return "Error";
    }
  } else {
    return "Error";
  }
}
