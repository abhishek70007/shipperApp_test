import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import '../../screens/employee_list_with_roles_screen.dart';
import '../../Web/screens/home_web.dart';
import '../../constants/screens.dart';

//TODO: This is used to update the employee role
class UpdateEmployeeRole extends StatefulWidget {
  final String employeeUid;
  const UpdateEmployeeRole({Key? key, required this.employeeUid})
      : super(key: key);

  @override
  State<UpdateEmployeeRole> createState() => _UpdateEmployeeRoleState();
}

class _UpdateEmployeeRoleState extends State<UpdateEmployeeRole> {
  String selectedRole = "employee";
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> roles = ['employee', 'owner'];
    return roles
        .map((value) => DropdownMenuItem(value: value, child: Text(value)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: const Text('Update Role:'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Employee Name/Uid: ${widget.employeeUid}"),
            DropdownButton(
              value: selectedRole,
              items: _dropDownItem(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: const Color(0xFF000066),
            //fixedSize: Size(28.w, 7.h),
          ),
          onPressed: () {
            //TODO: Here we have the code to update the role of an user
            FirebaseDatabase database = FirebaseDatabase.instance;
            DatabaseReference ref = database.ref();
            final updateEmployee = ref.child(
                "companies/${shipperIdController.companyName.value.capitalizeFirst}/members");
            updateEmployee.update({
              widget.employeeUid: selectedRole,
            }).then((value) => {
                  //kIsWeb ?
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => kIsWeb?HomeScreenWeb(
                                    index: screens.indexOf(employeeListScreen),
                                    selectedIndex:
                                        screens.indexOf(accountVerificationStatusScreen),
                                  ):const EmployeeListRolesScreen()
                          )
                  )
                      //: Get.off(() => const EmployeeListRolesScreen())
                });
          },
          child: const Text(
            "Update",
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
