import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/models/shipperModel.dart';


class ShipperApiCalls {
  final String shipperApiUrl = dotenv.get('shipperApiUrl');


  Future<ShipperModel> getDataByShipperId(String? shipperId) async {
    // print("");
    http.Response response =
        await http.get(Uri.parse('$shipperApiUrl/$shipperId'));
    var jsonData = json.decode(response.body);
    // print("response for shipper get call--->${response.body}");
    ShipperModel shipperModel = ShipperModel();
    shipperModel.shipperId =jsonData['shipperId'] ?? 'Na';
    shipperModel.shipperName = jsonData['shipperName'] ?? 'Na';
    shipperModel.companyName = jsonData['companyName'] ?? 'Na';
    shipperModel.shipperPhoneNum = jsonData['phoneNo'] ?? '';
    shipperModel.shipperLocation = jsonData['shipperLocation'] ?? 'Na';
    shipperModel.companyApproved = jsonData['companyApproved'] ?? false;
    shipperModel.accountVerificationInProgress = jsonData['accountVerificationInProgress'] ?? false;

    return shipperModel;
  }

  Future<String> getTransporterIdByPhoneNo({String? phoneNo}) async {
    final String transporterIDImei;
    Map data = {
      "phoneNo": "$phoneNo"
    };
    String body = json.encode(data);
    final response = await http.post(Uri.parse("$shipperApiUrl"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    var jsonData = json.decode(response.body);
    print("response is ${response.body}");
    transporterIDImei = jsonData['transporterId'];
    print("Transporter ID Imei is $transporterIDImei");
    return transporterIDImei;
  }

}
