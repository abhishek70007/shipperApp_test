import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DeviceModel {
  
  int? deviceId;
  String? truckno;
  String? imei;
  String? status;
  String? lastUpdate;
  String? phone;
  String? model;
  String? contact;
  String? category;

  DeviceModel(
      {this.deviceId,
        this.truckno,
        this.imei,
        this.status,
        this.lastUpdate,
        this.phone,
        this.model,
        this.contact,
        this.category
      });
}
