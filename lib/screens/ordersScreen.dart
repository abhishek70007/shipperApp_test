import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/widgets/Header.dart';
import '/widgets/OrderScreenNavigationBarButton.dart';
import '/screens/TransporterOrders/biddingScreenTransporterSide.dart';
import 'package:provider/provider.dart';
import 'TransporterOrders/deliveredScreenOrders.dart';
import 'TransporterOrders/onGoingScreenOrders.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    PageController pageController =
        PageController(initialPage: providerData.upperNavigatorIndex);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_2),
          child: Column(
            children: [
              Header(
                reset: false,
                text: 'order'.tr,
                // AppLocalizations.of(context)!.order,
                backButton: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderScreenNavigationBarButton(
                    text: 'bids'.tr,
                    // AppLocalizations.of(context)!.bids,
                    value: 0,
                    pageController: pageController,
                  ),
                  OrderScreenNavigationBarButton(
                    text: 'on_going'.tr,
                    // AppLocalizations.of(context)!.on_going,
                    value: 1,
                    pageController: pageController,
                  ),
                  OrderScreenNavigationBarButton(
                    text: 'completed'.tr,
                    // AppLocalizations.of(context)!.completed,
                    value: 2,
                    pageController: pageController,
                  )
                ],
              ),
              Divider(
                color: textLightColor,
                thickness: 1,
              ),
              Stack(
                children: [
                  Container(
                    height: 600,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          providerData.updateUpperNavigatorIndex(value);
                        });
                      },
                      children: [
                        BiddingScreenTransporterSide(),
                        OngoingScreenOrders(),
                        DeliveredScreenOrders(),
                      ],
                    ),
                  ),

                  // Positioned(
                  //   top: 50,
                  //   child: Align(
                  //       alignment: Alignment.center,
                  //       child: PostButtonLoad()
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
