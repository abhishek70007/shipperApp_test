import 'dart:io';

import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/functions/loadApiCalls.dart';
import '/models/LoadModel.dart';
import '/models/biddingModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

getBidDataWithPageNo(int i) async {
  ShipperIdController shipperIdController =
  Get.put(ShipperIdController());
  // final String biddingApiUrl = FlutterConfig.get('biddingApiUrl');
  final String biddingApiUrl = dotenv.get('biddingApiUrl');
  final LoadApiCalls loadApiCalls = LoadApiCalls();
  http.Response response = await http.get(Uri.parse(
      "$biddingApiUrl?transporterId=${shipperIdController.shipperId.value}&pageNo=$i"),
  headers: <String, String>{
    HttpHeaders.authorizationHeader: shipperIdController.jmtToken.value
  });
  var jsonData = json.decode(response.body);
  var biddingModelList = [];
  for (var json in jsonData) {
    BiddingModel biddingModel = BiddingModel();
    biddingModel.bidId = json['bidId'] == null ? 'NA' : json['bidId'];
    biddingModel.transporterId =
    json['transporterId'] == null ? 'NA' : json['transporterId'];
    biddingModel.loadId = json['loadId'] == null ? 'NA' : json['loadId'];
    biddingModel.currentBid =
    json['currentBid'] == null ? 'NA' : json['currentBid'].toString();
    biddingModel.previousBid =
    json['previousBid'] == null ? 'NA' : json['previousBid'].toString();
    biddingModel.unitValue =
    json['unitValue'] == null ? 'NA' : json['unitValue'];
    biddingModel.truckIdList =
    json['truckId'] == null ? 'NA' : json['truckId'];
    biddingModel.shipperApproval = json["shipperApproval"];
    biddingModel.transporterApproval = json['transporterApproval'];
    biddingModel.biddingDate =
    json['biddingDate'] != null ? json['biddingDate'] : 'NA';
    LoadModel? loadModel = await loadApiCalls.getDataByLoadIdForBid(biddingModel.loadId);
    if(loadModel != null){
    biddingModel.loadingPointCity = loadModel.loadingPointCity;
    biddingModel.unloadingPointCity = loadModel.unloadingPointCity;
    biddingModel.noOfTrucks = loadModel.noOfTrucks;
    biddingModel.productType = loadModel.productType;
    biddingModel.postLoadId = loadModel.postLoadId;
    biddingModel.loadPosterCompanyName = loadModel.loadPosterCompanyName;
    biddingModel.loadPosterPhoneNo = loadModel.loadPosterPhoneNo;
    biddingModel.loadPosterLocation = loadModel.loadPosterLocation;
    biddingModel.loadPosterName = loadModel.loadPosterName;
    biddingModel.loadPosterCompanyApproved = loadModel.loadPosterCompanyApproved;
    biddingModelList.add(biddingModel);}
    else{
      // case when load does not exist;
    }
  }
  return biddingModelList;
}