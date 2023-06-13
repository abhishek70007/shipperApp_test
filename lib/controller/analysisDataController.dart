import 'package:get/get.dart';

class AnalysisDataController extends GetxController {
  RxInt loadingPointData = 0.obs;
  RxInt unLoadingPointData = 0.obs;
  RxInt parkingData = 0.obs;
  RxInt maintenanceData = 0.obs;
  RxInt runningTimeData = 0.obs;
  RxInt unknownStopData = 0.obs;

  void updateLoadingPointData(int value) {
    loadingPointData.value = value;
  }

  void updateUnLoadingPointData(int value) {
    unLoadingPointData.value = value;
  }

  void updateParkingData(int value) {
    parkingData.value = value;
  }

  void updateMaintenanceData(int value) {
    maintenanceData.value = value;
  }

  void updateRunningTimeData(int value) {
    runningTimeData.value = value;
  }

  void updateUnknownStopData(int value) {
    unknownStopData.value = value;
  }

}
