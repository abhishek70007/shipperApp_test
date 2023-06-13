import 'package:flutter/material.dart';
import 'package:shipper_app/responsive.dart';
import 'package:shipper_app/widgets/buttons/postLoadButton.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../controller/shipperIdController.dart';

class WebDashBoard extends StatefulWidget {
  const WebDashBoard({Key? key}) : super(key: key);

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard> {
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PostButtonLoad(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, bottom: 3.h, left: 3.w),
            child: Text(
              'Dashboard',
              style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: Responsive.isDesktop(context)
                ? const EdgeInsets.all(20.0)
                : const EdgeInsets.all(5),
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: const [
                    BoxShadow(blurRadius: 5),
                  ]),
              height: Responsive.isDesktop(context) ? 62.h : 55.h,
              padding: Responsive.isDesktop(context)
                  ? const EdgeInsets.all(40.0)
                  : const EdgeInsets.all(10),
              child: const Image(
                image: AssetImage('assets/images/EmptyBox.jpeg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
