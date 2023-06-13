import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import '/functions/getRequestorDetailsFromPostLoadId.dart';
import '/models/LoadModel.dart';
import '/models/loadApiModel.dart';
import '/models/loadPosterModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class LoadApiCalls {
  List<LoadApiModel> loadList = [];

  // final String loadApiUrl = FlutterConfig.get("loadApiUrl");
  final String loadApiUrl = dotenv.get('loadApiUrl');

  Future<Map> getDataByLoadId(String loadId) async {
    http.Response response = await http.get(Uri.parse('$loadApiUrl/$loadId'));

    var jsonData = json.decode(response.body);

    Map data = {
      'loadingPointCity': jsonData['loadingPointCity'] != null
          ? jsonData['loadingPointCity']
          : 'NA',
      'unloadingPointCity': jsonData['unloadingPointCity'] != null
          ? jsonData['unloadingPointCity']
          : 'NA',
      'noOfTrucks': jsonData['noOfTrucks'] != null
          ? jsonData['noOfTrucks'].toString()
          : 'NA',
      'productType':
      jsonData['productType'] != null ? jsonData['productType'] : 'NA',
      'postLoadId': jsonData['postLoadId'],
    };

    return data;
  }

  Future<List<LoadApiModel>> getDataByPostLoadId(String postLoadId) async {
    http.Response response =
    await http.get(Uri.parse('$loadApiUrl?postLoadId=$postLoadId'));
    var jsonData = json.decode(response.body);

    for (var json in jsonData) {
      LoadApiModel loadScreenCardsModel = LoadApiModel();
      loadScreenCardsModel.loadId = json['loadId'] != null ? json['loadId'] : 'NA';
      loadScreenCardsModel.loadingPointCity = json['loadingPointCity']  != null ? json['loadingPointCity'] : 'NA';
      loadScreenCardsModel.unloadingPointCity = json['unloadingPointCity']  != null ? json['unloadingPointCity'] : 'NA';
      loadScreenCardsModel.truckType = json['truckType']  != null ? json['truckType'] : 'NA';
      loadScreenCardsModel.weight = json['weight']  != null ? json['weight'] : 'NA';
      loadScreenCardsModel.productType = json['productType'] != null ? json['productType'] : 'NA';
      loadList.add(loadScreenCardsModel);
    }
    return loadList;
  }


  Future<void> disableActionOnLoad({String? loadId}) async {

    // final String loadApiUrl = FlutterConfig.get("loadApiUrl");
    final String loadApiUrl = dotenv.get('loadApiUrl');

    Map<String, String> data = {"status": "EXPIRED"};

    String body = json.encode(data);

    final response = await http.put(Uri.parse("$loadApiUrl/$loadId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);

    print("loadId ====== $loadApiUrl/$loadId ");
    print("Response of disable data ${response.body}");
  }

  Future<dynamic> getDataByLoadIdForBid(String? loadId) async {
    http.Response response = await http.get(Uri.parse('$loadApiUrl/$loadId'));

    Map jsonData = json.decode(response.body);

    if(response.statusCode == 200){

    LoadModel loadModel = LoadModel();
    loadModel.loadingPointCity = jsonData["loadingPointCity"] != null ? jsonData["loadingPointCity"] : 'NA';
    loadModel.postLoadId = jsonData["postLoadId"] != null ? jsonData["postLoadId"] : 'NA';
    loadModel.unloadingPointCity = jsonData["unloadingPointCity"] != null ? jsonData["unloadingPointCity"] : 'NA';
    loadModel.productType = jsonData["productType"] != null ? jsonData["productType"] : 'NA';
    loadModel.noOfTrucks = jsonData["noOfTrucks"] != null ? jsonData["noOfTrucks"] : 'NA';

    if(loadModel.postLoadId != null && loadModel.postLoadId != 'NA'){
    LoadPosterModel loadPosterModel = await getLoadPosterDetailsFromPostLoadId(loadModel.postLoadId);
    loadModel.loadPosterCompanyName = loadPosterModel.loadPosterCompanyName;
    loadModel.loadPosterPhoneNo = loadPosterModel.loadPosterPhoneNo;
    loadModel.loadPosterLocation = loadPosterModel.loadPosterLocation;
    loadModel.loadPosterName = loadPosterModel.loadPosterName;
    loadModel.loadPosterCompanyApproved = loadPosterModel.loadPosterCompanyApproved;}
    return loadModel;}
    else if(response.statusCode == 404){
      //case when load is not present in loadApi

    }
  }
}

