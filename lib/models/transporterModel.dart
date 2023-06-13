class TransporterModel {
  //parameters
  String? transporterId;
  String? transporterPhoneNum;
  String? transporterLocation;
  String? transporterName;
  String? companyName;
  String? kyc;
  bool? transporterApproved;
  bool? companyApproved;
  bool? accountVerificationInProgress;

  TransporterModel(
      {this.transporterPhoneNum,
      this.companyName,
      this.transporterId,
      this.transporterName,
      this.accountVerificationInProgress,
      this.companyApproved,
      this.kyc,
      this.transporterApproved,
      this.transporterLocation});
}
