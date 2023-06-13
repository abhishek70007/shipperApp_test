import 'package:get/get.dart';

class TrucksNearUserController extends GetxController {
  RxInt distanceRadius = 0.obs;
  RxBool nearStatus = true.obs;

  void updateDistanceRadiusData(int value) {
    distanceRadius.value = value;
  }

  void updateNearStatusData(bool value) {
    nearStatus.value = value;
  }
}
