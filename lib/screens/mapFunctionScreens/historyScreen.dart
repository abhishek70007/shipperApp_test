import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/functions/mapUtils/getLoactionUsingImei.dart';
import '/widgets/Header.dart';
import '/widgets/buttons/helpButton.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';

class HistoryScreen extends StatefulWidget {
  final String? TruckNo;
  final String? imei;

  HistoryScreen({required this.TruckNo, required this.imei});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final List<PointLatLng> polylinePoints;
  late GoogleMapController _googleMapController;
  late LatLng lastlatLngMarker;
  Iterable markers = [];
  ScreenshotController screenshotController = ScreenshotController();
  late BitmapDescriptor pinLocationIcon;
  late CameraPosition camPosition;
  var logger = Logger();
  late Marker markernew;
  List<Marker> customMarkers = [];
  late Timer timer;
  Completer<GoogleMapController> _controller = Completer();
  List? newGPSData;
  MapUtil mapUtil = MapUtil();
  String? startTime;
  String? endTime;
  final now = DateTime.now();
  String sendTime = DateFormat('yyyyMMdd:HHmmss').format(DateTime.now());
  TextEditingController hourscontroller = TextEditingController();
  TextEditingController minutescontroller = TextEditingController();
  TextEditingController dayscontroller = TextEditingController();

  void getHistory(var endtime) async {
    print("IMei is ${widget.imei}");
    var gpsDataInitial = await mapUtil.getLocationHistoryByImei(
        imei: widget.imei, starttime: sendTime, endtime: endtime);
    setState(() {
      newGPSData = gpsDataInitial;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: statusBarColor,
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF525252),
      //   title: ,
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, space_4, 0, 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: space_4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(space_3, 0, space_3, 0),
                      child: Header(
                          reset: false,
                          text: 'Location History',
                          backButton: true),
                    ),
                    HelpButtonWidget()
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "From Date and Time"
              // ),
              // DateTimePicker(
              //   type: DateTimePickerType.dateTime,
              //   // dateMask: 'd MMM, yyyy',
              //   // dateMask: 'yyyy MM dd : HH mm ss',
              //   // dateMask: "d MMMM, yyyy - hh:mm a",
              //   dateMask: 'dd/MM/yyyy - hh:mm',
              //   initialValue: DateTime.now().toString(),
              //   firstDate: DateTime(DateTime.now().year),
              //   lastDate: DateTime(2100),
              //   icon: Icon(Icons.event),
              //   dateLabelText: 'Date',
              //   timeLabelText: "Hour",
              //   selectableDayPredicate: (date) {
              //     // Disable weekend days to select from the calendar
              //     if (date.weekday == 6 || date.weekday == 7) {
              //       return false;
              //     }
              //
              //     return true;
              //   },
              //   onChanged: (val) {
              //     print("$val onchanged");
              //     try {
              //       var trim = val.toString().trim();
              //       var trimrm = trim.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "");
              //       var trimfinal = trimrm.substring(0, 8) + ":" + trimrm.substring(8,12) + "00";
              //       setState(() {
              //         startTime = trimfinal;
              //       });
              //       print("selected date 1 is $trimfinal");
              //     } catch (e) {
              //       print("Exception is $e");
              //     }
              //   },
              //   validator: (val) {
              //     print("$val validator");
              //     return null;
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //     "To Date and Time"
              // ),
              // DateTimePicker(
              //   type: DateTimePickerType.dateTime,
              //   dateMask: 'dd/MM/yyyy - hh:mm',
              //   initialValue: DateTime.now().toString(),
              //   firstDate: DateTime(DateTime.now().year),
              //   lastDate: DateTime(2100),
              //   icon: Icon(Icons.event),
              //   dateLabelText: 'Date',
              //   timeLabelText: "Hour",
              //   selectableDayPredicate: (date) {
              //     // Disable weekend days to select from the calendar
              //     if (date.weekday == 6 || date.weekday == 7) {
              //       return false;
              //     }
              //
              //     return true;
              //   },
              //   onChanged: (val) {
              //     print("$val onchanged");
              //     try {
              //       var trim = val.toString().trim();
              //       var trimrm = trim.replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "");
              //       var trimfinal = trimrm.substring(0, 8) + ":" + trimrm.substring(8,12) + "00";
              //       print("selected date 1 is $trimfinal");
              //       setState(() {
              //         endTime = trimfinal;
              //       });
              //     } catch (e) {
              //       print("Exception is $e");
              //     }
              //   },
              //   validator: (val) {
              //     print("$val validator");
              //     return null;
              //   },
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              TextButton(
                  onPressed: () {
                    // if (startTime == null || endTime == null) {
                    //   print("Please select date and time");
                    // } else {
                    //   getHistory();
                    // }
                    if (dayscontroller.text == "" ||
                        hourscontroller.text == "" ||
                        minutescontroller.text == "") {
                      print("One of it is null");
                    } else {
                      var lastdays = int.parse(dayscontroller.text);
                      var lastminutes = int.parse(minutescontroller.text);
                      var lasthours = int.parse(hourscontroller.text);
                      final hoursago = DateTime(now.year, now.month, now.day,
                          now.hour - lasthours, now.minute, now.second);
                      final minutesago = DateTime(now.year, now.month, now.day,
                          now.hour, now.minute - lastminutes, now.second);
                      final daysago = DateTime(now.year, now.month,
                          now.day - lastdays, now.hour, now.minute, now.second);
                      final hourreplacing = hoursago
                          .toString()
                          .replaceAll("-", "")
                          .replaceAll(" ", "")
                          .replaceAll(":", "")
                          .replaceAll(".000", "");
                      final finalhour = hourreplacing.substring(0, 7) +
                          ":" +
                          hourreplacing.substring(8, 14);

                      print("now is $now");
                      var nowtime = DateFormat('yyyyMMdd:HHmmss').format(now);
                      print("Mapped is $finalhour");
                    }
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (BuildContext bc) {
                    //       return SafeArea(
                    //         child: Container(
                    //           child: new Wrap(
                    //             children: <Widget>[
                    //               new ListTile(
                    //                   leading: new Icon(Icons.photo_library),
                    //                   title: new Text('Photo Library'),
                    //                   onTap: () async {
                    //                     Navigator.of(context).pop();
                    //                   }),
                    //               new ListTile(
                    //                 leading: new Icon(Icons.photo_camera),
                    //                 title: new Text('Camera'),
                    //                 onTap: () async {
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     }
                    // );
                  },
                  child: Text("Get Truck History")),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    final yesterday = DateTime(now.year, now.month, now.day - 1,
                        now.hour, now.minute, now.second);
                    print("yesterday is $yesterday");
                  },
                  child: Text("YesterDay")),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Last"),
                  DropdownButton<int>(
                    items: <int>[1, 2, 3, 4].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value"),
                        onTap: () {
                          print("Value is $value");
                        },
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  Text("Days"),
                  TextButton(
                      onPressed: () {
                        // final now = DateTime.now();
                        // print("Send time is $sendTime");
                        // setState(() {
                        //   sendTime =
                        // });
                        // var lastdays = int.parse(dayscontroller.text);
                        // final daysago = DateTime(now.year, now.month, now.day - lastdays, now.hour, now.minute, now.second);
                        // final daysreplacing = daysago.toString().replaceAll("-", "").replaceAll(" ", "").replaceAll(":", "").replaceAll(".000", "");
                        // final finaldays = daysreplacing.substring(0, 7) + ":" + daysreplacing.substring(8, 14);
                        // print("Days are $finaldays");
                        // getHistory(sendTime, finaldays);
                      },
                      child: Text("Go"))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Last"),
                  Container(
                    width: 60,
                    child: TextField(
                      decoration: InputDecoration(hintText: "hours"),
                      controller: hourscontroller,
                    ),
                  ),
                  Text("Hours"),
                  TextButton(
                      onPressed: () {
                        final now = DateTime.now();
                        print("Send time is $sendTime");
                        var lasthours = int.parse(hourscontroller.text);
                        final hoursago = DateTime(now.year, now.month, now.day,
                            now.hour - lasthours, now.minute, now.second);
                        final hoursreplacing = hoursago
                            .toString()
                            .replaceAll("-", "")
                            .replaceAll(" ", "")
                            .replaceAll(":", "")
                            .replaceAll(".000", "");
                        final finalhours = hoursreplacing.substring(0, 7) +
                            ":" +
                            hoursreplacing.substring(8, 14);
                        print("Hours are $finalhours");
                      },
                      child: Text("Go"))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Last"),
                  Container(
                    width: 80,
                    child: TextField(
                      decoration: InputDecoration(hintText: "minutes"),
                      controller: minutescontroller,
                    ),
                  ),
                  Text("Minutes"),
                  TextButton(
                      onPressed: () {
                        final now = DateTime.now();
                        print("Send time is $sendTime");
                        var lastminutes = int.parse(minutescontroller.text);
                        final minutesago = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            now.hour,
                            now.minute - lastminutes,
                            now.second);
                        final minutesreplacing = minutesago
                            .toString()
                            .replaceAll("-", "")
                            .replaceAll(" ", "")
                            .replaceAll(":", "")
                            .replaceAll(".000", "");
                        final finalminutes = minutesreplacing.substring(0, 7) +
                            ":" +
                            minutesreplacing.substring(8, 14);
                        print("Minutes are $finalminutes");
                      },
                      child: Text("Go"))
                ],
              ),
              Divider(
                thickness: 10,
                color: Colors.black,
              ),
              // newGPSData != null
              // ? Container(
              //   height: 300,
              //   child: ListView.builder(
              //       padding: EdgeInsets.only(bottom: space_15),
              //       // controller: scrollController,
              //       itemCount: newGPSData!.length,
              //       itemBuilder: (context, index) {
              //         return Text(
              //             "${newGPSData![index].address}"
              //         );
              //       }),
              // )
              //     : Text("No data available"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () {
          logger.i("Working on click in refresh button");
          // onRefreshPressed()
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
