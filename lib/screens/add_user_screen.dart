import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/shipperIdController.dart';
import '../functions/add_user_functions.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String phoneOrMail;
  bool isError = false;
  ShipperIdController shipperIdController = Get.put(ShipperIdController());
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
      title: Text(
        "Add User/ Employee",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: kIsWeb ? 4.sp : 16.sp),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              Text(
                "Email Id / Phone Number :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kIsWeb ? 3.5.sp : 12.5.sp),
              ),
              SizedBox(
                height: 1.9.h,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Mail Id or Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                validator: (value) {
                  // if(value.toString().isEmpty){
                  //   setState(() {
                  //     isError = true;
                  //   });
                  //   return "Enter employee Mail Id";
                  // }
                  setState(() {
                    isError = false;
                  });
                  return null;
                },
                onSaved: (value) {
                  phoneOrMail = value.toString();
                },
              ),
              SizedBox(
                height: 1.9.h,
              ),
              Text(
                "Role :",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: kIsWeb ? 3.5.sp : 12.5.sp),
              ),
              SizedBox(
                width: 10.w,
                child: DropdownButton(
                  value: selectedRole,
                  items: _dropDownItem(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: const Color(0xFF000066),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await AddUserFunctions().addUser(
                  phoneOrMail, shipperIdController.companyName.value,
                  context: context);
            }
          },
          child: const Text(
            'Add Employee',
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
