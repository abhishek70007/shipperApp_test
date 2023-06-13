import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LiveasyIcon extends StatelessWidget {
  const LiveasyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Image(image: const AssetImage("assets/icons/logo.png"),width: 8.w,height: 8.h,),
        SizedBox(height: 1.h,),
        const Text(
          'Welcome to Liveasy!',
          style:TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              fontSize: 38),
        ),
        SizedBox(height: 5.h,),
      ],
    );
  }
}
