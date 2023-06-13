import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screens/accountScreens/verificationTypeSelectionScreen.dart';
import '/controller/shipperIdController.dart';
import '/screens/accountScreens/accountVerificationPage1.dart';
import '/screens/accountScreens/accountVerificationStatusScreen.dart';

// ignore: must_be_immutable
class AccountPageUtil extends StatelessWidget {
  AccountPageUtil({super.key});
  ShipperIdController shipperIdController = Get.put(ShipperIdController());

  @override
  Widget build(BuildContext context) {
    if (shipperIdController.companyStatus.value == 'verified' ||
        shipperIdController.companyStatus.value == 'inProgress') {
      return const AccountVerificationStatusScreen(); // When transporter is unverified and hasn't applied for verification
    } else {
      return const VerificationTypeSelection();
    }
  }
}
