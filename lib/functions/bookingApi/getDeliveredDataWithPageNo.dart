import 'dart:convert';
import 'package:get/get.dart';
import '/controller/shipperIdController.dart';
import '/functions/loadDeliveredData.dart';
import '/models/BookingModel.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/models/deliveredCardModel.dart';

getDeliveredDataWithPageNo(int i) async {
  // final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');
  final String bookingApiUrl = dotenv.get('bookingApiUrl');

  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  List<DeliveredCardModel> modelList = [];
  http.Response response = await http.get(Uri.parse(
      '$bookingApiUrl?postLoadId=${shipperIdController.shipperId.value}&completed=true&cancel=false&pageNo=$i'));

  var jsonData = json.decode(response.body);

  for (var json in jsonData) {
    BookingModel bookingModel = BookingModel(truckId: []);
    bookingModel.bookingDate =
        json['bookingDate'] != null ? json['bookingDate'] : "NA";
    bookingModel.bookingId = json['bookingId'];
    bookingModel.postLoadId = json['postLoadId'];
    bookingModel.loadId = json['loadId'];
    bookingModel.shipperId = json['transporterId'];
    bookingModel.truckId = json['truckId'];
    bookingModel.cancel = json['cancel'];
    bookingModel.completed = json['completed'];
    bookingModel.completedDate =
        json['completedDate'] != null ? json['completedDate'] : "NA";
    bookingModel.rate = json['rate'] != null ? json['rate'].toString() : 'NA';
    bookingModel.unitValue = json['unitValue'];
    var loadAllDataModel = await loadAllDeliveredData(bookingModel);
    modelList.add(loadAllDataModel);
  }
  return modelList;
}
