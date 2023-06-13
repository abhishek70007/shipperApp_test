import 'package:get/get.dart';

class AnalysisScreenNavController extends GetxController {
  RxInt upperNavIndex = 0.obs;


  void updateUpperNavIndex(int value) {
    upperNavIndex.value = value;
  }

}
