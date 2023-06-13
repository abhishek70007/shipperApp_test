import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/functions/shipperId_fromCompaniesDatabase.dart';
import 'package:shipper_app/models/company_users_model.dart';
import 'package:shipper_app/screens/add_user_screen.dart';
import '../Widgets/employee_card.dart';
import '../Widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';
import '../Widgets/loadingWidgets/onGoingLoadingWidgets.dart';
import '../constants/colors.dart';
import '../constants/fontSize.dart';
import '../constants/spaces.dart';

class EmployeeListRolesScreen extends StatefulWidget {
  const EmployeeListRolesScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListRolesScreen> createState() =>
      _EmployeeListRolesScreenState();
}

class _EmployeeListRolesScreenState extends State<EmployeeListRolesScreen> {
  final List<CompanyUsers> users = [];
  bool loading = true;
  bool bottomProgressLoad = false;

  @override
  void initState() {
    super.initState();
    getCompanyEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: const Color(0xFF000066),
        ),
        child: const Text('Add User/ Employee'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddUser();
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: loading
            ? const OnGoingLoadingWidgets()
            : users.isEmpty
                ? Container(
                    margin: const EdgeInsets.only(top: 153),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/EmptyLoad.png'),
                          height: 127,
                          width: 127,
                        ),
                        Text(
                          'noLoadAdded'.tr,
                          // 'Looks like you have not added any Loads!',
                          style: TextStyle(fontSize: size_8, color: grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: lightNavyBlue,
                    onRefresh: () {
                      setState(() {
                        users.clear();
                        loading = true;
                      });
                      return getCompanyEmployeeList();
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: space_15),
                      //controller: scrollController,
                      itemCount: users.length,
                      itemBuilder: (context, index) => (index ==
                              users.length) //removed -1 here
                          ? Visibility(
                              visible: bottomProgressLoad,
                              child: const bottomProgressBarIndicatorWidget())
                          : EmployeeCard(
                              companyUsersModel: users[index],
                            ),
                    ),
                  ),
      ),
    );
  }

  //TODO: This function is used get all the list of employees who are added to company database
  getCompanyEmployeeList() {
    if (mounted) {
      setState(() {
        bottomProgressLoad = true;
      });
    }
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference ref = database.ref();
    late Map<dynamic, dynamic> values;
    ref
        .child(
            "companies/${shipperIdController.companyName.value.capitalizeFirst}/members")
        .get()
        .then((DataSnapshot snapshot) => {
              values = snapshot.value as Map<dynamic, dynamic>,
              values.forEach((key, value) {
                users.add(CompanyUsers(uid: key, role: value));
              }),
              setState(() {
                loading = false;
              }),
            });
  }
}
