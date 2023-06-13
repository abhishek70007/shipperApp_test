import 'package:get/get.dart';

class PostLoadErrorController extends GetxController {
  RxString error = ''.obs;

  void updatePostLoadError(String value) {
    error.value = value;
  }

  void resetPostLoadError() {
    error.value = '';
  }
}
