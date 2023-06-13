import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import 'package:shimmer/shimmer.dart';

class DriverLoadingWidgets extends StatelessWidget {
  const DriverLoadingWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          SizedBox(
            height: space_2,
          ),
          widget(),
          SizedBox(
            height: space_2,
          ),
          widget(),
          SizedBox(
            height: space_2,
          ),
          widget(),
          SizedBox(
            height: space_2,
          ),
          widget(),
          SizedBox(
            height: space_2,
          ),
        ],
      ),
    );
  }

  Card widget() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(space_2),
        child: Shimmer.fromColors(
          highlightColor: greyishWhiteColor,
          baseColor: lightGrey,
          child: Container(
            width: (space_30 + space_40),
            height: space_12,
            color: lightGrey,
          ),
        ),
      ),
    );
  }
}
