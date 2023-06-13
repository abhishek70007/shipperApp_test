class WidgetLoadDetailsScreenModel {
  String? loadPosterId;
  String? phoneNo;
  String? loadPosterLocation;
  String? loadPosterName;
  String? loadPosterCompanyName;
  String? loadPosterKyc;
  bool? loadPosterCompanyApproved;
  bool? loadPosterApproved;

  WidgetLoadDetailsScreenModel(
      {this.loadPosterId,
        this.phoneNo,
        this.loadPosterLocation,
        this.loadPosterName,
        this.loadPosterCompanyName,
        this.loadPosterKyc,
        this.loadPosterCompanyApproved,
        this.loadPosterApproved,});
}
