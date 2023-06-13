import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/backButtonWidget.dart';
import '/widgets/headingTextWidget.dart';
import 'package:shimmer/shimmer.dart';

class LoadDetailsLoadingWidget extends StatelessWidget {
  const LoadDetailsLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: space_2),
      child: Column(
        children: [
          SizedBox(
            height: space_4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackButtonWidget(),
              SizedBox(
                width: space_3,
              ),
              HeadingTextWidget("Load Details"),
              // HelpButtonWidget(),
            ],
          ),
          SizedBox(
            height: space_3,
          ),
          onGoingLoadingCard(),
          SizedBox(
            height: space_2,
          ),
          onGoingLoadingCard(),
        ],
      ),
    );
  }

  Card onGoingLoadingCard() {
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
                  height: space_9,
                  color: lightGrey,
                ),
              ),
            ),
            SizedBox(
              height: space_4,
            ),
            Padding(
              padding: EdgeInsets.only(right: space_4),
              child: Shimmer.fromColors(
                highlightColor: greyishWhiteColor,
                baseColor: lightGrey,
                child: Container(
                  height: space_14,
                  color: lightGrey,
                ),
              ),
            ),
            SizedBox(
              height: space_5,
            ),
            Padding(
              padding: EdgeInsets.only(right: space_1, left: space_1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Shimmer.fromColors(
                    highlightColor: greyishWhiteColor,
                    baseColor: lightGrey,
                    child: Container(
                      width: space_14,
                      height: space_6,
                      color: lightGrey,
                    ),
                  ),
                  Shimmer.fromColors(
                    highlightColor: greyishWhiteColor,
                    baseColor: lightGrey,
                    child: Container(
                      width: space_25,
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
