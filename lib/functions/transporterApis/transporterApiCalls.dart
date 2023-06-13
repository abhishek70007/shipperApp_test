import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/transporterModel.dart';

class TransporterApiCalls {
  final String transporterApiUrl = dotenv.get("transporterApiUrl");

  Future<TransporterModel> getDataByTransporterId(String? transporterId) async {
    http.Response response =
        await http.get(Uri.parse('$transporterApiUrl/$transporterId'));
    var jsonData = json.decode(response.body);

    TransporterModel transporterModel = TransporterModel();
    transporterModel.transporterLocation =
        jsonData['transporterLocation'] != null
            ? jsonData['transporterLocation']
            : 'Na';

    transporterModel.transporterPhoneNum =
        jsonData['phoneNo'] != null ? jsonData['phoneNo'] : '';

    transporterModel.transporterId =
        jsonData['transporterId'] != null ? jsonData['transporterId'] : 'Na';

    transporterModel.transporterName = jsonData['transporterName'] != null
        ? jsonData['transporterName']
        : 'Na';

    transporterModel.companyName =
        jsonData['companyName'] != null ? jsonData['companyName'] : 'Na';

    transporterModel.transporterApproved = jsonData['transporterApproved'] != null ? jsonData['transporterApproved'] : false;

    transporterModel.companyApproved = jsonData['companyApproved'] != null ? jsonData['companyApproved'] : false;

    transporterModel.accountVerificationInProgress =
        jsonData['accountVerificationInProgress'] != null ? jsonData['accountVerificationInProgress'] : false;


    return transporterModel;
  }

  Future<String> getTransporterIdByPhoneNo({String? phoneNo}) async {
    final String transporterIDImei;
    Map data = {
      "phoneNo": "$phoneNo"
    };
    String body = json.encode(data);
    final response = await http.post(Uri.parse("$transporterApiUrl"),
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
