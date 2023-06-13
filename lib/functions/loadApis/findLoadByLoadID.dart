import 'dart:convert';
import 'package:get/get.dart';
import '/functions/getLoadPosterDetailsFromApi.dart';
import '/models/loadDetailsScreenModel.dart';
import '/models/loadPosterModel.dart';
import '/screens/loadDetailsScreen.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

List<LoadDetailsScreenModel> data = [];

LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();

Future findLoadByLoadID(String loadId) async {
  // String loadApiUrl = FlutterConfig.get("loadApiUrl").toString();
  String loadApiUrl = dotenv.get('loadApiUrl');

  var jsonData;
  Uri url = Uri.parse("$loadApiUrl$loadId");
  http.Response response = await http.get(url);
  jsonData = await jsonDecode(response.body);
  LoadPosterModel loadPosterModel = LoadPosterModel();
  loadDetailsScreenModel.loadId =
      jsonData["loadId"] != null ? jsonData['loadId'] : 'NA';
  loadDetailsScreenModel.loadingPoint =
      jsonData["loadingPoint"] != null ? jsonData['loadingPoint'] : 'NA';
  loadDetailsScreenModel.loadingPointCity = jsonData["loadingPointCity"] != null
      ? jsonData['loadingPointCity']
      : 'NA';
  loadDetailsScreenModel.loadingPointState =
      jsonData["loadingPointState"] != null
          ? jsonData['loadingPointState']
          : 'NA';
  loadDetailsScreenModel.postLoadId =
      jsonData["postLoadId"] != null ? jsonData['postLoadId'] : 'NA';
  loadDetailsScreenModel.unloadingPoint =
      jsonData["unloadingPoint"] != null ? jsonData['unloadingPoint'] : 'NA';
  loadDetailsScreenModel.unloadingPointCity =
      jsonData["unloadingPointCity"] != null
          ? jsonData['unloadingPointCity']
          : 'NA';
  loadDetailsScreenModel.unloadingPointState =
      jsonData["unloadingPointState"] != null
          ? jsonData['unloadingPointState']
          : 'NA';
  loadDetailsScreenModel.productType =
      jsonData["productType"] != null ? jsonData['productType'] : 'NA';
  loadDetailsScreenModel.truckType =
      jsonData["truckType"] != null ? jsonData['truckType'] : 'NA';
  loadDetailsScreenModel.noOfTyres =
      jsonData["noOfTyres"] != null ? jsonData['noOfTyres'] : 'NA';
  loadDetailsScreenModel.weight =
      jsonData["weight"] != null ? jsonData['weight'] : 'NA';
  loadDetailsScreenModel.comment =
      jsonData["comment"] != null ? jsonData['comment'] : 'NA';
  loadDetailsScreenModel.status =
      jsonData["status"] != null ? jsonData['status'] : 'NA';
  loadDetailsScreenModel.loadDate =
      jsonData["loadDate"] != null ? jsonData['loadDate'] : 'NA';
  loadDetailsScreenModel.rate =
      jsonData["rate"] != null ? jsonData['rate'].toString() : 'NA';
  loadDetailsScreenModel.unitValue =
      jsonData["unitValue"] != null ? jsonData['unitValue'] : 'NA';

  if (jsonData["postLoadId"].contains('transporter') ||
      jsonData["postLoadId"].contains('shipper')) {
    loadPosterModel = await getLoadPosterDetailsFromApi(
        loadPosterId: jsonData["postLoadId"].toString());
  } else {
    print("Mereko nhi pata kya horela hai check karna padega");
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
    loadDetailsScreenModel.loadPosterId = 'NA';
    loadDetailsScreenModel.phoneNo = '';
    loadDetailsScreenModel.loadPosterLocation = 'NA';
    loadDetailsScreenModel.loadPosterName = 'NA';
    loadDetailsScreenModel.loadPosterCompanyName = 'NA';
    loadDetailsScreenModel.loadPosterKyc = 'NA';
    loadDetailsScreenModel.loadPosterCompanyApproved = true;
    loadDetailsScreenModel.loadPosterApproved = true;
  }

  data.add(loadDetailsScreenModel);
  Get.to(
      () => LoadDetailsScreen(loadDetailsScreenModel: loadDetailsScreenModel));
}
