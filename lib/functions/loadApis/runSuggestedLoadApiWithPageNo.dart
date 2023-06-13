import '/functions/getLoadPosterDetailsFromApi.dart';
import '/models/WidgetLoadDetailsScreenModel.dart';
import '/models/loadDetailsScreenModel.dart';
import '/models/loadPosterModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

runSuggestedLoadApiWithPageNo(int i) async {
  // String loadApiUrl = FlutterConfig.get("loadApiUrl").toString();
  String loadApiUrl = dotenv.get('loadApiUrl');

  var jsonData;
  var loadData = [];
  Uri url = Uri.parse("$loadApiUrl?pageNo=$i&suggestedLoads=true");
  http.Response response = await http.get(url);
  jsonData = await jsonDecode(response.body);
  LoadPosterModel loadPosterModel = LoadPosterModel();

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
    loadDetailsScreenModel.loadingPoint2 =
        json["loadingPoint2"] != null ? json['loadingPoint2'] : 'NA';
    loadDetailsScreenModel.loadingPointCity2 =
        json["loadingPointCity2"] != null ? json['loadingPointCity2'] : 'NA';
    loadDetailsScreenModel.loadingPointState =
        json["loadingPointState2"] != null ? json['loadingPointState2'] : 'NA';
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
    loadDetailsScreenModel.unloadingPoint2 =
    json["unloadingPoint2"] != null ? json['unloadingPoint2'] : 'NA';
    loadDetailsScreenModel.unloadingPointCity =
    json["unloadingPointCity2"] != null ? json['unloadingPointCity2'] : 'NA';
    loadDetailsScreenModel.unloadingPointState =
    json["unloadingPointState2"] != null
        ? json['unloadingPointState2']
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
      loadDetailsScreenModel.loadPosterId = 'NA';
      loadDetailsScreenModel.phoneNo = '';
      loadDetailsScreenModel.loadPosterLocation = 'NA';
      loadDetailsScreenModel.loadPosterName = 'NA';
      loadDetailsScreenModel.loadPosterCompanyName = 'NA';
      loadDetailsScreenModel.loadPosterKyc = 'NA';
      loadDetailsScreenModel.loadPosterCompanyApproved = true;
      loadDetailsScreenModel.loadPosterApproved = true;
    }
    loadData.add(loadDetailsScreenModel);
  }
  return loadData;
}

runWidgetSuggestedLoadApiWithPageNo(int i) async {
  String loadApiUrl = dotenv.get("loadApiUrl").toString();

  var jsonData;
  var loadData = [];
  Uri url = Uri.parse("$loadApiUrl?pageNo=$i&suggestedLoads=true");
  http.Response response = await http.get(url);
  jsonData = await jsonDecode(response.body);
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
    loadDetailsScreenModel.loadingPoint2 =
    json["loadingPoint2"] != null ? json['loadingPoint2'] : 'NA';
    loadDetailsScreenModel.loadingPointCity2 =
    json["loadingPointCity2"] != null ? json['loadingPointCity2'] : 'NA';
    loadDetailsScreenModel.loadingPointState2 =
    json["loadingPointState2"] != null ? json['loadingPointState2'] : 'NA';
    loadDetailsScreenModel.postLoadId =
        json["postLoadId"] != null ? json['postLoadId'] : 'NA';
    print("Post load ID is ${loadDetailsScreenModel.postLoadId}");
    loadDetailsScreenModel.unloadingPoint =
        json["unloadingPoint"] != null ? json['unloadingPoint'] : 'NA';
    loadDetailsScreenModel.unloadingPointCity =
        json["unloadingPointCity"] != null ? json['unloadingPointCity'] : 'NA';
    loadDetailsScreenModel.unloadingPointState =
        json["unloadingPointState"] != null
            ? json['unloadingPointState']
            : 'NA';
    loadDetailsScreenModel.unloadingPoint2 =
    json["unloadingPoint2"] != null ? json['unloadingPoint2'] : 'NA';
    loadDetailsScreenModel.unloadingPointCity2 =
    json["unloadingPointCity2"] != null ? json['unloadingPointCity2'] : 'NA';
    loadDetailsScreenModel.unloadingPointState2 =
    json["unloadingPointState2"] != null
        ? json['unloadingPointState2']
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
    loadData.add(loadDetailsScreenModel);
  }
  return loadData;
}

getLoadDetailsByPostLoadID({required String loadPosterId}) async {
  LoadPosterModel loadPosterModel = LoadPosterModel();
  WidgetLoadDetailsScreenModel widgetLoadDetailsScreenModel =
      WidgetLoadDetailsScreenModel();
  if (loadPosterId.contains('transporter') ||
      loadPosterId.contains('shipper')) {
    loadPosterModel = await getLoadPosterDetailsFromApi(
        loadPosterId: loadPosterId.toString());
  } else {
    print("Nothing");
  }

  if (loadPosterModel != null) {
    widgetLoadDetailsScreenModel.loadPosterId = loadPosterModel.loadPosterId;
    widgetLoadDetailsScreenModel.phoneNo = loadPosterModel.loadPosterPhoneNo;
    widgetLoadDetailsScreenModel.loadPosterLocation =
        loadPosterModel.loadPosterLocation;
    widgetLoadDetailsScreenModel.loadPosterName =
        loadPosterModel.loadPosterName;
    widgetLoadDetailsScreenModel.loadPosterCompanyName =
        loadPosterModel.loadPosterCompanyName;
    widgetLoadDetailsScreenModel.loadPosterKyc = loadPosterModel.loadPosterKyc;
    widgetLoadDetailsScreenModel.loadPosterCompanyApproved =
        loadPosterModel.loadPosterCompanyApproved;
    widgetLoadDetailsScreenModel.loadPosterApproved =
        loadPosterModel.loadPosterApproved;
  } else {
    //this will run when postloadId value is something different than uuid , like random text entered from postman
    widgetLoadDetailsScreenModel.loadPosterId = 'NA';
    widgetLoadDetailsScreenModel.phoneNo = '';
    widgetLoadDetailsScreenModel.loadPosterLocation = 'NA';
    widgetLoadDetailsScreenModel.loadPosterName = 'NA';
    widgetLoadDetailsScreenModel.loadPosterCompanyName = 'NA';
    widgetLoadDetailsScreenModel.loadPosterKyc = 'NA';
    widgetLoadDetailsScreenModel.loadPosterCompanyApproved = true;
    widgetLoadDetailsScreenModel.loadPosterApproved = true;
  }
  return widgetLoadDetailsScreenModel;
}
