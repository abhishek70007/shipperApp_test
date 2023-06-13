import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/functions/shipperApis/runShipperApiPost.dart';
import '/language/localization_service.dart';
import '/providerClass/providerData.dart';
import '/screens/navigationScreen.dart';
import '/widgets/buttons/getStartedButton.dart';
import '/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';
import 'package:provider/provider.dart';

import 'LoginScreens/loginScreenUsingPhone.dart';

class LanguageSelectionScreen extends StatefulWidget {
  LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> with AutomaticKeepAliveClientMixin<LanguageSelectionScreen>{
  String currentItem = 'English'; //added this
  String? shipperId;
  bool _nextScreen = false;
  ShipperIdController shipperIdController =
  Get.put(ShipperIdController(), permanent: true);
  @override
  void initState() {
    super.initState();
    getData();
    currentItem = LocalizationService().getCurrentLang();  //added this
  }
  Function? onTapNext(){
    Get.to(const bottomProgressBarIndicatorWidget());
    Get.off(() => NavigationScreen());
  }
  getData() async {
    bool? companyApproved;
    String? mobileNum;
    bool? accountVerificationInProgress;
    String? transporterLocation;
    String? name;
    String? companyName;
    String? companyStatus;

    //transporterId = await runTransporterApiPost(
      //mobileNum: FirebaseAuth
        //.instance.currentUser!.phoneNumber
        //.toString()
        //.substring(3, 13),
    //);

    if (shipperId != null){
      setState(() {
        _nextScreen=true;
      });
    }
    else {
      setState(() {
        shipperId = sidstorage.read("shipperId");
        companyApproved = sidstorage.read("companyApproved");
        mobileNum = sidstorage.read("mobileNum");
        accountVerificationInProgress = sidstorage.read("accountVerificationInProgress");
        transporterLocation = sidstorage.read("shipperLocation");
        name = sidstorage.read("name");
        companyName = sidstorage.read("companyName");
        companyStatus = sidstorage.read("companyStatus");
      });

      if (shipperId == null) {
        print("Shipper ID is null");
      } else {
        print("It is in else");
        shipperIdController.updateShipperId(shipperId!);
        shipperIdController.updateCompanyApproved(companyApproved!);
        shipperIdController.updateMobileNum(mobileNum!);
        shipperIdController
            .updateAccountVerificationInProgress(accountVerificationInProgress!);
        shipperIdController.updateShipperLocation(transporterLocation!);
        shipperIdController.updateName(name!);
        shipperIdController.updateCompanyName(companyName!);
        shipperIdController.updateCompanyStatus(companyStatus!);
        print("shipperID is $shipperId");
        setState(() {
        _nextScreen=true;
      });
      }
      //setState(() {
        //_nextScreen=true;
      //});
    }
  }

  @override
  Widget build(BuildContext context) {

    // final provider = Provider.of<ProviderData>(context);
    // final currentItem = provider.languageItem;
    // currentItem = LocalizationService().getCurrentLang();  //added this
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.only(left: space_4, right: space_4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius_5),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Padding(
                  padding:
                  EdgeInsets.fromLTRB(space_5, space_8, space_5, space_0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: space_5, right: space_5),
                        child: const Image(
                            image: AssetImage("assets/icons/welcomeIcon.png")),
                      ),
                      Text('welcome'.tr,  // changed this
                        // AppLocalizations.of(context)!.welcome,
                        style: TextStyle(
                            fontSize: size_11, fontWeight: boldWeight),
                      ),
                      SizedBox(
                        height: space_6,
                      ),
                      Text('selectLanguage'.tr, //changed this
                        // AppLocalizations.of(context)!.selectLanguage,
                        style: TextStyle(
                            fontSize: size_10, fontWeight: normalWeight),
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // selectLanguageItem(context, LanguageItem.English);
                                // provider.setLocale(Locale('en'));
                                //change here
                                setState(() {
                                  var locale = const Locale('en', 'US');
                                  Get.updateLocale(locale);
                                  currentItem = 'English';
                                  LocalizationService().changeLocale(currentItem);
                                });
                              },
                              child: Container(
                                height: space_8,
                                decoration: BoxDecoration(
                                    border: Border.all(width: 1,
                                        color:currentItem == 'English' ? navy : darkGreyColor //change here
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(radius_1)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "English",
                                      style: TextStyle(
                                          color: currentItem == 'English' ? navy : darkGreyColor, //change here
                                          fontSize: size_9,
                                          fontWeight: normalWeight),
                                    ),
                                    Container(
                                      child: currentItem == 'English' ? Image( //chenge here
                                        image: const AssetImage("assets/icons/tick.png"),
                                        width: space_3,
                                        height: space_3,
                                      ): Container(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: space_2,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                  // selectLanguageItem(context, LanguageItem.Hindi);
                                  // provider.setLocale(Locale('hi'));
                                //change here
                                setState(() {
                                  var locale = const Locale('hi', 'IN');
                                  Get.updateLocale(locale);
                                  currentItem = 'Hindi';
                                  LocalizationService().changeLocale(currentItem);
                                });
                              },
                              child: Container(
                                height: space_8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: currentItem == 'Hindi' ? navy : darkGreyColor    //change here
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(radius_1)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "हिन्दी",
                                      style: TextStyle(
                                          color: currentItem == 'Hindi' ? navy : darkGreyColor,   //change here
                                          fontSize: size_9,
                                          fontWeight: normalWeight),
                                    ),
                                Container(
                                  child: currentItem == 'Hindi' ? Image(   //change here
                                    image: const AssetImage("assets/icons/tick.png"),
                                    width: space_3,
                                    height: space_3,
                                  ): Container(),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      _nextScreen?
                      GetStartedButton(onTapNext: this.onTapNext,) : GetStartedButton(onTapNext: (){
                        Get.off(const LoginScreenUsingPhone());
                      },)

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectLanguageItem(BuildContext context, LanguageItem item) {
    final provider = Provider.of<ProviderData>(context, listen: false);
    provider.setLanguageItem(item);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
