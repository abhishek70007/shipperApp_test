import 'package:get/get.dart';

class LockUnlockController extends GetxController {
  RxBool lockUnlockStatus = false.obs;

  void updateLockUnlockStatus(bool value) {
    lockUnlockStatus.value = value;
  }
}
