import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/constants/fontWeights.dart';
import '/widgets/LoadPerTonne.dart';

import 'FromLoadPrefix.dart';
import 'LoadParameter.dart';
import 'LoadParameterValue.dart';
import 'ToLoadPrefix.dart';
import 'TruckView.dart';
import 'buttons/ViewBidButton.dart';
import 'linePainter.dart';

// ignore: must_be_immutable
class LoadCard extends StatelessWidget {
  String? truckType;
  String? productType;
  int? weight;
  int? tyres;
  String? loadFrom;
  String? loadTo;
  int? load;

  LoadCard(
      {this.truckType,
      this.productType,
      this.weight,
      this.tyres,
      this.loadFrom,
      this.load,
      this.loadTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 243,
      color: const Color(0xffF7F8FA),
      margin: EdgeInsets.only(bottom: space_2),
      child: Card(
        elevation: size_4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(space_3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const FromLoadPrefix(),
                      Text(
                        loadFrom!,
                        style: TextStyle(
                            fontSize: size_9, fontWeight: mediumBoldWeight),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: size_1),
                    child: Container(
                      child: CustomPaint(
                        size: Size(space_0, size_13),
                        foregroundPainter: LinePainter(),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const ToLoadPrefix(),
                      Text(
                        loadTo!,
                        style: TextStyle(
                            fontSize: size_9, fontWeight: mediumBoldWeight),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                LoadParameter(
                                  para: 'TruckType',
                                ),
                                LoadParameterValue(paraValue: truckType!),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 48),
                              child: Column(
                                children: [
                                  LoadParameter(
                                    para: 'Tyre',
                                  ),
                                  LoadParameterValue(
                                      paraValue: tyres.toString()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                LoadParameter(
                                  para: 'Weight',
                                ),
                                LoadParameterValue(
                                    paraValue: weight!.toString()),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: space_6),
                              child: Column(
                                children: [
                                  LoadParameter(
                                    para: 'ProductType',
                                  ),
                                  LoadParameterValue(paraValue: productType!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: size_7),
                      child: LoadPerTonne(
                        load: load!,
                      ))
                  //track and call button
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: space_7,
                  ),
                  child: const TruckView(),
                ),
                ViewBidButton(
                  loadFrom: loadFrom,
                  loadTo: loadTo,
                  load: load,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
