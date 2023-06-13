import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import 'linePainter.dart';

// ignore: must_be_immutable
class LocationDetailsLoadDetails extends StatelessWidget {
  Map loadDetails;

  LocationDetailsLoadDetails({required this.loadDetails});

  @override
  Widget build(BuildContext context) {
    print(loadDetails["loadingPoint2"]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: space_3),
          child: Text(
            "postedon".tr +" : ${loadDetails['loadDate']}",
            style: TextStyle(
                fontWeight: regularWeight,
                fontSize: size_6,
                color: veryDarkGrey),
          ),
        ),
        Text(
          'loadDetails'.tr,
          // AppLocalizations.of(context)!.loadDetails,
          style: TextStyle(fontWeight: mediumBoldWeight, fontSize: size_7),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: space_3),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: space_1),
                      child: Image(
                        image: AssetImage(
                            "assets/icons/greenFilledCircleIcon.png"),
                      ),
                      width: space_2,
                      height: space_2,
                    ),
                    Expanded(
                      child: Text(
                        "${loadDetails['loadingPoint']}, ${loadDetails['loadingPointCity'.tr]}, ${loadDetails['loadingPointState'.tr]}",
                        style: TextStyle(
                            fontWeight: normalWeight, fontSize: size_6),
                      ),
                    )
                  ],
                ),
              ),
              loadDetails['loadingPoint2']!='NA'?
                  Container(
                margin: EdgeInsets.only(top: space_3),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: space_1),
                      child: Image(
                        image: AssetImage(
                            "assets/icons/greenFilledCircleIcon.png"),
                      ),
                      width: space_2,
                      height: space_2,
                    ),
                    Expanded(
                      child: Text(
                        "${loadDetails['loadingPoint2']}, ${loadDetails['loadingPointCity2'.tr]}, ${loadDetails['loadingPointState2'.tr]}",
                        style: TextStyle(
                            fontWeight: normalWeight, fontSize: size_6),
                      ),
                    )
                  ],
                ),
              ):Container(),
              Container(
                height: space_5,
                padding: EdgeInsets.only(left: space_1 - 3),
                child: CustomPaint(
                  foregroundPainter: LinePainter(height: space_5, width: 1),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: space_1),
                    child: Image(
                      image: AssetImage(
                          "assets/icons/redSemiFilledCircleIcon.png"),
                    ),
                    width: space_2,
                    height: space_2,
                  ),
                  Expanded(
                    child: Text(
                      "${loadDetails['unloadingPoint'.tr]}, ${loadDetails['unloadingPointCity'.tr]}, ${loadDetails['unloadingPointState'.tr]}",
                      style:
                          TextStyle(fontWeight: normalWeight, fontSize: size_6),
                    ),
                  )
                ],
              ),
              loadDetails['unloadingPoint2']!='NA'
                  ?Container(
                margin: EdgeInsets.only(top: space_3),
                    child: Row(
                children: [
                    Container(
                      margin: EdgeInsets.only(right: space_1),
                      child: Image(
                        image: AssetImage(
                            "assets/icons/redSemiFilledCircleIcon.png"),
                      ),
                      width: space_2,
                      height: space_2,
                    ),
                    Expanded(
                      child: Text(
                        "${loadDetails['unloadingPoint2']}, ${loadDetails['unloadingPointCity2'.tr]}, ${loadDetails['unloadingPointState2'.tr]}",
                        style:
                        TextStyle(fontWeight: normalWeight, fontSize: size_6),
                      ),
                    )
                ],
              ),
                  ):Container()
            ],
          ),
        ),
      ],
    );
  }
}
