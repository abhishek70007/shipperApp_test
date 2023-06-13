class DeliveredCardModel{
  String? bookingId;
  String? loadingPointCity;
  String? unloadingPointCity;
  String? companyName;
  String? transporterPhoneNum;
  String? transporterLocation;
  String? transporterName;
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

  DeliveredCardModel(
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
        this.transporterLocation,
        this.transporterName,
        this.transporterPhoneNum,
        this.truckNo,
        this.truckType,
        this.unloadingPointCity
      });
}