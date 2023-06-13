import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import 'package:logger/logger.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/functions/ongoingTrackUtils/getDeviceData.dart';
import '/functions/ongoingTrackUtils/getPositionByDeviceId.dart';
import '/functions/ongoingTrackUtils/getTraccarSummaryByDeviceId.dart';
import '/models/gpsDataModel.dart';
import '/models/onGoingCardModel.dart';
import '/screens/TransporterOrders/documentUploadScreen.dart';
import '/widgets/buttons/trackButton.dart';
import '/screens/myLoadPages/onGoingLoadDetails.dart';
import '/widgets/LoadEndPointTemplate.dart';
import '/widgets/buttons/callButton.dart';
import '/widgets/newRowTemplate.dart';
import 'linePainter.dart';

class OngoingCard extends StatefulWidget {
  final OngoingCardModel loadAllDataModel;

  // final GpsDataModel gpsData;

  const OngoingCard({super.key,
    required this.loadAllDataModel,
  });

  @override
  State<OngoingCard> createState() => _OngoingCardState();
}

class _OngoingCardState extends State<OngoingCard> {
  GpsDataModel? gpsData;
  var deviceList = [];
  var gpsDataList = [];
  var gpsList = [];

  String? from;
  String? to;
  String? totalDistance;

  @override
  void initState() {
    super.initState();

    DateTime yesterday = DateTime.now()
        .subtract(Duration(days: 1, hours: 5, minutes: 30)); //from param
    from = yesterday.toIso8601String();
    DateTime now =
    DateTime.now().subtract(Duration(hours: 5, minutes: 30)); //to param
    to = now.toIso8601String();

    getMyTruckPosition();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    widget.loadAllDataModel.driverName ??= "NA";
    widget.loadAllDataModel.driverName =
        widget.loadAllDataModel.driverName!.length >= 20
            ? '${widget.loadAllDataModel.driverName!.substring(0, 18)}..'
            : widget.loadAllDataModel.driverName;
    if (widget.loadAllDataModel.companyName == null) {}
    widget.loadAllDataModel.companyName =
        widget.loadAllDataModel.companyName!.length >= 35
            ? '${widget.loadAllDataModel.companyName!.substring(0, 33)}..'
            : widget.loadAllDataModel.companyName;

    widget.loadAllDataModel.unitValue =
        widget.loadAllDataModel.unitValue == "PER_TON"
            ? "tonne".tr
            : "truck".tr;

    return GestureDetector(
      onTap: () {
        // Get.to(() =>
        // OnGoingLoadDetails(
        //       loadALlDataModel: widget.loadAllDataModel,
        //       trackIndicator: false,
        //     ));
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
          gpsDataList: gpsDataList,
          // widget.gpsDataList,
          totalDistance: totalDistance,
          //  widget.totalDistance,
          // device: gpsData.deviceId,
          // gpsData!.deviceId
          // widget.device,
        ));
      },
      child: gpsDataList.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(bottom: space_3),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(space_4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${"bookingDate".tr} : ${widget.loadAllDataModel.bookingDate}',
                                style: TextStyle(
                                  fontSize: size_6,
                                  color: veryDarkGrey,
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_sharp),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoadEndPointTemplate(
                                  text:
                                      widget.loadAllDataModel.loadingPointCity,
                                  endPointType: 'loading'),
                              Container(
                                  padding: const EdgeInsets.only(left: 2),
                                  height: space_3,
                                  width: space_12,
                                  child: CustomPaint(
                                    foregroundPainter:
                                        LinePainter(height: space_3),
                                  )),
                              LoadEndPointTemplate(
                                  text: widget
                                      .loadAllDataModel.unloadingPointCity,
                                  endPointType: 'unloading'),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: space_4),
                            child: Column(
                              children: [
                                NewRowTemplate(
                                  label: "truckNumber".tr,
                                  value: widget.loadAllDataModel.truckNo,
                                  width: 78,
                                ),
                                NewRowTemplate(
                                    label: "driverName".tr,
                                    value: widget.loadAllDataModel.driverName),
                                NewRowTemplate(
                                  label: "price".tr,
                                  value:
                                      '${widget.loadAllDataModel.rate}/${widget.loadAllDataModel.unitValue}',
                                  width: 78,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: space_4),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: space_1),
                                  child: const Image(
                                      height: 16,
                                      width: 23,
                                      color: black,
                                      image: AssetImage(
                                          'assets/icons/TruckIcon.png')),
                                ),
                                Text(
                                  widget.loadAllDataModel.companyName!,
                                  style: TextStyle(
                                    color: liveasyBlackColor,
                                    fontWeight: mediumBoldWeight,
                                  ),
                                )
                              ],
                            ),
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
                            gpsData: gpsDataList[0],
                            truckApproved: true,
                            TruckNo: widget.loadAllDataModel.truckNo,
                            totalDistance: totalDistance,
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
                    ),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }

  void getMyTruckPosition() async {
    var devices =
        await getDeviceByDeviceId(widget.loadAllDataModel.deviceId.toString());
    var gpsDataAll = await getPositionByDeviceId(
        widget.loadAllDataModel.deviceId.toString());

    deviceList.clear();

    if (devices != null) {
      for (var device in devices) {
        setState(() {
          deviceList.add(device);
        });
      }
    }

    gpsList = List.filled(devices.length, null, growable: true);

    //for loop will iterate and change the gpsList contents
    for (int i = 0; i < gpsDataAll.length; i++) {
      getGPSData(gpsDataAll[i], i);
    }

    setState(() {
      gpsDataList = gpsList;
    });

  }

  void getGPSData(var gpsData, int i) async {
    gpsList.removeAt(i);

    gpsList.insert(i, gpsData);
  }

  void initFunction() async {
    var gpsRoute1 = await getTraccarSummaryByDeviceId(
        deviceId: widget.loadAllDataModel.deviceId, from: from, to: to);
    setState(() {
      totalDistance = (gpsRoute1[0].distance! / 1000).toStringAsFixed(2);
    });


    // print('in init');
  }
}
