import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/functions/BackgroundAndLocation.dart';
import '/functions/trackScreenFunctions.dart';
import '/models/gpsDataModel.dart';

class TruckStatus extends StatefulWidget {
  var truckHistory;
  var deviceId;

  TruckStatus({
    required this.truckHistory,
    required this.deviceId,
  });

  @override
  _TruckStatusState createState() => _TruckStatusState();
}

class _TruckStatusState extends State<TruckStatus> {
  var startTime;
  var endTime;
  var placemarks;
  var duration;
  String? address;
  var gpsPosition;
  var newGpsPosition;
  @override
  void initState() {
    super.initState();
    // getPosition();
    print("Here ${widget.truckHistory.runtimeType}");
    if (widget.truckHistory.runtimeType == GpsDataModel) {
      getFormattedDate();
      duration = convertMillisecondsToDuration(widget.truckHistory.duration);
    } else {
      getAddress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.truckHistory.runtimeType != GpsDataModel)
        ? Container(
            //  color: backgroundColor,
            height: 132,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  color: backgroundColor,
                  margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                  //    margin: EdgeInsets.fromLTRB(space_5, space_5, space_1, space_4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Stack(children: [
                          Icon(
                            Icons.circle,
                            color: const Color(0xFFFF6868),
                            size: 24,
                          ),
                          Positioned(
                            top: 7.8,
                            left: 7.8,
                            child: Image.asset('assets/icons/Rectangle 268.png',
                                width: 8.5,
                                height: 8.5,
                                color: const Color(0xFFB60000)),
                          ),
                        ]),
                     /*   DottedLine(
                          direction: Axis.vertical,
                          lineLength: 108,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                        )*/
                        Container(
                          height: 108,
                          width: 2,
                          color: const Color.fromRGBO(21, 41, 104, 0.2)
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 74,
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_2),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${widget.truckHistory[1]} - ${widget.truckHistory[2]}",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: black,
                                    fontSize: size_7,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_1),
                                alignment: Alignment.centerLeft,
                                //   height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "stoppedFor".tr +"  ",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: const Color(0xff333333),
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "${widget.truckHistory[3]}",
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: const Color(0xffFF0000),
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 74,
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_1),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "$address",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: const Color(0xff333333),
                                    fontSize: size_6,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container(
            //  color: backgroundColor,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  color: backgroundColor,
                  margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                  //    margin: EdgeInsets.fromLTRB(space_5, space_5, space_1, space_4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Stack(children: [
                          Icon(
                            Icons.circle,
                            color: const Color(0xFFBAE5D5),
                            size: 24,
                          ),
                          Positioned(
                            left: 7.3,
                            top: 7.3,
                            child: Icon(
                              Icons.circle,
                              color: const Color(0xFF09B778),
                              size: 9.5,
                            ),
                          ),
                        ]),
                   /*     DottedLine(
                          direction: Axis.vertical,
                          lineLength: 108,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: Colors.black,
                        )*/
                        Container(
                          height: 76,
                          width: 2,
                          color: const Color.fromRGBO(21, 41, 104, 0.2)
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width - 74,
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_2),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "$startTime - $endTime",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: black,
                                      fontSize: size_7,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_1),
                                alignment: Alignment.centerLeft,
                                //   height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "travelledFor".tr +"   ",
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: const Color(0xff333333),
                                        fontSize: size_6,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "${duration}",
                                        maxLines: 3,
                                        style: TextStyle(
                                          color: const Color(0xff09B778),
                                          fontSize: size_6,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width - 74,
                                margin: EdgeInsets.fromLTRB(
                                    space_3, 0, space_1, space_1),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "travelled".tr +"  ${(widget.truckHistory.distance / 1000).toStringAsFixed(2)} kms",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: const Color(0xff333333),
                                    fontSize: size_6,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  getFormattedDate() {
    setState(() {
      startTime = getISOtoIST(widget.truckHistory.startTime.toString());
      print("start time in route is ${startTime}");
    });
    setState(() {
      endTime = getISOtoIST(widget.truckHistory.endTime.toString());
      print("end date is ${endTime}");
    });
  }

  getAddress() async {
    var getaddress = await getStoppageAddressLatLong(
        widget.truckHistory[4], widget.truckHistory[5]);
    setState(() {
      address = getaddress;
    });
  }
}
