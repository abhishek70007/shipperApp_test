import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shipper_app/functions/get_role_of_employee.dart';
import '/constants/colors.dart';
import '/controller/navigationIndexController.dart';
import '/controller/shipperIdController.dart';
import '/functions/AppVersionCheck.dart';
import '/functions/loadApis/findLoadByLoadID.dart';
import '/models/loadDetailsScreenModel.dart';
import '../functions/shipperApis/isolatedShipperGetData.dart';
import '/screens/postLoadScreens/postLoadScreen.dart';
import '/widgets/accountVerification/accountPageUtil.dart';
import '/providerClass/providerData.dart';
import '/screens/home.dart';
import '/widgets/bottomNavigationIconWidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationScreen extends StatefulWidget {
  var initScreen;

  NavigationScreen({this.initScreen});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<LoadDetailsScreenModel> data = [];
  String? loadID;
  LoadDetailsScreenModel loadDetailsScreenModel = LoadDetailsScreenModel();
  var totalDistance;
  var currentDate = DateTime.now();
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  late String from;
  late String to;
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  ShipperIdController sIdController = Get.put(ShipperIdController());
  NavigationIndexController navigationIndex =
      Get.put(NavigationIndexController(), permanent: true);
  var screens = [
    HomeScreen(),
    PostLoadScreen(),
    AccountPageUtil(),
  ];

  @override
  void initState() {
    if (widget.initScreen != null) {
      navigationIndex.updateIndex(widget.initScreen);
    }
    from = yesterday.toIso8601String();
    to = now.toIso8601String();
    super.initState();
    this.initDynamicLinks();
    this.checkUpdate();
    getRoleOfEmployee(FirebaseAuth.instance.currentUser!.uid);
    isolatedShipperGetData();
  }



  void checkUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = (prefs.getBool('isFirstTime') ?? true);
    try {
      if (isFirstTime == true) {
        await prefs.setBool('isFirstTime', false);
        versionCheck(context);
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleDynamicLink(PendingDynamicLinkData? dataLink) async {
    final Uri? deepLink = dataLink?.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('deviceId')) {
        EasyLoading.instance
          ..indicatorType = EasyLoadingIndicatorType.ring
          ..indicatorSize = 45.0
          ..radius = 10.0
          ..maskColor = darkBlueColor
          ..userInteractions = false
          ..backgroundColor = darkBlueColor
          ..dismissOnTap = false;
        EasyLoading.show(
          status: "Loading...",
        );
        int deviceId = int.parse(deepLink.queryParameters['deviceId']!);

        var expiryDuration =
            DateTime.parse(deepLink.queryParameters['duration']!);
        var durationDiff = expiryDuration.difference(currentDate).inMinutes;
      } else {
        loadID = deepLink.path;
        findLoadByLoadID(loadID!);
      }
    }
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;

    final PendingDynamicLinkData? dataLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDynamicLink(dataLink);
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    return Scaffold(
        backgroundColor: statusBarColor,
        // color of status bar which displays time on a phone
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              onTap: (int pressedIndex) {
                providerData.updateUpperNavigatorIndex(0);
                navigationIndex.updateIndex(pressedIndex);
              },
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              unselectedItemColor: grey,
              selectedItemColor: grey,
              selectedLabelStyle: TextStyle(color: flagGreen),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "homeIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeHomeIcon.png",
                  ),
                  label: ('home'.tr
                      // AppLocalizations.of(context)!.home
                      ),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "postLoadIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activePostLoadIcon.png",
                  ),
                  label: ('my_loads'.tr
                      // AppLocalizations.of(context)!.my_loads
                      ),
                ),
                BottomNavigationBarItem(
                  icon: BottomNavigationIconWidget(
                    iconPath: "accountIcon.png",
                  ),
                  activeIcon: BottomNavigationIconWidget(
                    iconPath: "activeAccountIcon.png",
                  ),
                  label: ('account'.tr
                      // AppLocalizations.of(context)!.account
                      ),
                ),
              ],
              currentIndex: navigationIndex.index.value,
            )),
        body: Obx(
          () => SafeArea(
            child:
                Center(child: screens.elementAt(navigationIndex.index.value)),
          ),
        ));
  }
}
