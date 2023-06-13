import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../functions/transporterApis/transporterApiCalls.dart';
import '../../models/transporterModel.dart';
import '/constants/spaces.dart';
import '/functions/shipperApis/shipperApiCalls.dart';
import '/models/biddingModel.dart';
import '/providerClass/providerData.dart';
import '/widgets/Header.dart';
import '/widgets/biddingsCardShipperSide.dart';
import '/widgets/loadingWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shipper_app/Widgets/loadingWidget.dart';


class BiddingScreens extends StatefulWidget {
  final String? loadId;
  final String? loadingPointCity;
  final String? unloadingPointCity;

  BiddingScreens(
      {required this.loadId,
        required this.loadingPointCity,
        required this.unloadingPointCity});

  @override
  _BiddingScreensState createState() => _BiddingScreensState();
}

class _BiddingScreensState extends State<BiddingScreens> {
  // final String biddingApiUrl = FlutterConfig.get('biddingApiUrl');
  final String biddingApiUrl = dotenv.get('biddingApiUrl');

  int i = 0;

  late List jsonData;

  bool loading = false;

  //Scroll Controller for Pagination
  ScrollController scrollController = ScrollController();

  ShipperApiCalls shipperApiCalls = ShipperApiCalls();
  TransporterApiCalls transporterApiCalls = TransporterApiCalls();

  List<BiddingModel> biddingModelList = [];
  List<TransporterModel> transporterModelList = [];

  getBidDataByLoadId(int i) async {
    http.Response response = await http
        .get(Uri.parse('$biddingApiUrl?loadId=${widget.loadId}&pageNo=$i'));

    jsonData = json.decode(response.body);

    for (var json in jsonData) {
      BiddingModel biddingModel = BiddingModel();
      TransporterModel transporterModel = TransporterModel();

      biddingModel.bidId = json['bidId'] != null ? json['bidId'] : 'Na';
      biddingModel.transporterId =
      json['transporterId'] != null ? json['transporterId'] : 'Na';
      biddingModel.currentBid =
      json['currentBid'] == null ? 'NA' : json['currentBid'].toString();
      biddingModel.previousBid =
      json['previousBid'] == null ? 'NA' : json['previousBid'].toString();
      biddingModel.unitValue =
      json['unitValue'] != null ? json['unitValue'] : 'Na';
      biddingModel.loadId = json['loadId'] != null ? json['loadId'] : 'Na';
      biddingModel.biddingDate =
      json['biddingDate'] != null ? json['biddingDate'] : 'NA';
      biddingModel.truckIdList =
      json['truckId'] != null ? json['truckId'] : 'Na';
      biddingModel.transporterApproval = json['transporterApproval'];
      biddingModel.shipperApproval = json['shipperApproval'];

      transporterModel = await transporterApiCalls.getDataByTransporterId(biddingModel.transporterId);

      setState(() {
        loading = true;
        transporterModelList.add(transporterModel);
        biddingModelList.add(biddingModel);
      });
    }

    // print("transporterModelList.length ${transporterModelList.length}");
    loading = false;
  }

  @override
  void initState() {
    super.initState();

    loading = true;

    getBidDataByLoadId(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        i = i + 1;
        getBidDataByLoadId(i);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        providerData.updateBidEndpoints(
            widget.loadingPointCity, widget.unloadingPointCity));
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: space_4, horizontal: space_4),
            child: Column(
              children: [
                Header(
                    reset: false,
                    text: 'bids'.tr,
                    // 'Biddings',
                    backButton: true),
                Container(
                  margin: EdgeInsets.only(top: space_1),
                  height: MediaQuery.of(context).size.height * 0.83,
                  child: loading
                      ? LoadingWidget()
                      : biddingModelList.isEmpty
                        ? Text(
                        'noBid'.tr,
                  // 'No bids yet'
                    ) :
                  ListView.builder(
                      controller: scrollController,
                      itemCount: biddingModelList.length,
                      itemBuilder: (context, index) {

                        return BiddingsCardShipperSide(
                          loadId: widget.loadId,
                          loadingPointCity: widget.loadingPointCity,
                          unloadingPointCity: widget.unloadingPointCity,
                          currentBid: biddingModelList[index].currentBid,
                          previousBid: biddingModelList[index].previousBid,
                          unitValue: biddingModelList[index].unitValue,
                          companyName: transporterModelList[index].companyName,
                          biddingDate: biddingModelList[index].biddingDate,
                          bidId: biddingModelList[index].bidId,
                          transporterPhoneNum:
                          transporterModelList[index].transporterPhoneNum,
                          transporterLocation:
                          transporterModelList[index].transporterLocation,
                          transporterName: transporterModelList[index].transporterName,
                          shipperApproved:
                          biddingModelList[index].shipperApproval,
                          transporterApproved:
                          biddingModelList[index].transporterApproval,
                          isLoadPosterVerified:
                          transporterModelList[index].companyApproved,
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
} //class end