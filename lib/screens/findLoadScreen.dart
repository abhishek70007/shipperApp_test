import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/controller/tokenMMIController.dart';
import '/controller/shipperIdController.dart';
import '/functions/loadApis/runFindLoadApiGet.dart';
import '/functions/placeAutoFillUtils/autoFillMMI.dart';
import '/providerClass/providerData.dart';
import '/widgets/availableLoadsTextWidget.dart';
import '/widgets/buttons/filterButton.dart';
import '/widgets/headingTextWidget.dart';
import '/widgets/suggestedLoadsCard.dart';
import '/widgets/loadingPointImageIcon.dart';
import '/widgets/loadingWidget.dart';
import '/widgets/noCardDisplay.dart';
import '/widgets/unloadingPointImageIcon.dart';
import 'package:provider/provider.dart';
import '/widgets/addressInputMMIWidget.dart';

class FindLoadScreen extends StatefulWidget {
  @override
  _FindLoadScreenState createState() => _FindLoadScreenState();
}

class _FindLoadScreenState extends State<FindLoadScreen> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  var findLoadApiData;
  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());
  @override
  Widget build(BuildContext context) {
    if(Get.isRegistered<TokenMMIController>()){
      Get.put(TokenMMIController());
    }else{Get.put(TokenMMIController());}
    getMMIToken();
    var providerData = Provider.of<ProviderData>(context, listen: false);
    if (Provider.of<ProviderData>(context).loadingPointCityFindLoad != "") {
      controller1 = TextEditingController(
          text:
              ("${providerData.loadingPointCityFindLoad} (${providerData.loadingPointStateFindLoad})"));
      findLoadApiData = runFindLoadApiGet(providerData.loadingPointCityFindLoad,
          providerData.unloadingPointCityFindLoad);

    }
    if (Provider.of<ProviderData>(context).unloadingPointCityFindLoad != "") {
      controller2 = TextEditingController(
          text:
              ("${providerData.unloadingPointCityFindLoad} (${providerData.unloadingPointStateFindLoad})"));
      findLoadApiData = runFindLoadApiGet(providerData.loadingPointCityFindLoad,
          providerData.unloadingPointCityFindLoad);
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(space_4, space_4, space_4, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            providerData.clearLoadingPointFindLoad();
                            providerData.clearUnloadingPointFindLoad();
                          },
                          child: Icon(Icons.arrow_back_ios_rounded),
                        ),
                        SizedBox(
                          width: space_3,
                        ),
                        HeadingTextWidget(
                        'findLoad'.tr
                            // "Find Load"
                        ),
                        // HelpButtonWidget(),
                      ],
                    ),
                    FilterButtonWidget(),
                  ],
                ),
                SizedBox(
                  height: space_5,
                ),
                AddressInputMMIWidget(
                  page:"findLoad",
                    hintText: "Loading Point",
                    // "Loading Point",
                    icon: LoadingPointImageIcon(
                      height: space_2 + 2,
                      width: space_2 + 2,
                    ),
                    controller: controller1,
                    onTap: () {
                      providerData.clearLoadingPointFindLoad();
                    }),
                SizedBox(
                  height: space_4,
                ),
                AddressInputMMIWidget(
                  page:"findLoad",
                  hintText: "Unloading Point",
                  // "Unloading Point",
                  icon: UnloadingPointImageIcon(
                    height: space_2 + 2,
                    width: space_2 + 2,
                  ),
                  controller: controller2,
                  onTap: () {
                    providerData.clearUnloadingPointFindLoad();
                  },
                ),
                SizedBox(
                  height: space_3,
                ),
                Container(
                  color: lightGrayishBlue,
                  height: borderWidth_12,
                ),
                SizedBox(
                  height: space_4,
                ),
                findLoadApiData == null
                    ? Container()
                    : FutureBuilder(
                        future: findLoadApiData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.2),
                                child: LoadingWidget());
                          } else if (snapshot.data.length == 0) {
                            return NoCardDisplay();
                          }
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AvailableLoadsTextWidget(),
                                  FilterButtonWidget()
                                ],
                              ),
                              SizedBox(
                                height: space_4,
                              ),
                              Container(
                                height: 450,
                                //TODO to be modified
                                //alternative-(MediaQuery.of(context).size.height-(previous height))
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(),
                                  itemCount: (snapshot.data.length),
                                  itemBuilder: (BuildContext context, index) =>
                                      SuggestedLoadsCard(
                                        loadDetailsScreenModel: snapshot.data[index],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
