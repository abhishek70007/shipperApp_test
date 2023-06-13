class OngoingCardModel{
  String? bookingId;
  String? loadingPointCity;
  String? unloadingPointCity;
  String? companyName;
  String? shipperPhoneNum;
  String? shipperLocation;
  String? shipperName;
  bool? transporterApproved;
  bool? companyApproved;
  String? truckNo;
  String? truckType;
  String? imei;
  String? driverName;
  String? driverPhoneNum;
  String? rate;
  String? unitValue;
  String? noOfTrucks;
  String? productType;
  String? bookingDate;
  String? completedDate;
  int? deviceId;

  OngoingCardModel(
      {this.bookingId,
        this.imei,
        this.unitValue,
        this.bookingDate,
        this.companyApproved,
        this.companyName,
        this.completedDate,
        this.driverName,
        this.driverPhoneNum,
        this.loadingPointCity,
        this.noOfTrucks,
        this.productType,
        this.rate,
        this.transporterApproved,
        this.shipperLocation,
        this.shipperName,
        this.shipperPhoneNum,
        this.truckNo,
        this.truckType,
        this.unloadingPointCity,
        this.deviceId
      });
}