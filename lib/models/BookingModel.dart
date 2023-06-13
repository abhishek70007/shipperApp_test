class BookingModel {
  String? bookingId;
  String? loadId;
  String? shipperId;
  String? postLoadId;
  List? truckId;
  String? loadingPointCity;
  String? unloadingPointCity;
  String? truckNo;
  String? driverName;
  String? driverPhoneNum;
  String? rate;
  String? rateString;
  String? unitValue;
  bool? cancel;
  bool? completed;
  String? bookingDate;
  String? completedDate;
  int? deviceId;

  BookingModel(
      {this.bookingId,
      this.loadId,
      this.shipperId,
      this.postLoadId,
      this.truckId,
      this.rate,
      this.unitValue,
      this.cancel,
      this.completed,
      this.bookingDate,
      this.completedDate,
      this.rateString,
      this.deviceId,
      this.unloadingPointCity,
      this.loadingPointCity,
      this.truckNo,
      this.driverName,
      this.driverPhoneNum});
}
