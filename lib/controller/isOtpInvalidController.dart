import 'package:get/get.dart';

class IsOtpInvalidController extends GetxController {
  RxBool isOtpInvalid = false.obs;

  void updateIsOtpInvalid(bool value) {
    isOtpInvalid.value = value;
    if (isOtpInvalid.value) {}
  }
}
