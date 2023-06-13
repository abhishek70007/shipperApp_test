import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoadDetails.dart';
import 'package:provider/provider.dart';

import '../addTruckCircularButtonTemplate.dart';

class OkButtonProductType extends StatefulWidget {
  String category;

  OkButtonProductType({Key? key, required this.category}) : super(key: key);

  @override
  State<OkButtonProductType> createState() => _OkButtonProductTypeState();
}

class _OkButtonProductTypeState extends State<OkButtonProductType> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    // print("hiiiii ${controllerOthers.text}");
    return Container(
      width: space_16,
      height: space_6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(space_10),
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: activeButtonColor),
          onPressed: () {
            if (controllerOthers.text.length > 0) {
              //int data = int.parse(controllerOthers.text);
              switch (widget.category) {
                // case 'weight':
                //   providerData.updatePassingWeightValue(
                //       controllerOthers.text == ""
                //           ? "Choose Product Weight"
                //           : data);
                //   print(data);
                //   //weightList.remove(0);
                //   if (!truckFilterVariables
                //       .passingWeightList[providerData.truckTypeValue]!
                //       .contains(data)) {
                //     truckFilterVariables
                //         .passingWeightList[providerData.truckTypeValue]!
                //         .insert(
                //             truckFilterVariables
                //                     .passingWeightList[
                //                         providerData.truckTypeValue]!
                //                     .length -
                //                 1,
                //             data);
                //   }
                //   break;
                // case 'tyres':
                //   providerData.updateTotalTyresValue(controllerOthers.text == ""
                //       ? "Choose Product Tyres"
                //       : data);
                //   // weightList.remove(0);
                //   // numberOfTyresList.add(data);
                //   if (!numberOfTyresList.contains(data)) {
                //     numberOfTyresList.insert(
                //         numberOfTyresList.length - 1, data);
                //   }
                //   break;
                // case 'length':
                //   providerData.updateTruckLengthValue(
                //       controllerOthers.text == ""
                //           ? "Choose Product Length"
                //           : data);
                //   break;
                case 'Type':
                  providerData.updateProductType(controllerOthers.text == ""
                      ? "Choose Product Type"
                      : controllerOthers.text);
                  break;
                // case 'Number':
                //   providerData.updateTruckNumber(data);
                //   break;
                default:
                  print("something went wrong in ok button");
                  break;
              }
              controllerOthers.clear();
              Get.back();
            } else {
              Get.back();
              Get.defaultDialog(
                  title: "Enter Product ${widget.category}",
                  middleText:
                      "please enter Product ${widget.category} to continue");
            }
          },
          child: Text(
            'ok'.tr,
            style: TextStyle(
              fontSize: size_6,
            ),
          ),
        ),
      ),
    );
  }
}
