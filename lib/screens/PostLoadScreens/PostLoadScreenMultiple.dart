import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import '/constants/spaces.dart';
import '/constants/fontWeights.dart';
import '/constants/fontSize.dart';
import '/widgets/addTruckSubtitleText.dart';
import '/widgets/addressInputMMIWidget.dart';
import '/widgets/addressInputGMapsWidget.dart';
import '/widgets/buttons/NextButton.dart';
import '/widgets/loadingPointImageIcon.dart';
import '/widgets/unloadingPointImageIcon.dart';

class PostLoadScreenMultiple extends StatefulWidget {
  const PostLoadScreenMultiple({Key? key}) : super(key: key);

  @override
  State<PostLoadScreenMultiple> createState() => _PostLoadScreenMultipleState();
}
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
bool add_load = false;
bool add_unload = false;
class _PostLoadScreenMultipleState extends State<PostLoadScreenMultiple> {
  @override
  Widget build(BuildContext context) {
  ProviderData providerData = Provider.of<ProviderData>(context);
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
  if(providerData.loadingPointStatePostLoad2!=""){
    controller3 = TextEditingController(
      text:
      ("${providerData.loadingPointCityPostLoad2} (${providerData.loadingPointStatePostLoad2})"));
  } else{
    controller3 = TextEditingController(text: "");
  }
  if(providerData.unloadingPointCityPostLoad2!=""){
    controller4 = TextEditingController(
      text:
      ("${providerData.unloadingPointCityPostLoad2} (${providerData.unloadingPointStatePostLoad2})"));
  } else{
    controller4 = TextEditingController(text: "");
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
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Loading Point",
                              style: TextStyle(
                                  fontSize: size_10,
                                  fontWeight: boldWeight,
                                  color:darkBlueColor
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size_2, size_7, size_10, size_0),
                            child: AddressInputMMIWidget(
                                page:
                                "postLoad", //use AddressInputMMIWidget for using mapMyIndia api
                                hintText: "Loading point 1",
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
                          SizedBox(height: size_2),
                          add_load? Padding(
                            padding: EdgeInsets.fromLTRB(
                                size_2, size_7, size_10, size_0),
                            child: AddressInputMMIWidget(
                                page:
                                "postLoad", //use AddressInputMMIWidget for using mapMyIndia api
                                hintText: "Loading point 2",
                                icon: LoadingPointImageIcon(
                                  height: size_6,
                                  width: size_6,
                                ),
                                controller: controller3,
                                onTap: () {
                                  providerData.updateLoadingPointPostLoad2(
                                      place: "", city: "", state: "");
                                  setState(() {
                                    add_load = !add_load;
                                  });
                                }),
                          ) : Padding(
                            padding: EdgeInsets.fromLTRB(space_8, space_0, space_0, space_0),
                            child: TextButton.icon(
                              onPressed: (){
                                setState(() {
                                  add_load = !add_load;
                                });
                                },
                              icon: Icon(Icons.add,color: darkBlueColor,),
                              label: Text("Add more loading point",style: TextStyle(color: darkBlueColor),),

                            ),
                          ),
                          SizedBox(height: space_18,),
                          Text("Unloading Point",
                              style: TextStyle(
                                  fontSize: size_10,
                                  fontWeight: boldWeight,
                                  color:darkBlueColor
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size_2, size_5, size_10, size_0),
                            child: AddressInputMMIWidget(
                              page: "postLoad",
                              hintText: "Unloading point 1",
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
                          SizedBox(height: space_2),
                      add_unload? Padding(
                        padding: EdgeInsets.fromLTRB(
                            size_2, size_5, size_10, size_0),
                        child: AddressInputMMIWidget(
                          page: "postLoad",
                          hintText: "Unloading point 2",
                          icon: UnloadingPointImageIcon(
                            height: size_6,
                            width: size_6,
                          ),
                          controller: controller4,
                          onTap: () {
                            providerData.updateUnloadingPointPostLoad2(
                                place: "", city: "", state: "");
                            setState(() {
                              add_unload = !add_unload;
                            });
                          },
                        ),
                      ) :Padding(
                        padding: EdgeInsets.fromLTRB(space_8, space_0, space_0, space_0),
                        child: TextButton.icon(
                          onPressed: (){
                            setState(() {
                              add_unload = !add_unload;
                            });},
                          icon: Icon(Icons.add,color: darkBlueColor,),
                          label: Text("Add more unloading point",style: TextStyle(color: darkBlueColor),),

                        )),
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
                          ),
                          SizedBox(
                            height: space_3,
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 136,),
              nextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
