import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/controller/shipperIdController.dart';
import '/models/biddingModel.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<BiddingModel>> getBidsFromBidApi() async {
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  var jsonData;
  List<BiddingModel> biddingModelList = [];
  // final String bidApiUrl = FlutterConfig.get("biddingApiUrl").toString();
  final String bidApiUrl = dotenv.get('biddingApiUrl');

  http.Response response = await http.get(Uri.parse(
      "$bidApiUrl?transporterId=${shipperIdController.shipperId.value}"));

  jsonData = json.decode(response.body);
  for (var json in jsonData) {
    BiddingModel biddingModel = BiddingModel();
    biddingModel.bidId = json["bidId"];
    biddingModel.transporterId = json["transporterId"];
    biddingModel.loadId = json["loadId"];
    biddingModel.currentBid = json["currentBid"].toString();
    biddingModel.previousBid = json['previousBid'].toString();
    biddingModel.unitValue = json["unitValue"];
    biddingModel.truckIdList = json["truckId"];
    biddingModel.shipperApproval = json["shipperApproval"];
    biddingModel.transporterApproval = json['transporterApproval'];
    biddingModel.biddingDate = json['biddingDate'];
    biddingModelList.add(biddingModel);
  }
  return biddingModelList;
}
