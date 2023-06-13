import 'package:get/get.dart';

class TruckIdController extends GetxController {
  RxString truckId = ''.obs;

  void updateTruckId(String value) {
    truckId.value = value;
  }

  void resetTruckId() {
    truckId.value = '';
  }
}
