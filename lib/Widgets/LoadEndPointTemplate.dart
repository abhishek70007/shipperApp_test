import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/responsive.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

class LoadEndPointTemplate extends StatelessWidget {
  final String? endPointType;
  String? text;

  LoadEndPointTemplate({required this.text, required this.endPointType});

  @override
  Widget build(BuildContext context) {
    if (text!.length > 20) {
      text = '${text!.substring(0, 19)}..';
    }
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: space_1),
          child: Image(
              height: 10,
              width: 10,
              image: endPointType == 'loading'
                  ? const AssetImage('assets/icons/greenFilledCircleIcon.png')
                  : const AssetImage('assets/icons/redSemiFilledCircleIcon.png')),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !Responsive.isMobile(context)
                ? Text(
                    endPointType == 'loading'
                        ? "Loading Point"
                        : "Unloading Point",
                    style: TextStyle(
                        
                        fontSize: size_6 + 1,
                        color: const Color(0xFF7B7B7B)),
                  )
                : const SizedBox(
                    height: 0.1,
                  ),
            Text(
              '$text'.tr,
              style: TextStyle(
                color: liveasyBlackColor,
                fontWeight: mediumBoldWeight,
                fontSize: !Responsive.isMobile(context) ? size_10 : size_9,
              ),
            ),
          ],
        )
      ],
    );
  }
}
