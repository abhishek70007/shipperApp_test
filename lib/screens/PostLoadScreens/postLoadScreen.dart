import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/controller/postLoadVariablesController.dart';
import '/providerClass/providerData.dart';
import '/screens/myLoadPages/deliveredScreen.dart';
import '/screens/myLoadPages/myLoadsScreen.dart';
import '/screens/myLoadPages/onGoingScreen.dart';
import '/widgets/Header.dart';
import '/widgets/OrderScreenNavigationBarButton.dart';
import '/widgets/buttons/postLoadButton.dart';
import 'package:provider/provider.dart';

class PostLoadScreen extends StatefulWidget {
  const PostLoadScreen({super.key});

  @override
  _PostLoadScreenState createState() => _PostLoadScreenState();
}

class _PostLoadScreenState extends State<PostLoadScreen> {
  //Page Controller
  PageController pageController = PageController(initialPage: 0);
  PostLoadVariablesController postLoadVariables =
      Get.put(PostLoadVariablesController());
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: PostButtonLoad(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, space_2),
          child: Column(
            children: [
              Header(
                  reset: false,
                  text: 'loads'.tr,
                  // AppLocalizations.of(context)!.loads,
                  backButton: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OrderScreenNavigationBarButton(
                      text: 'my_loads'.tr,
                      // AppLocalizations.of(context)!.my_loads,
                      value: 0,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: 'on_going'.tr,
                      // AppLocalizations.of(context)!.on_going,
                      value: 1,
                      pageController: pageController),
                  OrderScreenNavigationBarButton(
                      text: 'completed'.tr,
                      // AppLocalizations.of(context)!.completed,
                      value: 2,
                      pageController: pageController)
                ],
              ),
              Divider(
                color: textLightColor,
                thickness: 1,
              ),
              Stack(
                // alignment: Alignment.center,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        setState(() {
                          providerData.updateUpperNavigatorIndex(value);
                        });
                      },
                      children: [
                        MyLoadsScreen(),
                        OngoingScreen(),
                        DeliveredScreen(),
                      ],
                    ),
                  ),
                  // Positioned.fill(
                  //   top: 550,
                  //   child: Align(
                  //       alignment: Alignment.center, child: PostButtonLoad()),
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
