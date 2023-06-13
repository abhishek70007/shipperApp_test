import 'package:get/get.dart';

class CompletedDateController extends GetxController {
  RxString completedDate = "".obs;

  void updateCompletedDateController(String newValue) {
    completedDate.value = newValue;
  }
}
