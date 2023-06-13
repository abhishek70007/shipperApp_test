import 'dart:convert';
import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/functions/loadOnGoingData.dart';
import '/models/BookingModel.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '/models/onGoingCardModel.dart';

getOngoingDataWithPageNo(int i) async {
  final String bookingApiUrl = dotenv.get('bookingApiUrl');

  ShipperIdController shipperIdController = Get.put(ShipperIdController());
  List<OngoingCardModel> modelList = [];

  http.Response response = await http.get(Uri.parse(
      '$bookingApiUrl?postLoadId=${shipperIdController.shipperId.value}&completed=false&cancel=false&pageNo=$i'));
     // '$bookingApiUrl?postLoadId=transporter:81a794cd-08fa-455c-9727-eaf12279410b&completed=false&cancel=false&pageNo=$i'));

  var jsonData = json.decode(response.body);
  // print("from getOngoingDataWithPageNo: ${response.body}");
  for (var json in jsonData) {
    BookingModel bookingModel = BookingModel(truckId: []);
    bookingModel.bookingDate = json['bookingDate'] ?? "NA";
    bookingModel.bookingId = json['bookingId'];
    bookingModel.postLoadId = json['postLoadId'];
    bookingModel.loadId = json['loadId'];
    bookingModel.shipperId = json['postLoadId'];
    bookingModel.truckId = json['truckId'];
    bookingModel.cancel = json['cancel'];
    bookingModel.completed = json['completed'];
    bookingModel.completedDate = json['completedDate'] ?? "NA";
    bookingModel.rate = json['rate'] != null ? json['rate'].toString() : 'NA';
    bookingModel.unitValue = json['unitValue'] ?? 'PER_TON';
    bookingModel.deviceId = json['deviceId'] != null ? json['deviceId'] == 'NA' ? 80 : int.parse(json["deviceId"]) : 80;
    bookingModel.unloadingPointCity = json['unloadingPointCity'] ?? 'NA';
    bookingModel.loadingPointCity = json['loadingPointCity'] ?? 'NA';
    bookingModel.truckNo = json['truckNo'] ?? 'NA';
    bookingModel.driverPhoneNum = json['driverPhoneNum'] ?? 'NA';
    bookingModel.driverName = json['driverName'] ?? 'NA';

    var loadAllDataModel = await loadAllOngoingData(bookingModel);
    modelList.add(loadAllDataModel!);
  }
  return modelList;
}
