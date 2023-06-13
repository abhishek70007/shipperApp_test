import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/models/CellInfoModel.dart';

class OpenCellId extends StatefulWidget {
  @override
  _OpenCellIDState createState() => _OpenCellIDState();
}

class _OpenCellIDState extends State<OpenCellId> {
  String _signalStrength = 'Not Found';
  var cellInfoList = [];
  static const platform = MethodChannel('livelocation.flutter.dev/simlocation');
  CellInfoModel cellInfoModel = CellInfoModel();
  String? radio;
  int? mcc;
  int? mnc;
  int? signalstrength;
  int? lac;
  int? cid;
  int? psc;

  Future<void> _getSignalStrength() async {
    String signal;
    try {
      final String result = await platform.invokeMethod('getKotlinLocation');
      signal = result;
      print("this is signal result from try $signal");
      var useCellInfo = jsonDecode(signal);
      mcc = cellInfoModel.mcc = useCellInfo["mcc"] != null ? useCellInfo["mcc"] : 0;
      mnc = cellInfoModel.mnc = useCellInfo["mnc"] != null ? useCellInfo["mnc"] : 0;
      signalstrength = cellInfoModel.signal = useCellInfo["signal"] != null ? useCellInfo["signal"] : 0;
      radio = cellInfoModel.radio = useCellInfo["radio"] != null ? useCellInfo["radio"] : 'NA';
      lac = cellInfoModel.lac = useCellInfo["cells"][0]["lac"] != null ? useCellInfo["cells"][0]["lac"] : 0;
      psc = cellInfoModel.psc = useCellInfo["cells"][0]["psc"] != null ? useCellInfo["cells"][0]["psc"] : 0;
      cid = cellInfoModel.cid = useCellInfo["cells"][0]["cid"] != null ? useCellInfo["cells"][0]["cid"] : 0;
      print("MCC is ${cellInfoModel.mcc}");
      print("mnc is ${cellInfoModel.mnc}");
      print("signal is ${cellInfoModel.signal}");
      print("radio is ${cellInfoModel.radio}");
      print("lac is ${cellInfoModel.lac}");
      print("psc is ${cellInfoModel.psc}");
      print("CID is ${cellInfoModel.cid}");
    } on PlatformException catch (e) {
      signal = "'${e.message}'.";
      print("this is signal result from catch $signal");
    }
  }

  @override
  void initState() {
    super.initState();
    _getSignalStrength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signal Detector'),
      ),
      body: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              _getSignalStrength();
            },
            child: Text('Signal'),
          ),
          Text("Signal:"),
          Text(_signalStrength),
        ],
      ),
    );
  }
}