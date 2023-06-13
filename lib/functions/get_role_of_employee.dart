import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shipper_app/controller/shipperIdController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = database.ref();
ShipperIdController shipperIdController = Get.put(ShipperIdController());

//TODO: This function is used to get the shipper Id of an employer from our firebase database
//This function is called at the start of the application and also using isolated shipper id function.
getRoleOfEmployee(String uid) async{
  final snapshot = await ref.child('companies/${shipperIdController.companyName.value.capitalizeFirst}/members/$uid').get(); // This is the path for owner's shipper ID
  if(snapshot.exists){
    shipperIdController.updateOwnerStatus(snapshot.value == 'owner');
     // After getting the owner status we are updating the role status through out the app
  }else{
    debugPrint('Error in get role of employee function'); // If there is no data exist then we are using the user's shipper id only
  }
}