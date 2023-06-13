import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/elevation.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/models/loadDetailsScreenModel.dart';
import '/screens/loadDetailsScreen.dart';
import '/widgets/linePainter.dart';
import '/widgets/loadingPointImageIcon.dart';
import '/widgets/unloadingPointImageIcon.dart';

import 'alertDialog/verifyAccountNotifyAlertDialog.dart';
import 'alertDialog/verifyAccountNotifyAlertDialogWithCall.dart';

// ignore: must_be_immutable
class HomeScreenLoadsCard extends StatelessWidget {
  ShipperIdController sIdController = Get.put(ShipperIdController());

  final LoadDetailsScreenModel loadDetailsScreenModel;

  HomeScreenLoadsCard({
    required this.loadDetailsScreenModel,
  });

  @override
  Widget build(BuildContext context) {
    String rateLengthData = loadDetailsScreenModel.rate!.length > 5
        ? loadDetailsScreenModel.rate!.substring(0, 4) + ".."
        : loadDetailsScreenModel.rate!;
    // String tonne = AppLocalizations.of(context)!.tonne;
    String tonne = 'tonne'.tr;
    String tonnes = 'tonnes'.tr;
    String rateInTonnes =
        (rateLengthData[0] == 'N' ? "--" : "\u20B9$rateLengthData/$tonne");

    return GestureDetector(
        onTap: () => {
              if (sIdController.companyStatus.value == 'verified')
                {
                  Get.to(
                    () => LoadDetailsScreen(
                        loadDetailsScreenModel: loadDetailsScreenModel),
                  )
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          VerifyAccountNotifyAlertDialogWithCall())
                }
            },
        child: Card(
          elevation: elevation_2,
          child: Padding(
            padding: EdgeInsets.all(space_2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'postedon'.tr +
                      ' : ' +
                      '${loadDetailsScreenModel.loadDate}'.tr,
                  style: TextStyle(
                      fontSize: size_6,
                      color: veryDarkGrey,
                      fontFamily: 'montserrat'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        LoadingPointImageIcon(
                            width: space_2 - 1, height: space_2 - 1),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          loadDetailsScreenModel.loadingPointCity!.length > 20
                              ? "${loadDetailsScreenModel.loadingPointCity!.substring(0, 19)}..."
                                  .tr
                              : loadDetailsScreenModel.loadingPointCity!.tr,
                          style: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              fontSize: size_7),
                        ),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: solidLineColor,
                          borderRadius: BorderRadius.circular(radius_1 - 1),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: space_1, horizontal: 2),
                        height: space_5,
                        width: space_15 + 3,
                        child: Center(
                          child: Text(
                            "${loadDetailsScreenModel.weight} $tonnes",
                            // "${AppLocalizations.of(context)!.tonnes}",
                            style: TextStyle(
                                
                                color: bidBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: size_5),
                          ),
                        )),
                  ],
                ),
                Container(
                  height: space_2,
                  child: CustomPaint(
                    foregroundPainter: LinePainter(height: space_4, width: 2),
                  ),
                ),
                SizedBox(
                  height: space_1 + 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        UnloadingPointImageIcon(
                            width: space_2 - 1, height: space_2 - 1),
                        SizedBox(
                          width: space_1 + 1,
                        ),
                        Text(
                          loadDetailsScreenModel.unloadingPointCity!.length > 20
                              ? "${loadDetailsScreenModel.unloadingPointCity!.substring(0, 19)}..."
                                  .tr
                              : loadDetailsScreenModel.unloadingPointCity!.tr,
                          style: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              fontSize: size_7),
                        ),
                      ],
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: solidLineColor,
                          borderRadius: BorderRadius.circular(radius_1 - 1),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: space_1, horizontal: 2),
                        height: space_5,
                        width: space_15 + 3,
                        child: Center(
                          child: Text(
                            rateInTonnes,
                            style: TextStyle(
                                
                                color: bidBackground,
                                fontWeight: FontWeight.bold,
                                fontSize: size_5),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
