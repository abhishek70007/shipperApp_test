import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

import 'buttons/addRectangularButtonProductType.dart';

class PostLoadScreenTwoSearch extends StatelessWidget {
  String hintText;
  PostLoadScreenTwoSearch({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    List<String> productTypeList = [
      "Agriculture And Food",
      "Electronic Goods/Battery",
      "Alcoholic Beverages",
      "Packaged/Consumer Boxs",
      "Auto Parts/machine",
      "Paints/Petroleum",
      "Chemical/Powder",
      "Scrap",
      "Construction Material",
      "Tyre",
      "Cylinders",
      "Putty",
      "DOC",
      "Oil",
      "Taar",
      "Others"
    ];
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                width: kIsWeb ? 500 : MediaQuery.of(context).size.width,
                height: 530,
                child: kIsWeb ? ListView.builder(
                  itemCount: productTypeList.length,
                  itemBuilder: (context, index) {
                      return  addRectangularButtonProductType(
                        text: productTypeList[index].tr,
                        value: productTypeList[index],
                      );
                    },
                ) :
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: size_1,
                  crossAxisSpacing: space_10,
                  mainAxisSpacing: space_2,
                  crossAxisCount: 2,
                  children: productTypeList
                      .map((e) {
                    return addRectangularButtonProductType(value: e, text: e.tr);
                      },)
                      .toList(),
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(space_4, space_0, space_4, space_0),
        child: Container(
          height: space_8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(space_6),
            border: Border.all(color: darkBlueColor, width: borderWidth_8),
            color: widgetBackGroundColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: space_2),
          child: Row(children: [
            Text(providerData.productType),
          ]),
        ),
      ),
    );
  }
}
