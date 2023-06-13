class ShipperModel {
  //parameters
  String? shipperId;
  String? shipperPhoneNum;
  String? shipperLocation;
  String? shipperName;
  String? companyName;
  String? kyc;
  bool? companyApproved;
  bool? accountVerificationInProgress;

  ShipperModel(
      {this.shipperPhoneNum,
      this.companyName,
      this.shipperId,
      this.shipperName,
      this.accountVerificationInProgress,
      this.companyApproved,
      this.kyc,
      this.shipperLocation});
}
