import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';

class TruckView extends StatelessWidget {
  const TruckView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
          width: 130,
          height: 140,
        ),
        Positioned(
          left: space_4,
          child: Container(
            width: space_17,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size_4),
              color: truckGreen,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: space_1),
          child: const Image(
            image: AssetImage("assets/images/overviewtataultra.png"),
          ),
        )
      ],
    );
  }
}
