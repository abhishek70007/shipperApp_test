class BiddingModel{
  String? bidId;
  String? transporterId;
  String? currentBid;
  String? previousBid;
  String? unitValue;
  String? loadId;
  String? biddingDate;
  List? truckIdList;
  bool? transporterApproval;
  bool? shipperApproval;
  String? loadingPointCity;
  String? unloadingPointCity;
  String? noOfTrucks;
  String? productType;
  String? postLoadId;
  String? loadPosterCompanyName;
  String? loadPosterPhoneNo;
  String? loadPosterLocation;
  String? loadPosterName;
  bool? loadPosterCompanyApproved;

  BiddingModel(
      {
        this.loadId,
        this.transporterId,
        this.unitValue,
        this.currentBid,
        this.previousBid,
        this.biddingDate,
        this.bidId,
        this.shipperApproval,
        this.transporterApproval,
        this.truckIdList,
        this.loadingPointCity,
        this.unloadingPointCity,
        this.noOfTrucks,
        this.productType,
        this.postLoadId,
        this.loadPosterCompanyName,
        this.loadPosterPhoneNo,
        this.loadPosterLocation,
        this.loadPosterName,
        this.loadPosterCompanyApproved,
      }
      );
}