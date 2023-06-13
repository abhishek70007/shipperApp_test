import 'package:get/get.dart';

class ShipperIdController extends GetxController {
  RxString shipperId = "".obs;

  void updateShipperId(String newValue) {
    shipperId.value = newValue;
  }

  RxBool companyApproved = false.obs;

  void updateCompanyApproved(bool newValue) {
    companyApproved.value = newValue;
  }

  RxBool isOwner = false.obs;

  void updateOwnerStatus(bool newValue) {
    isOwner.value = newValue;
  }

  RxString name = "".obs;

  void updateName(String newValue) {
    name.value = newValue;
  }

  RxString companyStatus = "".obs;

  void updateCompanyStatus(String newValue) {
    companyStatus.value = newValue;
  }

  RxString companyName = "".obs;

  void updateCompanyName(String newValue) {
    companyName.value = newValue;
  }

  RxBool accountVerificationInProgress = false.obs;

  void updateAccountVerificationInProgress(bool newValue) {
    accountVerificationInProgress.value = newValue;
  }

  RxString mobileNum = "".obs;

  void updateMobileNum(String newValue) {
    mobileNum.value = newValue;
  }

  RxString emailId = "".obs;

  void updateEmailId(String newValue) {
    emailId.value = newValue;
  }

  RxString shipperLocation = "".obs;

  void updateShipperLocation(String newValue) {
    shipperLocation.value = newValue;
  }

  RxString jmtToken = "".obs;

  void updateJmtToken(String newValue) {
    jmtToken.value = newValue;
  }
}
