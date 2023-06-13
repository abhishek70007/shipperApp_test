import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/fontSize.dart';
import '/controller/trucksNearUserController.dart';
import '/widgets/buttons/okButton.dart';

import '../../constants/colors.dart';
import '../../constants/fontWeights.dart';
import '../../constants/radius.dart';
import '../../constants/spaces.dart';

class UserNearLocationSelection extends StatefulWidget {
  const UserNearLocationSelection({Key? key}) : super(key: key);

  @override
  State<UserNearLocationSelection> createState() =>
      _UserNearLocationSelectionState();
}

class _UserNearLocationSelectionState extends State<UserNearLocationSelection> {
  int selectedIndex = 0;
  List<int> lst = [1, 5, 10, 40000];
  List<String> lstS = ["1", "5", "10", "NONE"];

  TrucksNearUserController trucksNearUserController =
      Get.put(TrucksNearUserController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        left: space_4,
        right: space_4,
      ),
      title: Column(
        children: [
          Image(
              height: space_9 + 2,
              width: space_11,
              image: AssetImage("assets/icons/errorIcon.png")),
          SizedBox(
            height: space_5,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            'alertLine1'.tr,
            // "You can use this feature",
            style: TextStyle(
              fontWeight: mediumBoldWeight,
              fontSize: size_9,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            'alertLine2'.tr,
            // "in next update",
            style: TextStyle(fontWeight: mediumBoldWeight, fontSize: size_9),
          ),
          SizedBox(
            height: space_6 - 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              customExpiryButton(lstS[0], 0),
              customExpiryButton(lstS[1], 1),
              customExpiryButton(lstS[2], 2),
              customExpiryButton(lstS[3], 3),
            ],
          ),
          SizedBox(
            height: space_8,
          ),
          GestureDetector(
            onTap: () {
              if (selectedIndex == 3) {
                trucksNearUserController.updateNearStatusData(true);
                print(
                    "THE PAGE VALUE IS NOW ${trucksNearUserController.nearStatus}");
              }
              Navigator.of(context).pop();
            },
            child: Container(
              margin: EdgeInsets.only(right: space_3),
              height: space_8,
              width: (space_16 * 3) - 8,
              decoration: BoxDecoration(
                  color: darkBlueColor,
                  borderRadius: BorderRadius.circular(radius_6),
                  boxShadow: [
                    BoxShadow(color: darkGreyColor, offset: Offset(2.0, 2.0))
                  ]),
              child: Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: white,
                      fontWeight: mediumBoldWeight,
                      fontSize: size_8),
                ),
              ),
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
    );
  }

  Widget customExpiryButton(String txt, int index) {
    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(space_10),
    //   child:
    return OutlinedButton(
        onPressed: () => {
              changeIndex(index),
              setState(() {
                trucksNearUserController
                    .updateDistanceRadiusData(lst[selectedIndex]);
                trucksNearUserController.updateNearStatusData(false);
              })
            },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                        color:
                            selectedIndex == index ? white : darkBlueColor))),
            backgroundColor: MaterialStateProperty.all<Color>(
                selectedIndex == index ? darkBlueColor : white)),
        child: Text(txt,
            style: TextStyle(
                color: selectedIndex == index ? white : darkBlueColor)));
    //);
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
