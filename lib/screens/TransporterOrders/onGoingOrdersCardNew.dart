import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/models/onGoingCardModel.dart';
import '/screens/TransporterOrders/documentUploadScreen.dart';
import '/widgets/buttons/completedButton.dart';
import '/widgets/buttons/trackButton.dart';
import '/widgets/LoadEndPointTemplate.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/linePainter.dart';
import '/widgets/loadLabelValueRowTemplate.dart';
// import 'linePainter.dart';

class onGoingOrdersCardNew extends StatefulWidget {
  // BookingModel loadAllDataModel;
  OngoingCardModel loadAllDataModel;
  var gpsDataList;
  String? totalDistance;
  var device;

  onGoingOrdersCardNew({
    required this.loadAllDataModel,
    required this.gpsDataList,
    required this.totalDistance,
    this.device,
  });

  @override
  State<onGoingOrdersCardNew> createState() => _OngoingOrdersCardNewState();
}

class _OngoingOrdersCardNewState extends State<onGoingOrdersCardNew> {
  // GpsDataModel? gpsData;
  // var devicelist = [];
  // var gpsDataList = [];
  // var gpsList = [];

  // bool getMyTruckPostionBoolValue = false;
  // bool initfunctionBoolValue = false;

  // DateTime yesterday =
  //     DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  // String? from;
  // String? to;
  // DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  // String? totalDistance;
  @override
  void initState() {
    super.initState();

    // print(widget.loadAllDataModel.transporterId.toString());
    // getMyTruckPosition();
    // initFunction();
    // print("gpsDataList");
    // print(gpsDataList);
    // print(getMyTruckPostionBoolValue.toString() +
    //     initfunctionBoolValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return
        // gpsDataList.isEmpty
        // !initfunctionBoolValue
        //     ? Container()
        //     :
        // return
        Padding(
      padding: EdgeInsets.only(bottom: space_3),
      child: Container(
        child: GestureDetector(
          onTap: () {
            Get.to(documentUploadScreen(
              bookingId: widget.loadAllDataModel.bookingId.toString(),
              truckNo: widget.loadAllDataModel.truckNo,
              loadingPoint: widget.loadAllDataModel.loadingPointCity,
              unloadingPoint: widget.loadAllDataModel.unloadingPointCity,
              transporterName: widget.loadAllDataModel.shipperName,
              transporterPhoneNum: widget.loadAllDataModel.shipperPhoneNum,
              driverPhoneNum: widget.loadAllDataModel.driverPhoneNum,
              driverName: widget.loadAllDataModel.driverName,
              bookingDate: widget.loadAllDataModel.bookingDate,
              // trackApproved: true,
              gpsDataList: widget.gpsDataList,
              totalDistance: widget.totalDistance,
              device: widget.device,
            ));
            //     ShipperDetails(
            //   bookingId: widget.loadAllDataModel.bookingId.toString(),
            //   noOfTrucks: widget.loadAllDataModel.noOfTrucks,
            //   productType: widget.loadAllDataModel.productType,
            //   loadingPoint: widget.loadAllDataModel.loadingPointCity,
            //   unloadingPoint: widget.loadAllDataModel.unloadingPointCity,
            //   rate: widget.loadAllDataModel.rate,
            //   vehicleNo: widget.loadAllDataModel.truckNo,
            //   shipperPosterCompanyApproved:
            //       widget.loadAllDataModel.companyApproved,
            //   shipperPosterCompanyName: widget.loadAllDataModel.companyName,
            //   shipperPosterLocation:
            //       widget.loadAllDataModel.transporterLocation,
            //   shipperPosterName: widget.loadAllDataModel.transporterName,
            //   transporterPhoneNum: widget.loadAllDataModel.transporterPhoneNum,
            //   driverPhoneNum: widget.loadAllDataModel.driverPhoneNum,
            //   driverName: widget.loadAllDataModel.driverName,
            //   transporterName: widget.loadAllDataModel.companyName,
            //   trackApproved: true,
            //   gpsDataList: widget.gpsDataList,
            //   totalDistance: widget.totalDistance,
            // ));
          },
          child: Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(space_2),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoadLabelValueRowTemplate(
                              value: widget.loadAllDataModel.bookingDate,
                              label: 'bookingDate'.tr
                              // AppLocalizations.of(context)!.bookingDate
                              ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      SizedBox(
                        height: space_2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoadEndPointTemplate(
                              text: widget.loadAllDataModel.loadingPointCity,
                              endPointType: 'loading'),
                          Container(
                              padding: EdgeInsets.only(left: 2),
                              height: space_6,
                              width: space_12,
                              child: CustomPaint(
                                foregroundPainter: LinePainter(),
                              )),
                          LoadEndPointTemplate(
                              text: widget.loadAllDataModel.unloadingPointCity,
                              endPointType: 'unloading'),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: space_4),
                        child: Column(
                          children: [
                            LoadLabelValueRowTemplate(
                                value: widget.loadAllDataModel.truckNo,
                                label: 'truckNumber'.tr
                                // AppLocalizations.of(context)!.truckNumber
                                ),
                            LoadLabelValueRowTemplate(
                                value: widget.loadAllDataModel.driverName,
                                label: 'driverName'.tr
                                // AppLocalizations.of(context)!.driverName
                                ),
                            LoadLabelValueRowTemplate(
                                value:
                                    "Rs.${widget.loadAllDataModel.unitValue}/${widget.loadAllDataModel.unitValue}",
                                label: 'price'.tr
                                // AppLocalizations.of(context)!.price
                                ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: space_5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Container(
                              //   margin: EdgeInsets.only(right: space_1),
                              //   child: Image(
                              //       height: 16,
                              //       width: 23,
                              //       color: black,
                              //       image: AssetImage(
                              //           'assets/icons/buildingIcon.png')),
                              // ),
                              // Text(
                              //   textOverflowEllipsis(
                              //       "widget.loadAllDataModel.companyName"
                              //           .toString(),
                              //       20),
                              //   style: TextStyle(
                              //     color: liveasyBlackColor,
                              //     fontWeight: mediumBoldWeight,
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: space_2,
                          ),
                          CallButton(
                            directCall: false,
                            transporterPhoneNum:
                                widget.loadAllDataModel.shipperPhoneNum,
                            driverPhoneNum:
                                widget.loadAllDataModel.driverPhoneNum,
                            driverName: widget.loadAllDataModel.driverName,
                            transporterName:
                                widget.loadAllDataModel.companyName,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: contactPlaneBackground,
                  padding: EdgeInsets.symmetric(
                    vertical: space_2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TrackButton(
                        gpsData: widget.gpsDataList[0],
                        truckApproved: true,
                        TruckNo: widget.loadAllDataModel.truckNo,
                        totalDistance: widget.totalDistance,
                        device: widget.device,
                      ),
                      CompletedButtonOrders(
                          bookingId:
                              widget.loadAllDataModel.bookingId.toString(),
                          fontSize: size_7),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  //   if (widget.loadAllDataModel.driverName == null) {
  //     widget.loadAllDataModel.driverName = "NA";
  //   }
  //   widget.loadAllDataModel.driverName =
  //       widget.loadAllDataModel.driverName!.length >= 20
  //           ? widget.loadAllDataModel.driverName!.substring(0, 18) + '..'
  //           : widget.loadAllDataModel.driverName;
  //   // if (widget.loadAllDataModel.companyName == null) {}
  //   // widget.loadAllDataModel.companyName =
  //   //     widget.loadAllDataModel.companyName!.length >= 35
  //   //         ? widget.loadAllDataModel.companyName!.substring(0, 33) + '..'
  //   //         : widget.loadAllDataModel.companyName;

  //   widget.loadAllDataModel.unitValue =
  //       widget.loadAllDataModel.unitValue == "PER_TON"
  //           ? "tonne".tr
  //           : "truck".tr;

  //   return GestureDetector(
  //     onTap: () {
  //       Get.to(ShipperDetails(
  //         bookingId: widget.loadAllDataModel.bookingId.toString(),
  //         // truckType: truckType,
  //         // noOfTrucks: noOfTrucks,
  //         // productType: productType,
  //         loadingPoint: widget.loadAllDataModel.loadingPointCity,
  //         unloadingPoint: widget.loadAllDataModel.unloadingPointCity,
  //         rate: widget.loadAllDataModel.rate,
  //         vehicleNo: widget.loadAllDataModel.truckNo,
  //         // shipperPosterCompanyApproved: companyApproved,
  //         // shipperPosterCompanyName: companyName,
  //         // shipperPosterLocation: posterLocation,
  //         // shipperPosterName: posterName,
  //         // transporterPhoneNum: transporterPhoneNumber,
  //         driverPhoneNum: widget.loadAllDataModel.driverPhoneNum,
  //         driverName: widget.loadAllDataModel.driverName,
  //         // transporterName: companyName,
  //         trackApproved: true,
  //       ));
  //       // Get.to(() => OnGoingLoadDetails(
  //       //       loadALlDataModel: widget.loadAllDataModel,
  //       //       trackIndicator: false,
  //       //     ));
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(bottom: space_3),
  //       child: Card(
  //         elevation: 5,
  //         child: Column(
  //           children: [
  //             Container(
  //               margin: EdgeInsets.all(space_4),
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         '${"bookingDate".tr} : ${widget.loadAllDataModel.bookingDate}',
  //                         style: TextStyle(
  //                           fontSize: size_6,
  //                           color: veryDarkGrey,
  //                         ),
  //                       ),
  //                       Icon(Icons.arrow_forward_ios_sharp),
  //                     ],
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       LoadEndPointTemplate(
  //                           text: widget.loadAllDataModel.loadingPointCity,
  //                           endPointType: 'loading'),
  //                       Container(
  //                           padding: EdgeInsets.only(left: 2),
  //                           height: space_3,
  //                           width: space_12,
  //                           child: CustomPaint(
  //                             foregroundPainter: LinePainter(height: space_3),
  //                           )),
  //                       LoadEndPointTemplate(
  //                           text: widget.loadAllDataModel.unloadingPointCity,
  //                           endPointType: 'unloading'),
  //                     ],
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.only(top: space_4),
  //                     child: Column(
  //                       children: [
  //                         NewRowTemplate(
  //                           label: "truckNumber".tr,
  //                           value: widget.loadAllDataModel.truckNo,
  //                           width: 78,
  //                         ),
  //                         NewRowTemplate(
  //                             label: "driverName".tr,
  //                             value: widget.loadAllDataModel.driverName),
  //                         NewRowTemplate(
  //                           label: "price".tr,
  //                           // value: widget.loadAllDataModel.rate,
  //                           value:
  //                               '${widget.loadAllDataModel.rate}/${widget.loadAllDataModel.unitValue}',
  //                           width: 78,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   // Container(
  //                   //   margin: EdgeInsets.only(top: space_4),
  //                   //   child: Row(
  //                   //     children: [
  //                   //       Container(
  //                   //         margin: EdgeInsets.only(right: space_1),
  //                   //         child: Image(
  //                   //             height: 16,
  //                   //             width: 23,
  //                   //             color: black,
  //                   //             image:
  //                   //                 AssetImage('assets/icons/TruckIcon.png')),
  //                   //       ),
  //                   //       Text(
  //                   //         "widget.loadAllDataModel.companyName!",
  //                   //         style: TextStyle(
  //                   //           color: liveasyBlackColor,
  //                   //           fontWeight: mediumBoldWeight,
  //                   //         ),
  //                   //       )
  //                   //     ],
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               color: contactPlaneBackground,
  //               padding: EdgeInsets.symmetric(
  //                 vertical: space_2,
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 children: [
  //                   // print(gpsDataList[0]),
  //                   TrackButton(
  //                     gpsData: gpsDataList[0],
  //                     truckApproved: true,
  //                     TruckNo: "widget.loadAllDataModel.truckNo",
  //                     totalDistance: "totalDistance",
  //                   ),
  //                   CallButton(
  //                     directCall: false,
  //                     transporterPhoneNum:
  //                         "widget.loadAllDataModel.transporterPhoneNum",
  //                     driverPhoneNum: "widget.loadAllDataModel.driverPhoneNum",
  //                     driverName: "widget.loadAllDataModel.driverName",
  //                     transporterName: "widget.loadAllDataModel.companyName",
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   void getMyTruckPosition() async {
//     var devices =
//         await getDeviceByDeviceId(widget.loadAllDataModel.deviceId.toString());
//     var gpsDataAll = await getPositionByDeviceId(
//         widget.loadAllDataModel.deviceId.toString());

//     devicelist.clear();

//     for (var device in devices) {
//       setState(() {
//         devicelist.add(device);
//       });
//     }

//     gpsList = List.filled(devices.length, null, growable: true);

//     for (int i = 0; i < gpsDataAll.length; i++) {
//       getGPSData(gpsDataAll[i], i);
//     }

//     setState(() {
//       gpsDataList = gpsList;
//       print("GPSDATALIST....");
//       print(gpsDataList);
//       getMyTruckPostionBoolValue = true;
//     });
//     // return getMyTruckPostionBoolValue;
//   }

//   void getGPSData(var gpsData, int i) async {
//     gpsList.removeAt(i);

//     gpsList.insert(i, gpsData);
//   }

//   void initFunction() async {
//     var gpsRoute1 = await getTraccarSummaryByDeviceId(
//         deviceId: widget.loadAllDataModel.deviceId, from: from, to: to);
//     setState(() {
//       totalDistance = (gpsRoute1[0].distance / 1000).toStringAsFixed(2);
//       initfunctionBoolValue = true;
//     });
//     print('in init');
//     // return initfunctionBoolValue;
//   }
// }
