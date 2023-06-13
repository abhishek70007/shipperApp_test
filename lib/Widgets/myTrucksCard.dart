import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/constants/fontWeights.dart';
import '/functions/trackScreenFunctions.dart';
import '/models/deviceModel.dart';
import '/models/truckModel.dart';
import '/providerClass/providerData.dart';
import '/screens/trackScreen.dart';
import '/variables/truckFilterVariables.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyTruckCard extends StatefulWidget {
  var truckno;
  var gpsData;
  String status;
  var imei;
  DeviceModel device;

  MyTruckCard(
      {required this.truckno,
      required this.status,
      this.gpsData,
      this.imei,
      required this.device});

  @override
  _MyTruckCardState createState() => _MyTruckCardState();
}

class _MyTruckCardState extends State<MyTruckCard> {
  TruckFilterVariables truckFilterVariables = TruckFilterVariables();

  bool online = true;
  Position? userLocation;
  bool driver = false;
  var gpsDataHistory;
  var gpsStoppageHistory;
  var gpsRoute;
  var totalDistance;
  var lastupdated;
  var lastupdated2;
  var no_stoppages;
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));

  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));
  late String from = yesterday.toIso8601String();
  late String to = now.toIso8601String();

  @override
  void initState() {
    super.initState();

    try {
      initfunction();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == 'Online') {
      online = true;
    } else {
      online = false;
    }
    lastupdated =
        getStopDuration(widget.device.lastUpdate!, now.toIso8601String());
    lastupdated2 =
        getStopDuration2(widget.device.lastUpdate!, now.toIso8601String());
    return Container(
      color: Color(0xffF7F8FA),
      margin: EdgeInsets.only(bottom: space_2),
      child: GestureDetector(
        onTap: () async {
          Get.to(
            TrackScreen(
              deviceId: widget.gpsData.deviceId,
              gpsData: widget.gpsData,
              truckNo: widget.truckno,
              totalDistance: totalDistance,
              active: online,
              online: online,
              // imei: widget.imei,
            ),
          );
        },
        child: Card(
          elevation: 5,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(space_3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F8FA),
                  ),
                  child: Column(
                    children: [
                      online
                          ? Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Icon(
                                      Icons.circle,
                                      color: const Color(0xff09B778),
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    'online'.tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        space_28,
                                    child: Text(
                                      ' (${'lastupdated'.tr} $lastupdated ${'ago'.tr})  $lastupdated2',
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: Icon(
                                      Icons.circle,
                                      color: const Color(0xffFF4D55),
                                      size: 6,
                                    ),
                                  ),
                                  Text(
                                    'offline'.tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        space_28,
                                    child: Text(
                                      ' (${'lastupdated'.tr} $lastupdated ${'ago'.tr})  $lastupdated2',
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/box-truck.png',
                            width: 29,
                            height: 29,
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Column(
                            children: [
                              Text(
                                '${widget.truckno}',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: black,
                                ),
                              ),
                              /*   Text(
                                'time date ',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: black,
                                  ),

                              ),*/
                            ],
                          ),
                          Spacer(),
                          (widget.gpsData.speed > 5)
                              ? Container(
                                  child: Column(
                                    children: [
                                      Text(
                                          "${(widget.gpsData.speed).round()} km/h",
                                          style: TextStyle(
                                              color: liveasyGreen,
                                              fontSize: size_10,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: regularWeight)),
                                      Text('running'.tr,
                                          // "Status",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: size_6,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: regularWeight))
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text("0 km/h",
                                          style: TextStyle(
                                              color: red,
                                              fontSize: size_10,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: regularWeight)),
                                      Text('stopped'.tr,
                                          // "Status",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: size_6,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: regularWeight))
                                    ],
                                  ),
                                )
                        ],
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.place_outlined,
                                color: const Color(0xFFCDCDCD),
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Container(
                                width: 200,
                                child: Text(
                                  "${widget.gpsData.address}",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: normalWeight),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 14,
                              color: const Color(0xFFCDCDCD),
                            ),
                            SizedBox(width: 8),
                            Text('truckTravelled'.tr,
                                // "Truck Travelled : ",
                                softWrap: true,
                                style: TextStyle(
                                    color: black,
                                    fontSize: size_6,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: regularWeight)),
                            Expanded(
                              child: Text(
                                  "$totalDistance " + 'Km in last 24 hours'.tr,
                                  // "km Today",
                                  softWrap: true,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: size_6,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: regularWeight)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/circle-outline-with-a-central-dot.png',
                              color: const Color(0xFFCDCDCD),
                              width: 12,
                              height: 12,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('ignition'.tr,
                                // 'Ignition  :',
                                style: TextStyle(
                                    color: black,
                                    fontSize: size_6,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: regularWeight)),
                            (widget.gpsData.ignition)
                                ? Text('on'.tr,
                                    // "ON",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight))
                                : Text('off'.tr,
                                    // "OFF",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: regularWeight)),
                            Spacer(),
                            Container(
                              height: 30,
                              width: 40,
                              alignment: Alignment.centerLeft,
                              child: (widget.gpsData.rssi == -1)
                                  ? Image(
                                      width: 30,
                                      image: AssetImage(
                                          "assets/icons/signalIconNothing.png"),
                                    )
                                  : (widget.gpsData.rssi == 0)
                                      ? Image(
                                          width: 40,
                                          image: AssetImage(
                                              "assets/icons/signalIconZero.png"),
                                        )
                                      : (widget.gpsData.rssi == 1)
                                          ? Image(
                                              width: 30,
                                              image: AssetImage(
                                                  "assets/icons/signalIconOne.png"),
                                            )
                                          : (widget.gpsData.rssi == 2)
                                              ? Image(
                                                  width: 30,
                                                  image: AssetImage(
                                                      "assets/icons/signalIconTwo.png"),
                                                )
                                              : (widget.gpsData.rssi == 3)
                                                  ? Image(
                                                      width: 30,
                                                      image: AssetImage(
                                                          "assets/icons/signalIconThree.png"),
                                                    )
                                                  : (widget.gpsData.rssi == 4 ||
                                                          widget.gpsData.rssi ==
                                                              5)
                                                      ? Image(
                                                          width: 30,
                                                          image: AssetImage(
                                                              "assets/icons/signalIconFour.png"),
                                                        )
                                                      : Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  initfunction() async {
    var gpsRoute1 = await mapUtil.getTraccarSummary(
        deviceId: widget.gpsData.deviceId, from: from, to: to);
    setState(() {
      totalDistance = (gpsRoute1[0].distance / 1000).toStringAsFixed(2);
    });
    print('in init');
  }
}
