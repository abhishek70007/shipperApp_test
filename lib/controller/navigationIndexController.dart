import 'package:get/get.dart';

class NavigationIndexController extends GetxController {
  RxInt index = 0.obs;

  void updateIndex(int value) {
    index.value = value;
  }
}