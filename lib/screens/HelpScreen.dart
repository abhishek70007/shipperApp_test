import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/Header.dart';
import '/widgets/alertDialog/nextUpdateAlertDialog.dart';
import '/widgets/contactUsWidget.dart';
import '/widgets/searchLoadWidget.dart';
import '/widgets/HelpCardWidget.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final myController = TextEditingController();
  bool _showData = false;

  //add questions here
  List<String> questions = [
 //   'How to add truck?',
    'How to post load?',
 //   'How to bid?',
 //   'How to purchase GPS?',
    'How to see my orders?',
 //   'How to verify my account?',
 //   'How to add driver?',
 //   'How to change language?',
    'How to find load for my truck?',
 //   'Why should I buy GPS?',
  ];

  @override
  Widget build(BuildContext context) {
    var cardWidth;
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.only(top: space_5, right: space_4, left: space_4, bottom: space_3),
          height: MediaQuery.of(context).size.height - space_4,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: space_4),
                      child: Header(
                          reset: false,
                          text: 'Help and Support'.tr,
                          backButton: true),
                    )
                  ],
                ),
                ContactUsWidget(),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: space_6),
              child: Text(
                'What\'s your question?'.tr,
                style: TextStyle(fontSize: size_8, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: space_1),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 3,
                  width: 80,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: truckGreen,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: space_5),
              child: SearchLoadWidget(
                hintText: 'search'.tr,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => NextUpdateAlertDialog());
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: questions.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index != questions.length
                        ? Column(children: [
                            // returning the CardWidget passing only title
                            HelpCardWidget(
                                title: questions[index].tr, index: index),
                          ])
                        : GestureDetector(
                            onTap: () {
                              setState(() => _showData = !_showData);
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: space_2),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)),
                                child: Container(
                                    margin: EdgeInsets.all(space_1),
                                    child: Column(children: [
                                      ListTile(
                                        title: Text(
                                          'Ask a question'.tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: size_7),
                                        ),
                                        trailing: !_showData
                                            ? Icon(Icons.arrow_forward_ios,
                                                color: Colors.black,
                                                size: size_7)
                                            : Icon(Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: size_12),
                                      ),
                                      _showData
                                          ? Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: space_2,
                                                  bottom: space_3,
                                                  right: space_2),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: size_6,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        controller:
                                                            myController,
                                                        textAlign:
                                                            TextAlign.start,
                                                        decoration: InputDecoration(
                                                            fillColor: backgroundColor,
                                                            filled: true,
                                                            contentPadding:
                                                                EdgeInsets.only(top: space_4, left: space_2, right: space_2),
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Please write to us, we will get in touch with you.'.tr,
                                                            hintStyle: TextStyle(
                                                                fontSize: size_6,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,)),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: EdgeInsets.only(
                                                          left: space_3),
                                                      child: TextButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          )),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      darkBlueColor),
                                                        ),
                                                        onPressed: () {
                                                          _sendMail(myController
                                                              .text);
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            'submit'.tr,
                                                            style: TextStyle(
                                                              letterSpacing:
                                                                  0.7,
                                                              fontWeight:
                                                                  normalWeight,
                                                              color: white,
                                                              fontSize: size_6,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]))
                                          : SizedBox() // else blank
                                    ]))));
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
_sendMail(String askedQuestion) async {
  String url =
      'mailto:liveasy97@gmail.com?subject=Question&body=${askedQuestion}';
  UrlLauncher.launchUrl(Uri.parse(url));
}
