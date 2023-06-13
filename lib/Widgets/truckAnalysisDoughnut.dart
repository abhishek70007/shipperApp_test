import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import '/controller/analysisDataController.dart';
import '/models/analysisData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class truckAnalysisDoughnut extends StatefulWidget {
  @override
  _truckAnalysisDoughnutState createState() => _truckAnalysisDoughnutState();
}

class _truckAnalysisDoughnutState extends State<truckAnalysisDoughnut> {
  // Controller for the data source.
  AnalysisDataController analysisDataController =
      Get.put(AnalysisDataController());

  @override
  void initState() {
    super.initState();
  }

  /// Actual Data that is passed in the dougnut.
  List<analysisData> getChartData() {
    final List<analysisData> chartData = [
      analysisData('loading', analysisDataController.loadingPointData.value,
          Color.fromRGBO(75, 134, 184, 1)),
      analysisData('unloading', analysisDataController.unLoadingPointData.value,
          Color.fromRGBO(192, 108, 132, 1)),
      analysisData('parking', analysisDataController.parkingData.value,
          Color.fromRGBO(255, 105, 180, 1)),
      analysisData('maintenance', analysisDataController.maintenanceData.value,
          Color.fromRGBO(246, 211, 198, 1)),
      analysisData('running', analysisDataController.runningTimeData.value,
          Color.fromRGBO(0, 204, 0, 1)),
      analysisData('stop', analysisDataController.unknownStopData.value,
          Color.fromRGBO(230, 0, 0, 1))
    ];
    return chartData;
  }

  /// Custom Get Duration.
  getDuration(int time) {
    var formatted;
    var time2Dateformat = new Duration(
        days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: time);
    var days = time2Dateformat.inDays;
    String time2 = time2Dateformat.toString();
    var time3 = new DateFormat("HH:mm:ss").parse(time2).toString();
    var dur = time3.substring(0, time3.indexOf('.'));
    var timestamp = dur
        .toString()
        .replaceAll("-", "")
        .replaceAll(":", "")
        .replaceAll(" ", "");
    var hour = int.parse(timestamp.substring(8, 10));
    var minute = int.parse(timestamp.substring(10, 12));
    var second = int.parse(timestamp.substring(12, 14));
    if (days == 0) {
      if (hour == 0 && second == 0)
        formatted = "$minute min";
      else if (second == 0)
        formatted = "$hour hr $minute min";
      else if (hour == 0)
        formatted = "$minute min";
      else
        formatted = "$hour hr $minute min ";
    } else {
      if (hour == 0 && second == 0)
        formatted = "$days day $minute min";
      else if (minute == 0)
        formatted = "$days day";
      else if (second == 0)
        formatted = "$days day $hour hr $minute min";
      else if (hour == 0)
        formatted = "$days day $minute min";
      else
        formatted = "$days day $hour hrs";
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Container(
              height: 200,
              child: Obx(
                () => SfCircularChart(
                  // legend: Legend(isVisible: true,
                  // overflowMode: LegendItemOverflowMode.scroll),
                  series: <CircularSeries>[
                    DoughnutSeries<analysisData, String>(
                        dataSource: getChartData(),
                        xValueMapper: (analysisData data, _) => data.type,
                        yValueMapper: (analysisData data, _) => data.time,
                        pointColorMapper: (analysisData data, _) => data.color)
                  ],
                ),
              )),
          Container(
              margin: EdgeInsets.all(10),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/loading.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.loadingPointData.value)} Loading',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/unloading.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.unLoadingPointData.value)} UnLoading',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/running.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.runningTimeData.value)} Running',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/parking.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.parkingData.value)} Parking',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/maintenance.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.maintenanceData.value)} Maintenance',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //componenet
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/icons/stop.png',
                                  scale: 2.5,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${getDuration(analysisDataController.unknownStopData.value)} Stop',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ])
                    ]),
              ]))
        ],
      ),
    ));
  }
}
