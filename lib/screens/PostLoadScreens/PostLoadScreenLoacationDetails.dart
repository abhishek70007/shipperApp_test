import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/controller/postLoadVariablesController.dart';
import '/controller/tokenMMIController.dart';
import '/providerClass/providerData.dart';
import '/widgets/AddCalender.dart';
import '/widgets/addPostLoadHeader.dart';
import '/widgets/addTruckSubtitleText.dart';
import '/widgets/addressInputMMIWidget.dart';
import '/widgets/addressInputGMapsWidget.dart';
import '/widgets/buttons/NextButton.dart';
import '/widgets/loadingPointImageIcon.dart';
import '/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

class PostLoadScreenOne extends StatefulWidget {
  const PostLoadScreenOne({Key? key}) : super(key: key);

  @override
  _PostLoadScreenOneState createState() => _PostLoadScreenOneState();
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
Jiffy initialDay = Jiffy(DateTime.now());
Jiffy secondDay = Jiffy(DateTime.now()).add(days: 1);
Jiffy thirdDay = Jiffy(DateTime.now()).add(days: 2);
Jiffy fourthDay = Jiffy(DateTime.now()).add(days: 3);

class _PostLoadScreenOneState extends State<PostLoadScreenOne> {
  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + 3,
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day + 3,
        ),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 10, 0, 0));
    Jiffy nextDay = Jiffy(picked);

    if (picked != null && picked != selectedDate)
      setState(() {
        bookingDateList[3] = (nextDay.MMMEd);
        selectedDate = picked;
      });
  }

  List bookingDateList = [
    initialDay.MMMEd,
    secondDay.MMMEd,
    thirdDay.MMMEd,
    fourthDay.MMMEd
  ];
  bool i = false;
  bool setDate = false;
  var recentDate = fourthDay.MMMEd;
  PostLoadVariablesController postLoadVariables =
      Get.put(PostLoadVariablesController());
  TokenMMIController tokenMMIController =
      Get.put(TokenMMIController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    // var locationCard = fillCityName("Delhi"); // as city search takes a lot of time in first go
    // providerData.resetPostLoadScreenOne(); // to reset every thing
    // providerData.resetPostLoadFilters();
    // providerData.updateEditLoad(false, "");

    if (postLoadVariables.bookingDate.value != "" &&
        postLoadVariables.bookingDate.value != bookingDateList[0] &&
        postLoadVariables.bookingDate.value != bookingDateList[1] &&
        postLoadVariables.bookingDate.value != bookingDateList[2]) {
      bookingDateList[3] = postLoadVariables.bookingDate.value;
    }
    if (bookingDateList.last != recentDate && !setDate) {
      postLoadVariables.updateBookingDate(bookingDateList[3]);
      // providerData.updateBookingDate(bookingDateList[3]);
      setDate = true;
      recentDate = bookingDateList[3];
    }
    if (!i && postLoadVariables.bookingDate.value == "") {
      postLoadVariables.updateBookingDate(initialDay.MMMEd);
      i = true;
    }

    if (providerData.loadingPointCityPostLoad != "") {
      controller1 = TextEditingController(
          text:
              ("${providerData.loadingPointCityPostLoad} (${providerData.loadingPointStatePostLoad})"));
    } else {
      controller1 = TextEditingController(text: "");
    }
    if (providerData.unloadingPointCityPostLoad != "") {
      controller2 = TextEditingController(
          text:
              ("${providerData.unloadingPointCityPostLoad} (${providerData.unloadingPointStatePostLoad})"));
    } else {
      controller2 = TextEditingController(text: "");
    }

    return Scaffold(
      backgroundColor: backgroundColor,


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(space_4, space_2, space_4, space_0),
                color: backgroundColor,
                child: Column(
                  children: [
                    //AddPostLoadHeader(
                      //reset: true,
                      //resetFunction: () {
                        //providerData.resetPostLoadScreenOne();
                      //},
                    //),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddTruckSubtitleText(text: 'locationDetails'.tr
                              // AppLocalizations.of(context)!.locationDetails
                              ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size_2, size_5, size_10, size_2),
                            child: AddressInputMMIWidget(
                                page:
                                    "postLoad", //use AddressInputMMIWidget for using mapMyIndia api
                                hintText: "Loading point",
                                icon: LoadingPointImageIcon(
                                  height: size_6,
                                  width: size_6,
                                ),
                                controller: controller1,
                                onTap: () {
                                  providerData.updateLoadingPointPostLoad(
                                      place: "", city: "", state: "");
                                }),
                          ),
                          SizedBox(height: size_5),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size_2, size_5, size_10, size_2),
                            child: AddressInputMMIWidget(
                              page: "postLoad",
                              hintText: "Unloading point",
                              icon: UnloadingPointImageIcon(
                                height: size_6,
                                width: size_6,
                              ),
                              controller: controller2,
                              onTap: () {
                                providerData.updateUnloadingPointPostLoad(
                                    place: "", city: "", state: "");
                              },
                            ),
                          ),
                          SizedBox(height: space_3),
                          /*AddTruckSubtitleText(text: 'bookingDate'.tr
                              // AppLocalizations.of(context)!.bookingDate
                              ),
                          GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: EdgeInsets.all(10.0),
                            crossAxisCount: 2,
                            children: bookingDateList
                                .map((e) => AddCalender(value: e, text: e))
                                .toList(),
                          ),
                          SizedBox(
                            height: space_4,
                          ),
                          Center(
                            child: Container(
                              width: space_30,
                              height: space_8,
                              child: ElevatedButton(
                                onPressed: () {
                                  setDate = false;
                                  _selectDate(context);
                                },
                                style:
                                    ButtonStyle(backgroundColor: calendarColor),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'selectDates'.tr,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: size_7,
                                          fontWeight: normalWeight),
                                    ),
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: black,
                                      size: size_9,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),*/
                          SizedBox(
                            height: 323,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              /*SizedBox(
                height: 323,
              )*/
              nextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
