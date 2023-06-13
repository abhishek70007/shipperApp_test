import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/SelectedDriverController.dart';
import '/functions/loadApis/runSuggestedLoadApiWithPageNo.dart';
import '/models/WidgetLoadDetailsScreenModel.dart';
import '/models/loadDetailsScreenModel.dart';
import '/widgets/additionalDescription_LoadDetails.dart';
import '/widgets/buttons/backButtonWidget.dart';
import '/widgets/buttons/bidButton.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/loadPosterDetails.dart';
import '/widgets/headingTextWidget.dart';
import '/widgets/loadingWidgets/loadDetailsLoadingWidget.dart';
import '/widgets/locationDetails_LoadDetails.dart';
import '/widgets/requirementsLoad_DetailsWidget.dart';
import '/widgets/buttons/shareButton.dart';
import 'package:get/get.dart';

import '../functions/documentApi/getDocument.dart';

// ignore: must_be_immutable

class LoadDetailsScreen extends StatefulWidget {
  final LoadDetailsScreenModel loadDetailsScreenModel;

  LoadDetailsScreen({required this.loadDetailsScreenModel});

  @override
  _LoadDetailsScreenState createState() => _LoadDetailsScreenState();
}

class _LoadDetailsScreenState extends State<LoadDetailsScreen> {
  late WidgetLoadDetailsScreenModel widgetLoadDetailsScreenModel;
  bool loading = false;
  var imageLinks;
  SelectedDriverController selectedDriverController =
      Get.put(SelectedDriverController());

  runGetDetailsByPostLoadID() async {
    widgetLoadDetailsScreenModel = await getLoadDetailsByPostLoadID(
        loadPosterId: widget.loadDetailsScreenModel.postLoadId.toString());
    print(
        "Testing details---------->${widgetLoadDetailsScreenModel.loadPosterId.toString()}");
    setState(() {
      loading = false;
    });
    print(
        "widget load details screen------------------>${widget.loadDetailsScreenModel.loadId}");
  }

  Future<void> imageUrl() async {
    // imageLinks = [];

    imageLinks = await getDocumentWithTransportId(
        widget.loadDetailsScreenModel.postLoadId.toString());
    // if(imageLinks.length == 0){
    //   imageLinks.add("https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png");
    // }
    print("fffffff ${imageLinks}");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    runGetDetailsByPostLoadID();
    imageUrl();
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedDriverController.updateFromBook(false);
    return Scaffold(
      backgroundColor: statusBarColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: loading == true
              ? LoadDetailsLoadingWidget()
              : Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: space_2),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: space_4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BackButtonWidget(),
                            SizedBox(
                              width: space_3,
                            ),
                            HeadingTextWidget('loadDetails'.tr
                                // AppLocalizations.of(context)!.loadDetails
                                ),
                            // HelpButtonWidget(),
                          ],
                        ),
                        SizedBox(
                          height: space_3,
                        ),
                        Stack(
                          children: [
                            LoadPosterDetails(
                              loadPosterLocation: widgetLoadDetailsScreenModel
                                  .loadPosterLocation,
                              loadPosterName:
                                  widgetLoadDetailsScreenModel.loadPosterName,
                              loadPosterCompanyName:
                                  widgetLoadDetailsScreenModel
                                      .loadPosterCompanyName,
                              loadPosterCompanyApproved:
                                  widgetLoadDetailsScreenModel
                                      .loadPosterCompanyApproved,
                              imageUrl: imageLinks.toString(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: space_8,
                                  top: MediaQuery.of(context).size.height *
                                      0.192,
                                  right: space_8),
                              child: Container(
                                height: space_10,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(radius_2 - 2)),
                                child: Card(
                                  color: white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BidButton(
                                          loadDetails:
                                              widget.loadDetailsScreenModel),
                                      CallButton(
                                        directCall: true,
                                        phoneNum: widgetLoadDetailsScreenModel
                                            .phoneNo,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                space_2, space_3, space_2, space_3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: space_3),
                                  child: LocationDetailsLoadDetails(
                                    loadDetails: {
                                      "loadDate": widget
                                          .loadDetailsScreenModel.loadDate,
                                      "loadingPoint": widget
                                          .loadDetailsScreenModel
                                          .loadingPoint
                                          ?.tr,
                                      "loadingPointCity": widget
                                          .loadDetailsScreenModel
                                          .loadingPointCity
                                          ?.tr,
                                      "loadingPointState": widget
                                          .loadDetailsScreenModel
                                          .loadingPointState
                                          ?.tr,
                                      "loadingPoint2": widget
                                          .loadDetailsScreenModel
                                          .loadingPoint2
                                          ?.tr,
                                      "loadingPointCity2": widget
                                          .loadDetailsScreenModel
                                          .loadingPointCity2
                                          ?.tr,
                                      "loadingPointState2": widget
                                          .loadDetailsScreenModel
                                          .loadingPointState2
                                          ?.tr,
                                      "unloadingPoint": widget
                                          .loadDetailsScreenModel
                                          .unloadingPoint
                                          ?.tr,
                                      "unloadingPointCity": widget
                                          .loadDetailsScreenModel
                                          .unloadingPointCity
                                          ?.tr,
                                      "unloadingPointState": widget
                                          .loadDetailsScreenModel
                                          .unloadingPointState
                                          ?.tr,
                                      "unloadingPoint2": widget
                                          .loadDetailsScreenModel
                                          .unloadingPoint2
                                          ?.tr,
                                      "unloadingPointCity2": widget
                                          .loadDetailsScreenModel
                                          .unloadingPointCity2
                                          ?.tr,
                                      "unloadingPointState2": widget
                                          .loadDetailsScreenModel
                                          .unloadingPointState2
                                          ?.tr,
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: space_2),
                                  child: Divider(
                                    thickness: 1,
                                    color: borderLightColor,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: space_3),
                                  child: RequirementsLoadDetails(
                                    loadDetails: {
                                      "truckType": widget
                                          .loadDetailsScreenModel.truckType?.tr,
                                      "noOfTyres": widget
                                          .loadDetailsScreenModel.noOfTyres,
                                      "weight": widget
                                          .loadDetailsScreenModel.weight?.tr,
                                      "productType": widget
                                          .loadDetailsScreenModel
                                          .productType
                                          ?.tr,
                                      "rate":
                                          widget.loadDetailsScreenModel.rate,
                                      "unitValue": widget
                                          .loadDetailsScreenModel.unitValue?.tr,
                                    },
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(bottom: space_4),
                                    child: AdditionalDescriptionLoadDetails(
                                        widget.loadDetailsScreenModel.comment)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // BookNowButton(
                                    //   loadDetailsScreenModel:
                                    //       widget.loadDetailsScreenModel,
                                    // ),
                                    ShareButton(
                                      loadDetails:
                                          widget.loadDetailsScreenModel,
                                      widgetLoadDetailsScreenModel:
                                          widgetLoadDetailsScreenModel,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: space_10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
