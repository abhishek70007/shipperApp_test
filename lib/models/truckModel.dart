class TruckModel {
  int? passingWeight;
  String? passingWeightString;
  String? tyres;
  int? truckLength;
  String? truckLengthString;
  String? truckId;
  String? transporterId;
  String? truckNo;
  String? imei;
  int? deviceId;
  String? driverId;
  String? truckType;
  String? driverName;
  String? driverNum;
  bool? truckApproved;

  TruckModel(
      {
        this.truckId,
        this.transporterId,
        this.truckNo,
        this.truckApproved,
        this.imei,
        this.deviceId,
        this.passingWeight,
        this.truckLengthString,
        this.passingWeightString,
        this.truckType,
        this.driverId,
        this.tyres,
        this.driverName,
        this.driverNum});
}
