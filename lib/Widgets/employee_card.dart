import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/Widgets/alertDialog/update_employee_alert_dialog.dart';
import 'package:shipper_app/Widgets/remove_employee_alert_dialog.dart';
import 'package:shipper_app/models/company_users_model.dart';
import '../constants/colors.dart';
import '../constants/fontSize.dart';
import '../constants/fontWeights.dart';
import '../constants/radius.dart';
import '../constants/spaces.dart';
import '../models/popup_model_for_employee_card.dart';

//TODO: This card is used to display the employee name/uid and role in the company and also we can edit the role as well as delete the employee from company database
class EmployeeCard extends StatelessWidget {
  CompanyUsers companyUsersModel;
  EmployeeCard({Key? key, required this.companyUsersModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: space_2),
      child: Card(
        color: Colors.white,
        elevation: 3,
        child: Container(
          padding:
              EdgeInsets.only(bottom: space_2, left: space_2, right: space_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Employee Name/Id: ${companyUsersModel.uid}",
                    style: TextStyle(
                        fontSize: kIsWeb ? size_8 : size_4,
                        color: veryDarkGrey,
                        fontFamily: 'montserrat'),
                  ),
                  PopupMenuButton<PopUpMenuForEmployee>(
                      offset: Offset(0, space_2),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(radius_2))),
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [
                            ...MenuItemsForEmployee.listItem
                                .map(showEachItemFromList)
                                .toList(),
                          ]),
                ],
              ),
              SizedBox(
                height: space_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Role : ${companyUsersModel.role}",
                    style: TextStyle(
                        fontSize: kIsWeb ? size_8 : size_6,
                        color: veryDarkGrey,
                        fontFamily: 'montserrat'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<PopUpMenuForEmployee> showEachItemFromList(
          PopUpMenuForEmployee item) =>
      PopupMenuItem<PopUpMenuForEmployee>(
          value: item,
          child: Row(
            children: [
              Image(
                image: AssetImage(item.iconImage),
                height: size_6 + 1,
                width: size_6 + 1,
              ),
              SizedBox(
                width: space_1 + 2,
              ),
              Text(
                item.itemText,
                style: TextStyle(
                  fontWeight: mediumBoldWeight,
                ),
              ),
            ],
          ));

  void onSelected(BuildContext context, PopUpMenuForEmployee item) {
    switch (item) {
      case MenuItemsForEmployee.itemEdit:
        updateUser(context);
        break;
      case MenuItemsForEmployee.itemRemove:
        removeUser(context);
        break;
    }
  }

  updateUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UpdateEmployeeRole(employeeUid: companyUsersModel.uid);
        });
  }

  removeUser(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RemoveEmployee(employeeUid: companyUsersModel.uid);
        });
  }
}
