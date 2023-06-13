class GpsDataModelForHistory {
  String? gpsSpeed;
  String? satellite;
  double? lat;
  double? lng;
  String? gpsTime;
  String? direction;
  String? posType;
  String? address;
  String? duration;
  String? startTime;
  String? endTime;
  String? truckStatus;
  double? distanceCovered;
  double? totalDistanceCovered;

  GpsDataModelForHistory(
      {
        this.gpsSpeed,
        this.satellite,
        this.lat,
        this.lng,
        this.gpsTime,
        this.direction,
        this.posType,
        this.address,
        this.duration,
        this.startTime,
        this.endTime,
        this.truckStatus,
        this.distanceCovered,
        this.totalDistanceCovered,
      });
}