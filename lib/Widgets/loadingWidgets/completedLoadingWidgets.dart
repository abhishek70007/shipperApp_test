import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import 'package:shimmer/shimmer.dart';

class CompletedLoadingWidgets extends StatefulWidget {
  const CompletedLoadingWidgets({Key? key}) : super(key: key);

  @override
  _CompletedLoadingWidgetsState createState() =>
      _CompletedLoadingWidgetsState();
}

class _CompletedLoadingWidgetsState extends State<CompletedLoadingWidgets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        completedLoadingCard(),
        SizedBox(
          height: space_2,
        ),
        completedLoadingCard(),
      ],
    );
  }

  Card completedLoadingCard() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(space_2),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: space_34),
              child: Shimmer.fromColors(
                highlightColor: greyishWhiteColor,
                baseColor: lightGrey,
                child: Container(
                  height: space_3,
                  color: lightGrey,
                ),
              ),
            ),
            SizedBox(
              height: space_2,
            ),
            Padding(
              padding: EdgeInsets.only(right: space_28),
              child: Shimmer.fromColors(
                highlightColor: greyishWhiteColor,
                baseColor: lightGrey,
                child: Container(
                  height: space_10,
                  color: lightGrey,
                ),
              ),
            ),
            SizedBox(
              height: space_4,
            ),
            Padding(
              padding: EdgeInsets.only(right: space_14),
              child: Shimmer.fromColors(
                highlightColor: greyishWhiteColor,
                baseColor: lightGrey,
                child: Container(
                  height: space_7,
                  color: lightGrey,
                ),
              ),
            ),
            SizedBox(
              height: space_5,
            ),
            Padding(
              padding: EdgeInsets.only(right: space_34),
              child: Shimmer.fromColors(
                highlightColor: greyishWhiteColor,
                baseColor: lightGrey,
                child: Container(
                  height: space_3,
                  color: lightGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
