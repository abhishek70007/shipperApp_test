import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import '/controller/navigationIndexController.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';
import '/screens/findLoadScreen.dart';
import '/screens/navigationScreen.dart';

class HelpCardWidget extends StatefulWidget {
  HelpCardWidget({Key? key, required this.title, required this.index})
      : super(key: key);
  final String title;
  final int index;

  @override
  _HelpCardWidgetState createState() => _HelpCardWidgetState();
}

class _HelpCardWidgetState extends State<HelpCardWidget> {
  // responsible for toggle
  bool _showData = false;
  List<String> answers = [
   // 'To add truck : \n1. Click on my trucks. \n2. Click on add truck button. \n3. Fill the details about your truck. \n4. Confirm the details. \n5. Hurray! your truck is added.',
    'To post load :\n1. Click on my load.\n2. Click on add load button.\n3. Fill the details about your load.\n4. Confirm the details.\n5. Hurray! your load is posted.',
  //  'To bid on the loads :\n1. Click on any load of your choice or you may also \tsearch load from search bar.\n2. Click on the bid button.\n3. Bid as per truck or per tonne.\n4. Click ok and your bid will be placed.',
  //  'To purchase GPS :\n1. On Home page click on Buy gps.\n1. Select your plan and the truck.\n2. Complete the payment procedure.\n3. Hurray! you purchased gps.',
    'To see my orders :\n1. Click on orders from home page.\n2. On orders page you can see bids, on-going and \tcompleted orders.',
  //  'To verify account :\n1. On home page click on My Account.\n2. Please upload your documents.\n3. Wait for us to verify your details, which may take \tsome while.\n4. Once your details are verified you can start bidding \ton the any load. ',
  //  'To add driver :\n1. Click on menu option from top-left corner.\n2. There you will find add driver.\n3. Fill the details about your driver.\n4. Hurray! your driver is added.',
  //  'To change language :\n1. Click on menu option from top-left corner.\n2. There you will find change language option.\n3. Select the language of your choice.',
    'To find loads :\n1. Click on search.\n2. Enter the loading and unloading point.\n3. It will show loads available based on you search.\n4. You can also see load suggestions on home page .',
  //  '\n1. You will be able track your truck’s live location.\n2. Get other information such as fuel info, kms left to \treach unloading point.'
  ];
  List<String> redirect = [
  //  'Click here to add truck',
    'Click here to post load ',
  //  'Click here to bid on loads',
  //  'Click here to purchase GPS',
    'Click here to see my orders',
  //  'Click here to go to my account',
  //  'Click here to add driver',
  //  'Click here to change language ',
    'Click here to search load',
  //  'Click here to buy GPS'
  ];

  var redirect_links = [
  //  AddNewTruck("redirectlinks"),
    const PostLoadScreenOne(),
  //  SuggestedLoadScreen(),
  //  BuyGpsScreen(),
    kIsWeb?const HomeScreenWeb():NavigationScreen(),
  //  AccountPageUtil(),
  //  AddDriverAlertDialog(
  //     notifyParent: () {
  //       Get.to(MyDrivers());
  //     },
  //   ),
  //  LanguageSelectionScreen(),
    FindLoadScreen(),
  //  BuyGpsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    NavigationIndexController navigationIndex =
        Get.put(NavigationIndexController(), permanent: true);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      const SizedBox(height: 10.0),
      GestureDetector(
          onTap: () {
            setState(() => _showData = !_showData);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(children: [
                    ListTile(
                      title: Text(
                        widget.title,
                        style: const TextStyle(

                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      trailing: !_showData
                          ? const Icon(Icons.arrow_forward_ios,
                              color: Colors.black, size: 14)
                          : const Icon(Icons.keyboard_arrow_down,
                              color: Colors.black, size: 25),
                    ),
                    _showData
                        ? Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 14, right: 20),
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(answers[widget.index].tr,
                                      style: const TextStyle(

                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.grey),
                                      textAlign: TextAlign.left),
                                  GestureDetector(
                                      onTap: () {
                                        navigationIndex.updateIndex(2);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    redirect_links[
                                                        widget.index]));
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.only(top: 10),
                                          child: Row(
                                              mainAxisSize:
                                                  MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    redirect[
                                                            widget.index]
                                                        .tr,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                        color: Color(
                                                            0xff09B778)),
                                                    textAlign:
                                                        TextAlign.left),
                                                Container(
                                                    margin: const EdgeInsets.only(
                                                        top: 2),
                                                    child: const Icon(
                                                        Icons
                                                            .arrow_forward_ios,
                                                        color: Color(
                                                            0xff09B778),
                                                        size: 12))
                                              ])))
                                ]))
                        : const SizedBox() // else blank
                  ])))),
    ]);
  }
}
