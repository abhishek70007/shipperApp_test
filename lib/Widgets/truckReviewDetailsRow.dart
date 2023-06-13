import 'package:flutter/material.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class TruckReviewDetailsRow extends StatelessWidget {
  final String label;
  final dynamic value;

  TruckReviewDetailsRow({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$label',
                style: TextStyle(
                  fontSize: size_7,
                ),
              ),
              Text(
                value == 0 || value == '' ? '---' : '$value',
                style: TextStyle(
                  fontSize: size_7,
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: space_1),
              child: Divider(
                thickness: 2,
              )),
        ],
      ),
    );
  }
}
