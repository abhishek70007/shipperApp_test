import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shipper_app/constants/colors.dart';
import 'package:shipper_app/constants/spaces.dart';
import 'package:shipper_app/controller/shipperIdController.dart';
import 'package:shipper_app/functions/documentApi/getDocument.dart';
import 'package:shipper_app/providerClass/drawerProviderClassData.dart';
import 'package:shipper_app/screens/findLoadScreen.dart';
import 'package:shipper_app/widgets/accountNotVerifiedWidget.dart';
import 'package:shipper_app/widgets/bonusWidget.dart';
import 'package:shipper_app/widgets/buttons/helpButton.dart';
import 'package:shipper_app/widgets/drawerWidget.dart';
import 'package:shipper_app/widgets/liveasyTitleTextWidget.dart';
import 'package:shipper_app/widgets/referAndEarnWidget.dart';
import 'package:shipper_app/widgets/searchLoadWidget.dart';
import 'package:provider/provider.dart';
import 'package:shipper_app/widgets/buttons/postLoadButton.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ShipperIdController shipperIdController = kIsWeb?Get.put(ShipperIdController()):Get.find<ShipperIdController>();
  var imageLinks;
  bool isSwitched = false;

  final switchData = GetStorage();

  @override
  void initState() {
    super.initState();
    imageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: PostButtonLoad(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          drawer: DrawerWidget(
            mobileNum: shipperIdController.mobileNum.value,
            userName: shipperIdController.name.toString(),
            imageUrl: imageLinks.toString(),
            // imageUrl: response['documentLink'],
            // and pass image url here, if required.
          ),
          backgroundColor: backgroundColor,
          body: Container(
            height: MediaQuery.of(context).size.height -
                kBottomNavigationBarHeight -
                space_4 -
                space_2, //space_4 and space_2 comes from padding given below
            padding: EdgeInsets.fromLTRB(0, space_4, 0, space_2),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: space_4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              imageUrl();
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            icon: Icon(
                              Icons.list,
                              size: space_6,
                            ),
                          ),
                          SizedBox(
                            width: space_2,
                          ),
                          LiveasyTitleTextWidget(),
                        ],
                      ),
                      HelpButtonWidget()
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.fromLTRB(space_4, space_4, space_4, space_5),
                  child: SearchLoadWidget(
                    hintText: 'search'.tr,
                    // AppLocalizations.of(context)!.search,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Get.to(() => FindLoadScreen());
                    },
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: ScrollController(initialScrollOffset: 0),
                    children: [
                      SizedBox(
                        width: space_4,
                      ),
                      ReferAndEarnWidget(),
                      SizedBox(
                        width: space_4,
                      ),
                      BonusWidget(),
                      SizedBox(
                        width: space_4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: space_1,
                ),
                !(shipperIdController.companyStatus.value == 'verified')
                    ? const AccountNotVerifiedWidget()
                    : SizedBox(
                        height: space_2,
                      ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: space_4),
                //   child: const SuggestedLoadWidgetHeader(),
                // ),
                // SizedBox(
                //   height: space_2,
                // ),
                // Expanded(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: space_4),
                //     child: SuggestedLoadsWidget(),
                //   ),
                // ),

                Container(
                  margin: EdgeInsets.only(
                    top: space_6,
                    left: space_7,
                    right: space_7,
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/EmptyBox.jpeg'),
                  ),

                ),
                // Container(
                //     alignment: Alignment.bottomCenter,
                //   margin: const EdgeInsets.only(bottom: 25),
                //     child: PostButtonLoad()),
                // Expanded(
                //   // alignment: Alignment.bottomCenter,
                //   child: Container(
                //       alignment: Alignment.bottomCenter,
                //       margin: const EdgeInsets.only(bottom: 25),
                //       child: PostButtonLoad()),
                //)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> imageUrl() async {
    imageLinks = await getDocumentWithTransportId(
        shipperIdController.shipperId.toString());
    setState(() {});
  }
}
