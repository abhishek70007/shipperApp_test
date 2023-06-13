import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import 'package:marquee/marquee.dart';

class LoadConfirmationTemplate extends StatelessWidget {
  final String? label;
  final String? value;
  LoadConfirmationTemplate({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: space_3),
      child: Container(
        margin: EdgeInsets.only(top: space_1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label',
                  style: TextStyle(fontWeight: normalWeight),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        label == 'Location'
                            ? Row(
                                children: [
                                  const Text(":  "),
                                  SizedBox(
                                    height: 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Marquee(
                                      text: value!,
                                      style: TextStyle(
                                          fontWeight: mediumBoldWeight,
                                          color: veryDarkGrey,
                                          fontSize: size_6
                                      ),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 20.0,
                                      velocity: 100.0,
                                      pauseAfterRound: const Duration(seconds: 1),
                                      accelerationDuration:
                                          const Duration(milliseconds: 10),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          const Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    ),
                                  )
                                ],
                              )
                            : Expanded(
                              child: Text(
                                  ":  ${value!}",
                                  style: TextStyle(
                                      fontWeight: mediumBoldWeight,
                                      color: veryDarkGrey,
                                      fontSize: size_6),
                                ),
                            ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: space_2,
            ),
            const Divider(
              color: grey,
            )
          ],
        ),
      ),
    );
  }
}
