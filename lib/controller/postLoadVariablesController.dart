import 'package:get/get.dart';

class PostLoadVariablesController extends GetxController {
  RxString bookingDate = "".obs;
  RxString completedDate = "".obs;

  // RxString loadingPointCityPostLoad = "".obs;
  // RxString loadingPointStatePostLoad = "".obs;
  // RxString loadingPointPostLoad = "".obs;
  // RxString unloadingPointCityPostLoad = "".obs;
  // RxString unloadingPointStatePostLoad = "".obs;
  // RxString unloadingPointPostLoad = "".obs;
  updateBookingDate(value) {
    bookingDate.value = value;
  }

  void updateCompletedDate(value) {
    completedDate.value = value;
  }
}
