import 'package:get/get.dart';

class SelectedDriverController extends GetxController {
  RxString selectedDriverBook = "".obs;
  RxBool newDriverAddedBook = false.obs;
  RxBool fromBook = false.obs;

  RxString selectedDriverTruck = "".obs;
  RxBool newDriverAddedTruck = false.obs;
  RxBool fromTruck = false.obs;

  void updateSelectedDriverBookController(String newValue) {
    selectedDriverBook.value = newValue;
  }

  void updateNewDriverAddedBookController(bool newValue) {
    newDriverAddedBook.value = newValue;
  }

  void updateSelectedDriverTruckController(String newValue) {
    selectedDriverTruck.value = newValue;
  }

  void updateNewDriverAddedTruckController(bool newValue) {
    newDriverAddedTruck.value = newValue;
  }

  void updateFromTruck(bool newValue) {
    fromTruck.value = newValue;
  }

  void updateFromBook(bool newValue) {
    fromBook.value = newValue;
  }
}
