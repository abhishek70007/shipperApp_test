import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/Web/screens/home_web.dart';
import 'package:sizer/sizer.dart';
import '../responsive.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';
import '/controller/navigationIndexController.dart';
import '/models/loadDetailsScreenModel.dart';
import '/models/popupModelForMyLoads.dart';
import '/providerClass/providerData.dart';
// import '/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';
import '/screens/navigationScreen.dart';
import '/variables/truckFilterVariables.dart';
import '/widgets/LoadEndPointTemplate.dart';
import '/widgets/buttons/repostButton.dart';
import '/widgets/linePainter.dart';
import '/widgets/buttons/viewBidsButton.dart';
import 'package:provider/provider.dart';
import 'priceContainer.dart';
import 'package:get/get.dart';
import '/functions/loadApiCalls.dart';
import '/screens/PostLoadScreens/postloadnavigation.dart';

// ignore: must_be_immutable
class MyLoadsCard extends StatelessWidget {
  LoadDetailsScreenModel loadDetailsScreenModel;

  MyLoadsCard({super.key, required this.loadDetailsScreenModel});

  TruckFilterVariables truckFilterVariables = TruckFilterVariables();

  @override
  Widget build(BuildContext context) {
    if (truckFilterVariables.truckTypeValueList
        .contains(loadDetailsScreenModel.truckType)) {
      loadDetailsScreenModel.truckType = truckFilterVariables.truckTypeTextList[
          truckFilterVariables.truckTypeValueList
              .indexOf(loadDetailsScreenModel.truckType)];
    }

    if (loadDetailsScreenModel.unitValue == 'PER_TON') {
      loadDetailsScreenModel.unitValue = 'tonne'.tr;
    } else if (loadDetailsScreenModel.unitValue == 'PER_TRUCK') {
      loadDetailsScreenModel.unitValue = 'truck'.tr;
    }

    return Container(
      margin: EdgeInsets.only(bottom: space_2),
      child: Card(
        color: loadDetailsScreenModel.status == "EXPIRED"
            ? cancelledBiddingBackground
            : Colors.white,
        elevation: 3,
        child: Container(
          padding:
              EdgeInsets.only(bottom: space_2, left: space_2, right: space_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${'postedon'.tr}: ${loadDetailsScreenModel.postLoadDate}',
                    style: TextStyle(
                        fontSize: kIsWeb ? size_8 : size_6,
                        color: veryDarkGrey,
                        fontFamily: 'montserrat'),
                  ),
                  loadDetailsScreenModel.status == 'EXPIRED'
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.more_vert, color: black),
                        )
                      : PopupMenuButton<popupMenuforloads>(
                          offset: Offset(0, space_2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(radius_2))),
                          onSelected: (item) => onSelected(context, item),
                          itemBuilder: (context) => [
                                ...MenuItems.listItem
                                    .map(showEachItemFromList)
                                    .toList(),
                              ]),
                ],
              ),
              !Responsive.isMobile(context)
                  ? webView(context)
                  : mobileView(),
              SizedBox(
                height: space_2,
              ),
              loadDetailsScreenModel.status == 'EXPIRED'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'loadexpired'.tr,
                          // "Load Expired!",
                          style: TextStyle(
                            color: declineButtonRed,
                            fontSize: size_8,
                            fontWeight: mediumBoldWeight,
                            
                          ),
                        ),
                        RepostButton(),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        loadDetailsScreenModel.rate != 'NA'
                            ? PriceContainer(
                                rate: loadDetailsScreenModel.rate,
                                unitValue: loadDetailsScreenModel.unitValue,
                              )
                            : const SizedBox(),
                        ViewBidsButton(
                          loadId: loadDetailsScreenModel.loadId,
                          loadingPointCity:
                              loadDetailsScreenModel.loadingPointCity,
                          unloadingPointCity:
                              loadDetailsScreenModel.unloadingPointCity,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<popupMenuforloads> showEachItemFromList(
          popupMenuforloads item) =>
      PopupMenuItem<popupMenuforloads>(
          value: item,
          child: Row(
            children: [
              Image(
                image: AssetImage(item.iconImage),
                height: size_6 + 1,
                width: size_6 + 1,
              ),
              SizedBox(
                width: space_1 + 2,
              ),
              Text(
                item.itemText,
                style: TextStyle(
                  fontWeight: mediumBoldWeight,
                  
                ),
              ),
            ],
          ));

  void onSelected(BuildContext context, popupMenuforloads item) {
    ProviderData providerData =
        Provider.of<ProviderData>(context, listen: false);
    NavigationIndexController navigationIndexController =
        Get.put(NavigationIndexController());
    switch (item) {
      case MenuItems.itemEdit:
        providerData.updateLoadingPointPostLoad(
            place: loadDetailsScreenModel.loadingPoint!,
            city: loadDetailsScreenModel.loadingPointCity!,
            state: loadDetailsScreenModel.loadingPointState!);
        if (loadDetailsScreenModel.loadingPoint2 != "NA") {
          providerData.updateLoadingPointPostLoad2(
              place: loadDetailsScreenModel.loadingPoint2!,
              city: loadDetailsScreenModel.loadingPointCity2!,
              state: loadDetailsScreenModel.loadingPointState2!);
        }
        providerData.updateUnloadingPointPostLoad(
            place: loadDetailsScreenModel.unloadingPoint!,
            city: loadDetailsScreenModel.unloadingPointCity!,
            state: loadDetailsScreenModel.unloadingPointState!);
        providerData.updateProductType(loadDetailsScreenModel.productType);
        if (loadDetailsScreenModel.noOfTyres != "NA") {
          providerData
              .updateTruckNumber(int.parse(loadDetailsScreenModel.noOfTyres!));
        }
        if (loadDetailsScreenModel.unloadingPoint2 != "NA") {
          providerData.updateUnloadingPointPostLoad2(
              place: loadDetailsScreenModel.unloadingPoint2!,
              city: loadDetailsScreenModel.unloadingPointCity2!,
              state: loadDetailsScreenModel.unloadingPointState2!);
        }
        providerData.updatePassingWeightValue(
            int.parse(loadDetailsScreenModel.weight!));
        providerData.updateTruckTypeValue(loadDetailsScreenModel.truckType!
            .replaceAll(" ", "_")
            .toUpperCase());

        if (loadDetailsScreenModel.unitValue == "tonne") {
          providerData.PerTonTrue(true, false);
        } else if (loadDetailsScreenModel.unitValue == "truck") {
          providerData.PerTruckTrue(true, false);
        } else {
          providerData.PerTonTrue(false, false);
          providerData.PerTruckTrue(false, false);
        }
        loadDetailsScreenModel.rate == "NA"
            ? providerData.updatePrice(0)
            : providerData.updatePrice(int.parse(loadDetailsScreenModel.rate!));
        providerData.updateBookingDate(loadDetailsScreenModel.loadDate);

        providerData.postLoadScreenOneButton();
        providerData.updateResetActive(true);
        providerData.updateEditLoad(true, loadDetailsScreenModel.loadId!);

        print(providerData.editLoad); // true
        Get.to(const PostLoadNav());
        break;
      case MenuItems.itemDisable:
        LoadApiCalls loadApiCalls = LoadApiCalls();
        loadApiCalls.disableActionOnLoad(loadId: loadDetailsScreenModel.loadId);
        Timer(const Duration(seconds: 1), () {
          navigationIndexController.updateIndex(2);
          // Get.offAll(NavigationScreen());
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  kIsWeb ? const HomeScreenWeb() : NavigationScreen()));
        });

        break;
    }
  }

  webView(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: !Responsive.isMobile(context)?CrossAxisAlignment.start:CrossAxisAlignment.center,
          children: [
            LoadEndPointTemplate(
                text: "${loadDetailsScreenModel.loadingPointCity}".tr,
                endPointType: 'loading'),
            loadDetailsScreenModel.loadingPointCity2 != "NA"
                ? LoadEndPointTemplate(
                text: "${loadDetailsScreenModel.loadingPointCity2}",
                endPointType: 'loading')
                : Container(),
            Container(
              height: space_4 + 2,
              padding: EdgeInsets.only(left: space_1 - 3),
              child: CustomPaint(
                foregroundPainter: LinePainter(height: space_4 + 2, width: 1),
              ),
            ),
            LoadEndPointTemplate(
                text: "${loadDetailsScreenModel.unloadingPointCity}".tr,
                endPointType: 'unloading'),
            loadDetailsScreenModel.unloadingPointCity2 != "NA"
                ? LoadEndPointTemplate(
                text: "${loadDetailsScreenModel.unloadingPointCity2}".tr,
                endPointType: 'unloading')
                : Container(),
          ],
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const Image(
                    image: AssetImage('assets/images/TruckListEmptyImage.png'),
                    height: 24,
                    width: 24,
                  ),
                ),
                Text(
                  '${'${loadDetailsScreenModel.truckType}'.tr}|${loadDetailsScreenModel.noOfTyres} ${'tyres'.tr}',
                  style: TextStyle(fontSize: size_6, fontWeight: mediumBoldWeight),
                ),
              ],
            ) ,
            SizedBox(
              height: space_5,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const Image(
                    image: AssetImage('assets/images/EmptyLoad.png'),
                    height: 24,
                    width: 24,
                  ),
                ),
                Text(
                  '${'${loadDetailsScreenModel.productType}'.tr}| ${loadDetailsScreenModel.weight} ${'tons'.tr}',
                  style: TextStyle(fontSize: size_6, fontWeight: mediumBoldWeight),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  mobileView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoadEndPointTemplate(
            text: "${loadDetailsScreenModel.loadingPointCity}".tr,
            endPointType: 'loading'),
        loadDetailsScreenModel.loadingPointCity2 != "NA"
            ? LoadEndPointTemplate(
            text:
            "${loadDetailsScreenModel.loadingPointCity2}",
            endPointType: 'loading')
            : Container(),
        Container(
          height: space_4 + 2,
          padding: EdgeInsets.only(left: space_1 - 3),
          child: CustomPaint(
            foregroundPainter:
            LinePainter(height: space_4 + 2, width: 1),
          ),
        ),
        LoadEndPointTemplate(
            text:
            "${loadDetailsScreenModel.unloadingPointCity}".tr,
            endPointType: 'unloading'),
        loadDetailsScreenModel.unloadingPointCity2 != "NA"
            ? LoadEndPointTemplate(
            text:
            "${loadDetailsScreenModel.unloadingPointCity2}"
                .tr,
            endPointType: 'unloading')
            : Container(),
        SizedBox(
          height: space_1,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Image(
                image: AssetImage(
                    'assets/images/TruckListEmptyImage.png'),
                height: 24,
                width: 24,
              ),
            ),
            Text(
              '${'${loadDetailsScreenModel.truckType}'.tr}|${loadDetailsScreenModel.noOfTyres} ${'tyres'.tr}',
              style: TextStyle(
                  fontSize: size_6, fontWeight: mediumBoldWeight),
            ),
          ],
        ),
        SizedBox(
          height: space_1,
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: const Image(
                image: AssetImage('assets/images/EmptyLoad.png'),
                height: 24,
                width: 24,
              ),
            ),
            Text(
              '${'${loadDetailsScreenModel.productType}'.tr}| ${loadDetailsScreenModel.weight} ${'tons'.tr}',
              style: TextStyle(
                  fontSize: size_6, fontWeight: mediumBoldWeight),
            ),
          ],
        ),
      ],
    );
  }

}
