class LoadPosterModel {
  String? loadPosterId;
  String? loadPosterPhoneNo;
  String? loadPosterLocation;
  String? loadPosterName;
  String? loadPosterCompanyName;
  String? loadPosterKyc;
  bool? loadPosterCompanyApproved;
  bool? loadPosterApproved;
  bool? loadPosterAccountVerificationInProgress;

  LoadPosterModel(
      {this.loadPosterId,
      this.loadPosterPhoneNo,
      this.loadPosterLocation,
      this.loadPosterName,
      this.loadPosterCompanyName,
      this.loadPosterKyc,
      this.loadPosterCompanyApproved,
      this.loadPosterApproved,
      this.loadPosterAccountVerificationInProgress});
}
