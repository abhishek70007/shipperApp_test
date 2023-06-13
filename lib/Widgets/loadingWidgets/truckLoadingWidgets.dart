import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import 'package:shimmer/shimmer.dart';

class TruckLoadingWidgets extends StatelessWidget {
  const TruckLoadingWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          widget(),
          SizedBox(
            height: space_2,
          ),
          widget(),
          SizedBox(
            height: space_2,
          ),
          widget(),
        ],
      ),
    );
  }

  Card widget() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(space_2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              highlightColor: greyishWhiteColor,
              baseColor: lightGrey,
              child: Container(
                width: space_20,
                height: space_3,
                color: lightGrey,
              ),
            ),
            SizedBox(
              height: space_2,
            ),
            Shimmer.fromColors(
              highlightColor: greyishWhiteColor,
              baseColor: lightGrey,
              child: Container(
                width: space_20,
                height: space_3,
                color: lightGrey,
              ),
            ),
            SizedBox(
              height: space_4,
            ),
            Shimmer.fromColors(
              highlightColor: greyishWhiteColor,
              baseColor: lightGrey,
              child: Container(
                width: space_40,
                height: space_15,
                color: lightGrey,
              ),
            ),
            SizedBox(
              height: space_2,
            ),
            Padding(
              padding: EdgeInsets.only(left: space_1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Shimmer.fromColors(
                    highlightColor: greyishWhiteColor,
                    baseColor: lightGrey,
                    child: Container(
                      width: space_16,
                      height: space_6,
                      color: lightGrey,
                    ),
                  ),
                  SizedBox(
                    width: space_2,
                  ),
                  Shimmer.fromColors(
                    highlightColor: greyishWhiteColor,
                    baseColor: lightGrey,
                    child: Container(
                      width: space_16,
                      height: space_6,
                      color: lightGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
