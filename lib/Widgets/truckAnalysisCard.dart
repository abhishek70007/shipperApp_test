import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '/constants/colors.dart';
import 'package:http/http.dart' as http;
import '/widgets/showStopOnMap.dart';

class truckanalysisCard extends StatefulWidget {
  var validStop;
  var validAddress;
  var TruckNo;
  var truckId;
  var imei;
  var truckStauts;
  var stopStatus;

  truckanalysisCard({
    required this.validStop,
    required this.validAddress,
    required this.truckId,
    required this.TruckNo,
    required this.imei,
    required this.truckStauts,
    this.stopStatus,
  });

  @override
  _truckanalysisCardState createState() => _truckanalysisCardState();
}

class _truckanalysisCardState extends State<truckanalysisCard> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  var validStop;
  var validAddress;
  var TruckNo;
  var truckId;
  var imei;
  var truckStatus;
  var stopStatus;


  String textHolder = 'What is this Location?';

  /// Bools to set state once button is clicked.
  bool _disableButtonOne = false;
  bool _disableButtonTwo = false;
  bool _disableButtonThree = false;
  bool _disableButtonFour = false;
  bool buttonIsClickable = true;

  /// Initially all are set to false so that when we receive
  /// the given data we set the appropriate one to true.
  bool _colorButtonOne = false;
  bool _colorButtonTwo = false;
  bool _colorButtonThree = false;
  bool _colorButtonFour = false;


  /// Function to make a post request to the routeData Api
  postRouteData(
      String stopAddress, String stoppageStatus, var validStop) async {
    Map<String, dynamic> data = {
      "stopageAddress": stopAddress,
      "stopageStatus": stoppageStatus,
      "truckNo": TruckNo.toString(),
      "truckId": truckId.toString(),
      "duration": validStop.duration.toString(),
      "latitude": validStop.latitude,
      "longitude": validStop.longitude,
      "imei": imei,
      "deviceId": validStop.deviceId.toString()
    };
    String body = json.encode(data);
    http.Response response = await http.post(
        Uri.parse("http://load.dev.truckseasy.com:8080/routedata"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body);
    var returnData = json.decode(response.body);
    print(returnData);
  }

  /// To set color of button to green Once its Clicked.
  colorDisabledOne(){
    setState(() {
      _disableButtonOne = true;
      /// Change text in card when Post is made.
      textHolder = 'You marked this Location as?';
      /// Disable all buttons.
      buttonIsClickable = false;
    });
  }
  colorDisabledTwo(){
    setState(() {
      _disableButtonTwo = true;
      /// Change text in card when Post is made.
      textHolder = 'You marked this Location as?';
      /// Disable all buttons.
      buttonIsClickable = false;
    });
  }
  colorDisabledThree(){
    setState(() {
      _disableButtonThree = true;
      /// Change text in card when Post is made.
      textHolder = 'You marked this Location as?';
      /// Disable all buttons.
      buttonIsClickable = false;
    });
  }
  colorDisabledFour(){
    setState(() {
      _disableButtonFour = true;
      /// Change text in card when Post is made.
      textHolder = 'You marked this Location as?';
      /// Disable all buttons.
      buttonIsClickable = false;
    });
  }


  /// To determine which button to enable when stop is already defined.
  enableCorrectButton() {
    if (stopStatus == "Loading_Point") {
      setState(() {
        _colorButtonOne = true;
      });
    }
    if (stopStatus == "Unloading_Point") {
      setState(() {
        _colorButtonTwo = true;
      });
    }
    if (stopStatus == "Parking") {
      setState(() {
        _colorButtonThree = true;
      });
    }
    if (stopStatus == "Maintenance") {
      setState(() {
        _colorButtonFour = true;
      });
    }
  }

  void initFunction() {
    setState(() {
      validAddress = widget.validAddress;
      validStop = widget.validStop;
      truckId = widget.truckId;
      TruckNo = widget.TruckNo;
      imei = widget.imei;
      truckStatus = widget.truckStauts;
      stopStatus = widget.stopStatus;
    });
    enableCorrectButton();
  }

  @override
  void initState() {
    super.initState();
    initFunction();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        child:
        (truckStatus == true) ?
        Card(elevation: 5,
                child: Column(
                  children: [
                    Container(
                      child: ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        trailing:
                            Image.asset('assets/icons/gmaps.png', scale: 2),
                        onTap: (){
                          Get.to(
                            showStopOnMap(
                              validStop: validStop,
                              validAddress: validAddress,
                            )
                          );
                        },
                        title: Text(
                          "$validAddress",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$textHolder",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                                width: 50,
                                child: ElevatedButton(
                                    onPressed: buttonIsClickable ? () {
                                            postRouteData(
                                              "$validAddress",
                                              "Loading_Point",
                                              validStop,
                                            );
                                            colorDisabledOne();
                                          } : null,
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(0)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states.contains(MaterialState.disabled))
                                            return _disableButtonOne ? Color.fromRGBO(9, 183, 120, 1) : Color.fromRGBO(205, 205, 205, 1);
                                          return bidBackground;
                                        },
                                      ),
                                    ),
                                    child: Text(
                                      "Loading",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: _disableButtonOne ? Colors.white : Colors.grey[250]),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                                width: 60,
                                child: ElevatedButton(
                                    onPressed: buttonIsClickable
                                        ? () {
                                            postRouteData("$validAddress",
                                                "Unloading_Point", validStop);
                                            colorDisabledTwo();
                                          }
                                        : null,
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(0)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return _disableButtonTwo ? Color.fromRGBO(9, 183, 120, 1) : Color.fromRGBO(205, 205, 205, 1);
                                          return bidBackground;
                                        },
                                      ),
                                    ),
                                    child: Text(
                                      "Unloading",
                                      style: TextStyle(fontSize: 10,
                                          color: _disableButtonTwo ? Colors.white : Colors.grey[250]),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                width: 50,
                                child: ElevatedButton(
                                    onPressed: buttonIsClickable ? () {
                                            postRouteData(
                                                "${validAddress}",
                                                "Parking",
                                                validStop);
                                                colorDisabledThree();
                                          } : null,
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(0)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return _disableButtonThree ? Color.fromRGBO(9, 183, 120, 1) : Color.fromRGBO(205, 205, 205, 1);
                                          return bidBackground;
                                        },
                                      ),
                                    ),
                                    child: Text(
                                      "Parking",
                                      style: TextStyle(fontSize: 10,
                                          color: _disableButtonThree ? Colors.white : Colors.grey[250]),
                                    )
                                ),
                              ),
                              SizedBox(
                                height: 15,
                                width: 75,
                                child: ElevatedButton(
                                    onPressed: buttonIsClickable
                                        ? () {
                                            postRouteData(
                                                "${validAddress}",
                                                "Maintenance",
                                                validStop);
                                                colorDisabledFour();
                                          } : null,
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.all(0)),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.disabled))
                                            return _disableButtonFour ? Color.fromRGBO(9, 183, 120, 1) : Color.fromRGBO(205, 205, 205, 1);
                                          return bidBackground;
                                        },
                                      ),
                                    ),
                                    child: Text(
                                      "Maintenance",
                                      style: TextStyle(fontSize: 10,
                                      color: _disableButtonFour ? Colors.white : Colors.grey[250]),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Card(
                elevation: 5,
                child: Column(
                  children: [
                    Container(
                      child: ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        trailing:
                            Image.asset('assets/icons/gmaps.png', scale: 2),
                        onTap: (){
                          Get.to(
                              showStopOnMap(
                                validStop: validStop,
                                validAddress: validAddress,)
                          );
                        },
                        title: Text(
                          "${validAddress}",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You marked this location as? ",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 15,
                                  width: 50,
                                  child: ElevatedButton(
                                      onPressed: _colorButtonOne ? () {} : null,
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromRGBO(9, 183, 120, 1),
                                        padding: EdgeInsets.all(0),
                                      ),
                                      child: Text(
                                        "Loading",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 60,
                                  child: ElevatedButton(
                                      onPressed: _colorButtonTwo ? () {} : null,
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(9, 183, 120, 1),
                                          padding: EdgeInsets.all(0)),
                                      child: Text(
                                        "Unloading",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 50,
                                  child: ElevatedButton(
                                      onPressed:
                                          _colorButtonThree ? () {} : null,
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(9, 183, 120, 1),
                                          padding: EdgeInsets.all(0)),
                                      child: Text(
                                        "Parking",
                                        style: TextStyle(fontSize: 10),
                                      )),
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 75,
                                  child: ElevatedButton(
                                      onPressed:
                                          _colorButtonFour ? () {} : null,
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(9, 183, 120, 1),
                                          padding: EdgeInsets.all(0)),
                                      child: Text(
                                        "Maintenance",
                                        style: TextStyle(fontSize: 10),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
    );
  }
}
