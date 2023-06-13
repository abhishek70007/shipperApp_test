import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/functions/bookingApiCallsOrders.dart';
import '/functions/ongoingTrackUtils/getDeviceData.dart';
import '/functions/ongoingTrackUtils/getPositionByDeviceId.dart';
import '/functions/ongoingTrackUtils/getTraccarSummaryByDeviceId.dart';
import '/language/localization_service.dart';
import '/models/deviceModel.dart';
import '/models/gpsDataModel.dart';
import '/models/onGoingCardModel.dart';
import '/screens/TransporterOrders/onGoingOrdersApiCall.dart';
import '/screens/TransporterOrders/onGoingOrdersCardNew.dart';
import '/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';
import '/widgets/loadingWidgets/onGoingLoadingWidgets.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OngoingScreenOrders extends StatefulWidget {
  @override
  State<OngoingScreenOrders> createState() => _OngoingScreenOrdersState();
}

class _OngoingScreenOrdersState extends State<OngoingScreenOrders> {
  GpsDataModel? gpsData;

  var devicelist = [];
  // var gpsDataList = [];
  // late List<dynamic> gpsDataList = [];
  List<dynamic> gpsDataList = [];
  // List.generate(10, (index) => 0);
  var gpsList = [];

  bool getMyTruckPostionBoolValue = false;
  bool initfunctionBoolValue = false;

  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  String? from = DateTime.now().toIso8601String();
  String? to = DateTime.now().toIso8601String();
  String? totalDistance;

  final BookingApiCallsOrders bookingApiCallsOrders = BookingApiCallsOrders();

  int i = 0;

  bool loading = false;
  bool OngoingProgress = false;

  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  // final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');
  final String bookingApiUrl = dotenv.get('bookingApiUrl');


  List<OngoingCardModel> modelList = [];
  // Future<dynamic>? modelList = [];
  ScrollController scrollController = ScrollController();

  getOnGoingOrders(int i) async {
    if (this.mounted) {
      setState(() {
        OngoingProgress = true;
      });
    }
    var bookingDataListWithPagei = await onGoingOrdersApiCall(i);
    for (var bookingData in bookingDataListWithPagei) {
      print(bookingData);
      modelList.add(bookingData);
    }
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        loading = false;
        OngoingProgress = false;
      });
    }

    print("model list length:- ");
    print(modelList.length);

    print("gps data :- ");
    await initializeGps();
  }

  initializeGps() async {
    print("in func");
    for (int i = 0; i < modelList.length; i++) {
      await getMyTruckPosition(i);
      // await initFunction(i);
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    // nullData();

    print("current selected language :- ");
    print(LocalizationService().getCurrentLocale());

    loading = true;
    getOnGoingOrders(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent * 0.7) {
        i = i + 1;
        getOnGoingOrders(i);
      }
    });
    print(modelList);
  }

  String searchedTruck = "";
  late String selectedTruck;
  late int selectedDeviceId;
  int selectedIndex = -1;
  var searchedModelList = [];
  var searchedDeviceList = [];
  var searchedGpsList = [];
  List truckList = [];
  List deviceIdList = [];

  void searchoperation(String searchText) {
// searchresult. clear() ;
    if (searchText != null) {
      searchedModelList.clear();
      searchedDeviceList.clear();
      searchedGpsList.clear();

      for (int i = 0; i < modelList.length; i++) {
        String truckNo = modelList[i].truckNo.toString();
        String loadingPoint = modelList[i].loadingPointCity.toString();
        String unLoadingPoint = modelList[i].unloadingPointCity.toString();
        String driverName = modelList[i].driverName.toString();
        String bookingDate = modelList[i].bookingDate.toString();

        //truckList[i];
        if ((truckNo.toLowerCase().contains(searchText.toLowerCase())) ||
            (loadingPoint.toLowerCase().contains(searchText.toLowerCase())) ||
            (unLoadingPoint.toLowerCase().contains(searchText.toLowerCase())) ||
            (driverName.toLowerCase().contains(searchText.toLowerCase())) ||
            (bookingDate.toLowerCase().contains(searchText.toLowerCase()))) {
          setState(() {
            print(searchText);
            searchedModelList.add(modelList[i]);
            searchedDeviceList.add(devicelist[i]);
            searchedGpsList.add(gpsDataList[i]);
            print(searchedModelList);
            print(searchedDeviceList);
          });
        }

        // else {
        //   searchedModelList.add("");
        // }
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height + size_10,
        child: loading
            ? OnGoingLoadingWidgets()
            : modelList.length == 0
                ? Container(
                    margin: EdgeInsets.only(top: 153),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/EmptyLoad.png'),
                          height: 127,
                          width: 127,
                        ),
                        Text(
                          'noOnGoingLoad'.tr,
                          // 'Looks like you have not added any Loads!',
                          style: TextStyle(fontSize: size_8, color: grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: lightNavyBlue,
                    onRefresh: () {
                      setState(() {
                        modelList.clear();
                        gpsDataList.clear();
                        loading = true;
                      });
                      return getOnGoingOrders(0);
                    },
                    // child: FutureBuilder<dynamic>(
                    //   future:
                    //       initializeGps(), // Here you run the check for all queryRows items and assign the fromContact property of each item
                    //   builder: (context, snapshot) {
                    //     return ListView.builder(
                    //       itemCount: modelList.length,
                    //       itemBuilder: (context, index) {
                    //         if (snapshot.hasData) {
                    //           // Check if the record is in Contacts
                    //           // True: Return your UI element with Name and Avatar here
                    //           return onGoingOrdersCardNew(
                    //             loadAllDataModel: modelList[index],
                    //             gpsDataList: gpsDataList[index],
                    //             totalDistance: totalDistance,
                    //           );
                    //         } else {
                    //           // False: Return UI element without Name and Avatar
                    //           return Container();
                    //         }
                    //       },
                    //     );
                    //   },
                    // ),

                    // ListView.builder(
                    //     physics: BouncingScrollPhysics(),
                    //     padding: EdgeInsets.only(bottom: space_10),
                    //     itemCount: modelList.length,
                    //     itemBuilder: (context, index) {
                    //       return FutureBuilder(
                    //           future: getMyTruckPosition(index),
                    //           builder: (context, snap) {
                    //             if (snap.hasData) {
                    //               // if(snap.hasData = true){
                    //               return onGoingOrdersCardNew(
                    //                 loadAllDataModel: modelList[index],
                    //                 gpsDataList: gpsDataList,
                    //                 totalDistance: totalDistance,
                    //               );
                    //             } else {
                    //               return Container();
                    //             }
                    //             // }
                    //             // return Loading();
                    //           });
                    //     }
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: space_3, horizontal: space_3),
                            child: Container(
                              height: space_11,
                              decoration: BoxDecoration(
                                color: widgetBackGroundColor,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 0.8, color: widgetBackGroundColor),
                              ),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchedTruck = value;
                                  });
                                  print(value);
                                  searchoperation(searchedTruck);
                                },
                                textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'search'.tr,
                                  icon: Padding(
                                    padding: EdgeInsets.only(left: space_2),
                                    child: Icon(
                                      Icons.search,
                                      color: grey,
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: size_8,
                                    color: grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          searchedTruck == ""
                              ?
                              // child:
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: space_10),
                                  itemCount: modelList.length,
                                  itemBuilder: (context, index) {
                                    // getMyTruckPosition(index);
                                    initFunction(index);
                                    return (index == modelList.length - 1)
                                        ? Visibility(
                                            visible: OngoingProgress,
                                            child:
                                                bottomProgressBarIndicatorWidget())
                                        : (index < gpsDataList.length)
                                            ? onGoingOrdersCardNew(
                                                loadAllDataModel:
                                                    modelList[index],
                                                gpsDataList: gpsDataList[index],
                                                totalDistance: totalDistance,
                                                device: devicelist[index],
                                              )
                                            : Container();
                                  })
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: space_10),
                                  itemCount: searchedModelList.length,
                                  itemBuilder: (context, index) {
                                    // getMyTruckPosition(index);
                                    initFunction(index);
                                    return (index == searchedModelList.length)
                                        ? Visibility(
                                            visible: OngoingProgress,
                                            child:
                                                bottomProgressBarIndicatorWidget())
                                        : (index < searchedGpsList.length)
                                            ? onGoingOrdersCardNew(
                                                loadAllDataModel:
                                                    searchedModelList[index],
                                                gpsDataList:
                                                    searchedGpsList[index],
                                                totalDistance: totalDistance,
                                                device:
                                                    searchedDeviceList[index],
                                              )
                                            : Container();
                                  }),
                        ],
                      ),
                      // ]
                    ),
                  ));
    // ),
    // );
  }

  // List<GpsDataModel> gpsDataList;
  // Future<bool>
  getMyTruckPosition(int index) async {
    List<DeviceModel> devices =
        await getDeviceByDeviceId(modelList[index].deviceId.toString());
    print("in func 3");
    List<GpsDataModel> gpsDataAll =
        await getPositionByDeviceId(modelList[index].deviceId.toString());

    // devicelist.clear();

    for (var device in devices) {
      setState(() {
        devicelist.add(device);
      });
    }

    gpsList = List.filled(devices.length, null, growable: true);

    for (int i = 0; i < gpsDataAll.length; i++) {
      getGPSData(gpsDataAll[i], i);
    }
    print("GPSDATALIST....");
    // gpsDataList.add(gpsList);
    setState(() {
      // gpsDataList[i] = gpsList;
      gpsDataList.add(gpsList);
      // print("GPSDATALIST....");
      print(gpsDataList);
      getMyTruckPostionBoolValue = true;
    });
    // return true;
    // return getMyTruckPostionBoolValue;
  }

  void getGPSData(var gpsData, int i) async {
    gpsList.removeAt(i);

    gpsList.insert(i, gpsData);
  }

  void initFunction(index) async {
    List<GpsDataModel> gpsRoute1 = await getTraccarSummaryByDeviceId(
        deviceId: modelList[index].deviceId, from: from, to: to);

      totalDistance = (gpsRoute1[0].distance! / 1000).toStringAsFixed(2);
      initfunctionBoolValue = true;

    print('in init');
    // return initfunctionBoolValue;
  }
}

// } //class end

//     return Container(
//         height: MediaQuery.of(context).size.height * 0.67,
//         child: FutureBuilder(
//           //getTruckData returns list of truck Model
//           future: bookingApiCallsOrders.getDataByShipperIdOnGoing(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.data == null) {
//               return OnGoingLoadingWidgets();
//             }
//             //number of cards

//             if (snapshot.data.length == 0) {
//               return Container(
//                 margin: EdgeInsets.only(top: 153),
//                 child: Column(
//                   children: [
//                     Image(
//                       image: AssetImage('assets/images/EmptyLoad.png'),
//                       height: 127,
//                       width: 127,
//                     ),
//                     Text(
//                       'Looks like you have no on-going bookings!',
//                       style: TextStyle(fontSize: size_8, color: grey),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return FutureBuilder(
//                         future: loadAllOnGoingOrdersData(snapshot.data[index]),
//                         //loadAllDataOrdersNew(snapshot.data[index]),
//                         // future: modelList,
//                         builder:
//                             (BuildContext context, AsyncSnapshot snapshot) {
//                           if (snapshot.data == null) {
//                             return OnGoingLoadingWidgets();
//                           }
//                           return OngoingCardOrders(
//                             // loadAllDataModel: modelList[index]
//                             unitValue: snapshot.data['unitValue'],
//                             productType: snapshot.data['productType'],
//                             noOfTrucks: snapshot.data['noOfTrucks'],
//                             truckType: snapshot.data['truckType'],
//                             posterLocation: snapshot.data['posterLocation'],
//                             posterName: snapshot.data['posterName'],
//                             companyApproved: snapshot.data['companyApproved'],
//                             rate: snapshot.data['rate'],
//                             loadingPoint: snapshot.data['loadingPoint'],
//                             unloadingPoint: snapshot.data['unloadingPoint'],
//                             companyName: snapshot.data['companyName'],
//                             vehicleNo: snapshot.data['truckNo'],
//                             driverName: snapshot.data['driverName'],
//                             startedOn: snapshot.data['startedOn'],
//                             bookingId: snapshot.data['bookingId'],
//                             endedOn: snapshot.data['endedOn'],
//                             imei: snapshot.data['imei'],
//                             driverPhoneNum: snapshot.data['driverPhoneNum'],
//                             transporterPhoneNumber:
//                                 snapshot.data['posterPhoneNum'],
//                             // transporterName : snapshot.data['transporterName'],
//                           );
//                         });
//                   } //builder

//                   );
//             } //else
//           },
//         ));
//   }
// } //class end
