import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import '../screens/employee_list_with_roles_screen.dart';
import '../../Web/screens/home_web.dart';
import '../../constants/screens.dart';

//TODO: This is used to remove the employee/user from the company database.
class RemoveEmployee extends StatefulWidget {
  final String employeeUid;
  const RemoveEmployee({Key? key, required this.employeeUid}) : super(key: key);

  @override
  State<RemoveEmployee> createState() => _RemoveEmployeeState();
}

class _RemoveEmployeeState extends State<RemoveEmployee> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Do you want to remove: ${widget.employeeUid}"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: const Color(0xFF000066),
          ),
          onPressed: () {
            FirebaseDatabase database = FirebaseDatabase.instance;
            DatabaseReference ref = database.ref();
            final updateEmployee = ref.child(
                "companies/${shipperIdController.companyName.value.capitalizeFirst}/members/${widget.employeeUid}");
            updateEmployee.remove().then((value) => {
                  kIsWeb
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreenWeb(
                                    index: screens.indexOf(accountVerificationStatusScreen),
                                    selectedIndex:
                                        screens.indexOf(accountVerificationStatusScreen),
                                  )))
                      : Get.off(() => const EmployeeListRolesScreen())
                });
          },
          child: const Text(
            "Remove",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: Colors.white,
              // fixedSize: Size(28.w, 7.h),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Color(0xFF000066),
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
