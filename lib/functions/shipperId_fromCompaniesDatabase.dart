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
getShipperIdFromCompanyDatabase() async{
  final snapshot = await ref.child('companies/${shipperIdController.companyName.value.capitalizeFirst}/data').get(); // This is the path for owner's shipper ID
  if(snapshot.exists){
    String sid = snapshot.value.toString().substring(6,snapshot.value.toString().length-1);
    // the data we received will be in form of "{sid: shipper:abed1234..........}"
    shipperIdController.updateShipperId(sid); // After getting the shipper id we are updating the shipper Id through out the app
  }else{
    debugPrint('Error in get shipperId From company Database function'); // If there is no data exist then we are using the user's shipper id only
  }
}