import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GpsDataModel {
  double? speed;
  double? latitude;
  double? longitude;
  double? endLat;
  double? endLon;
  int? deviceId;
  int? rssi;
  bool? ignition;
  double? course;
  String? deviceTime;
  String? serverTime;
  String? fixTime;
  double? distance;
  String? id;
  String? address;
  int? duration;
  String? startTime;
  String? endTime;
  bool? motion;
  String? result;

  GpsDataModel({
    this.speed,
    this.id,
    this.address,
    this.deviceId,
    this.rssi,
    this.latitude,
    this.longitude,
    this.endLat,
    this.endLon,
    this.course,
    this.deviceTime,
    this.serverTime,
    this.fixTime,
    this.distance,
    this.duration,
    this.startTime,
    this.endTime,
    this.motion,
    this.ignition,
    this.result,
  });
}
