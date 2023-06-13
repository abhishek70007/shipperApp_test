import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/models/loadDetailsScreenModel.dart';
import '/models/loadPosterModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../getLoadPosterDetailsFromApi.dart';

Future<List<LoadDetailsScreenModel>> runFindLoadApiGet(
    String loadingPointCity, String unloadingPointCity) async {
  LoadPosterModel loadPosterModel = LoadPosterModel();

  String additionalQuery = "";

  if (loadingPointCity != "" && unloadingPointCity != "") {
    additionalQuery =
        "?unloadingPointCity=$unloadingPointCity&loadingPointCity=$loadingPointCity";
  } else if (loadingPointCity != "") {
    additionalQuery = "?loadingPointCity=$loadingPointCity";
  } else if (unloadingPointCity != "") {
    additionalQuery = "?unloadingPointCity=$unloadingPointCity";
  } else if (loadingPointCity == "" && unloadingPointCity == "") {
    additionalQuery = "";
  }

  var jsonData;
  List<LoadDetailsScreenModel> modelList = [];

  // final String loadApiUrl = FlutterConfig.get("loadApiUrl").toString();
  final String loadApiUrl = dotenv.get('loadApiUrl');

  http.Response response =
      await http.get(Uri.parse("$loadApiUrl$additionalQuery"));

  jsonData = json.decode(response.body);

  for (var json in jsonData) {
    LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();

    loadDetailsScreenModel.loadId =
        json["loadId"] != null ? json['loadId'] : 'NA';
    loadDetailsScreenModel.loadingPoint =
        json["loadingPoint"] != null ? json['loadingPoint'] : 'NA';
    loadDetailsScreenModel.loadingPointCity =
        json["loadingPointCity"] != null ? json['loadingPointCity'] : 'NA';
    loadDetailsScreenModel.loadingPointState =
        json["loadingPointState"] != null ? json['loadingPointState'] : 'NA';
    loadDetailsScreenModel.postLoadId =
        json["postLoadId"] != null ? json['postLoadId'] : 'NA';
    loadDetailsScreenModel.unloadingPoint =
        json["unloadingPoint"] != null ? json['unloadingPoint'] : 'NA';
    loadDetailsScreenModel.unloadingPointCity =
        json["unloadingPointCity"] != null ? json['unloadingPointCity'] : 'NA';
    loadDetailsScreenModel.unloadingPointState =
        json["unloadingPointState"] != null
            ? json['unloadingPointState']
            : 'NA';
    loadDetailsScreenModel.productType =
        json["productType"] != null ? json['productType'] : 'NA';
    loadDetailsScreenModel.truckType =
        json["truckType"] != null ? json['truckType'] : 'NA';
    loadDetailsScreenModel.noOfTyres =
        json["noOfTyres"] != null ? json['noOfTyres'] : 'NA';
    loadDetailsScreenModel.weight =
        json["weight"] != null ? json['weight'] : 'NA';
    loadDetailsScreenModel.comment =
        json["comment"] != null ? json['comment'] : 'NA';
    loadDetailsScreenModel.status =
        json["status"] != null ? json['status'] : 'NA';
    loadDetailsScreenModel.loadDate =
        json["loadDate"] != null ? json['loadDate'] : 'NA';
    loadDetailsScreenModel.rate =
        json["rate"] != null ? json['rate'].toString() : 'NA';
    loadDetailsScreenModel.unitValue =
        json["unitValue"] != null ? json['unitValue'] : 'NA';

    if (json["postLoadId"].contains('transporter') ||
        json["postLoadId"].contains('shipper')) {
      loadPosterModel = await getLoadPosterDetailsFromApi(
          loadPosterId: json["postLoadId"].toString());
    } else {
      continue;
    }

    if (loadPosterModel != null) {
      loadDetailsScreenModel.loadPosterId = loadPosterModel.loadPosterId;
      loadDetailsScreenModel.phoneNo = loadPosterModel.loadPosterPhoneNo;
      loadDetailsScreenModel.loadPosterLocation =
          loadPosterModel.loadPosterLocation;
      loadDetailsScreenModel.loadPosterName = loadPosterModel.loadPosterName;
      loadDetailsScreenModel.loadPosterCompanyName =
          loadPosterModel.loadPosterCompanyName;
      loadDetailsScreenModel.loadPosterKyc = loadPosterModel.loadPosterKyc;
      loadDetailsScreenModel.loadPosterCompanyApproved =
          loadPosterModel.loadPosterCompanyApproved;
      loadDetailsScreenModel.loadPosterApproved =
          loadPosterModel.loadPosterApproved;
    } else {
      //this will run when postloadId value is something different than uuid , like random text entered from postman
      // loadDetailsScreenModel.loadPosterId = 'NA';
      // loadDetailsScreenModel.phoneNo = '';
      // loadDetailsScreenModel.loadPosterLocation = 'NA';
      // loadDetailsScreenModel.loadPosterName = 'NA';
      // loadDetailsScreenModel.loadPosterCompanyName = 'NA';
      // loadDetailsScreenModel.loadPosterKyc = 'NA';
      // loadDetailsScreenModel.loadPosterCompanyApproved = true;
      // loadDetailsScreenModel.loadPosterApproved = true;
    }

    modelList.add(loadDetailsScreenModel);
  }
  return modelList;
}
