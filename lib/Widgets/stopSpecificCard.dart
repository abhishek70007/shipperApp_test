import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '/widgets/showStopOnMap.dart';


class stopSpecificCard extends StatefulWidget {

  var validAddress;
  var validStop;
  var stopStatus;
  var show;

  stopSpecificCard({
    required this.validStop,
    required this.validAddress,
    required this.stopStatus,
    required this.show
  });

  @override
  _stopSpecificCardState createState() => _stopSpecificCardState();
}

class _stopSpecificCardState extends State<stopSpecificCard> {

  var validAddress;
  var validStop;
  var stopStatus;
  var show;

  void initFunction() {
    validAddress = widget.validAddress;
    validStop = widget.validStop;
    stopStatus = widget.stopStatus;
    show = widget.show;
  }

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    return
      stopStatus == show ? Container(
          child: Card(
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
                                  onPressed: stopStatus == "Loading_Point" ? (){} : null,
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
                                  onPressed: stopStatus == "Unloading_Point" ? (){} : null,
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
                                  onPressed: stopStatus == "Parking" ? (){} : null,
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
                                  onPressed: stopStatus == "Maintenance" ? (){} : null,
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
      ) : Container();
  }

}
