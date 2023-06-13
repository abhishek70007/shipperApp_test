import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../functions/alert_dialog.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/constants/fontSize.dart';
import '/constants/elevation.dart';
import '/constants/radius.dart';
import '/screens/navigationScreen.dart';
import 'package:get/get.dart';
import '/controller/hudController.dart';
import '/controller/timerController.dart';
import '/controller/isOtpInvalidController.dart';
import '/functions/shipperApis/runShipperApiPost.dart';
import 'package:flutter/foundation.dart';
import '/controller/shipperIdController.dart';


class CompanyDetailsForm extends StatefulWidget {
  const CompanyDetailsForm({Key? key}) : super(key: key);

  @override
  State<CompanyDetailsForm> createState() => _CompanyDetailsFormState();
}

class _CompanyDetailsFormState extends State<CompanyDetailsForm> {
  // TextStyle textStyleForHeader =

  TimerController timerController = Get.put(TimerController());
  HudController hudController = Get.put(HudController());
  IsOtpInvalidController isOtpInvalidController =
  Get.put(IsOtpInvalidController());

  ShipperIdController shipperIdController = Get.put(ShipperIdController());
  String? shipperId;


  // String _verificationCode = '';

  TextEditingController companyNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Image(
                      image: AssetImage("assets/background/login_page_wave.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: space_12, right: space_12, top: space_15),
                      child: const Image(
                          image: AssetImage("assets/icons/liveasy.png")))
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,top: space_3),
                child: Text(
                    "Company Details",
                    style:TextStyle(
                      color: white,
                      fontSize: size_10,
                      fontFamily: "Poppins",
                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Company Name :",
                      style: TextStyle(
                        color: white,
                        fontSize: size_7,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: companyNameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        hintText: "Enter Company Name",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name :",
                      style: TextStyle(
                        color: white,
                        fontSize: size_7,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        hintText: "Enter Your Name",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GST Number :",
                      style: TextStyle(
                        color: white,
                        fontSize: size_7,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: gstController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        hintText: "Enter Gst Number",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,top: space_3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address :",
                      style: TextStyle(
                        color: white,
                        fontSize: size_7,
                        fontFamily: "Poppins",
                      ),
                    ),
                    const SizedBox(height: 8,),
                    TextFormField(
                      controller: addressController,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white),borderRadius:BorderRadius.circular(radius_6)),
                        hintText: "Address",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: size_6,
                          // color: darkCharcoal,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size_6,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: space_4, right: space_4,bottom: space_5),
                child: Container(
                  margin: EdgeInsets.only(
                    top: space_7,
                  ),
                  height: space_9,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: widgetBackGroundColor,
                    borderRadius: BorderRadius.circular(radius_6),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith((states) => elevation_0),
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.01)),
                    ),
                    onPressed: (){
                      if(companyNameController.text.toString().isNotEmpty && nameController.text.toString().isNotEmpty){
                        updateDetails();
                      }else{
                        Fluttertoast.showToast(msg: 'Enter details (company name and name)',fontSize: size_8,backgroundColor: Colors.white,textColor: Colors.black);
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          fontSize: size_8,
                          color: const Color(0xFF002087),
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  updateDetails() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if(firebaseAuth.currentUser!.emailVerified){
      firebaseAuth.currentUser!.updateDisplayName(nameController.text.toString());
      String? id = await runShipperApiPost(
        emailId:firebaseAuth.currentUser!.email.toString(),
        phoneNo: firebaseAuth.currentUser!.phoneNumber.toString().replaceFirst("+91", ""),
        shipperName: nameController.text.toString(),
        companyName: companyNameController.text.toString(),
        gst: gstController.text.toString(),
        address: addressController.text.toString(),
      );
      if(id!=null) {
        log('Shipper id--->$id');
        if(!mounted){ log('In not mounted');return ;}
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
      }
    }else{
      alertDialog("Verify Email", "Verify your mail id to continue", context);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginWeb()));
    }
  }
}
