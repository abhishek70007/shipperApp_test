import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shipper_app/screens/employee_list_with_roles_screen.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import 'package:shipper_app/screens/accountScreens/accountVerificationStatusScreen.dart';
import '../Widgets/alertDialog/CompletedDialog.dart';
import '../Widgets/alertDialog/orderFailedAlertDialog.dart';
import '../constants/screens.dart';
import '../controller/navigationIndexController.dart';
import '../screens/navigationScreen.dart';
import '/functions/alert_dialog.dart';

class AddUserFunctions {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  NavigationIndexController navigationIndexController =
      Get.put(NavigationIndexController());

  //TODO: The functions getUserByMail and getUserByPhone are used to get the uid of the required employee for adding him to the database.
  //TODO: These functions are called respectively whether employer given mailId or phone number of an employee.

  getUserByMail(String mail) async {
    final String uidApiMail = dotenv.get("getUidByMail");
    http.Response response = await http.get(Uri.parse("$uidApiMail/$mail"));
    if (response.body.contains("{")) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData["transportererrorresponse"]["debugMessage"]
          .toString()
          .contains("No user record found")) {
        return "No user Found";
      }
    } else {
      return response.body;
    }
  }

  getUserByPhone(String phoneNumber) async {
    final String uidApiPhone = dotenv.get("getUidByPhoneNumber");
    http.Response response =
        await http.get(Uri.parse("$uidApiPhone/+91$phoneNumber"));
    if (response.body.contains("{")) {
      var jsonData = json.decode(response.body);
      if (jsonData["transportererrorresponse"]["debugMessage"]
          .toString()
          .contains("No user record found")) {
        return "No user Found";
      }
    } else {
      return response.body;
    }
  }

  //TODO: This function is called for adding the employee to the company's database so that he can use employer's shipper Id
  addUser(String? phoneOrMail, String companyName, {required BuildContext context}) async {
    String uid = '';
    //TODO: Before adding the user, we will look for him accordingly either by mail Id or mobile number of an employee
    // And accordingly the functions are being called to get the uid for the required employee
    if (phoneOrMail.toString().isNumericOnly && phoneOrMail.toString().length == 10) {
      uid = await getUserByPhone(phoneOrMail!);
    } else if(phoneOrMail.toString().isEmail){
      uid = await getUserByMail(phoneOrMail!);
    }
    if (uid == "No user Found") {
      alertDialog('Add Employee', 'Employee Not Found', context);
    } else {
      //TODO: When user is already log in, we can get his uid and we are adding it to the company's database
      final newEmployeeRef = ref.child(
          "companies/${companyName.capitalizeFirst}/members"); //Database Path for Adding employee
      newEmployeeRef
          .update({
            uid: "employee",
          })
          .then((value) => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return completedDialog(
                        upperDialogText: 'congratulations'.tr,
                        lowerDialogText:
                            'You Have Successfully added employee');
                  },
                ),
                Timer(
                    const Duration(seconds: 3),
                    () => {
                          kIsWeb
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreenWeb(
                                            index: screens
                                                .indexOf(employeeListScreen),
                                            selectedIndex: screens.indexOf(
                                                accountVerificationStatusScreen),
                                          )))
                              : Get.offAll(() => NavigationScreen()),
                          navigationIndexController.updateIndex(2),
                        }),
                //  alertDialog("Added Employee","Employee Added Successfully",context)
              })
          .catchError((error) {
            return showDialog(
              context: context,
              builder: (BuildContext context) {
                return OrderFailedAlertDialog();
              },
            );
            // return alertDialog("Error", "Try After Some Time", context);
            // return alertDialog("Error", "$error", context);
          });
    }
  }
}
