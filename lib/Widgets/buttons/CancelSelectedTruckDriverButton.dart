import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';


class CancelSelectedTruckDriverButton extends StatefulWidget {

  List? truckModelList ;
  List? driverModelList;

  CancelSelectedTruckDriverButton({
    this.driverModelList,
    this.truckModelList,
});

  @override
  _CancelSelectedTruckDriverButtonState createState() => _CancelSelectedTruckDriverButtonState();
}

class _CancelSelectedTruckDriverButtonState extends State<CancelSelectedTruckDriverButton> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        //if instead of using cancel button user uses mobile button this fails
        widget.driverModelList!.removeLast();
        widget.truckModelList!.removeLast();
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.only(right: space_3),
        height: space_6 + 1,
        width: space_16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: darkBlueColor)),
        child: Center(
          child: Text(
            "Cancel",
            style: TextStyle(
                color: Colors.black,
                fontWeight: normalWeight,
                fontSize: size_6 + 2),
          ),
        ),
      ),
    );
  }
}
