import 'package:flutter/material.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/controller/shipperIdController.dart';
import '/functions/bookingApi/getDeliveredDataWithPageNo.dart';
import '/models/deliveredCardModel.dart';
import '/widgets/deliveredCard.dart';
import '/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';
import '/widgets/loadingWidgets/onGoingLoadingWidgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeliveredScreen extends StatefulWidget {
  @override
  _DeliveredScreenState createState() => _DeliveredScreenState();
}

class _DeliveredScreenState extends State<DeliveredScreen> {
  //for counting page numbers
  int i = 0;
  bool loading = false;
  bool DeliveredProgress = false;

  ShipperIdController shipperIdController =
      Get.put(ShipperIdController());

  // final String bookingApiUrl = FlutterConfig.get('bookingApiUrl');
  final String bookingApiUrl = dotenv.get('bookingApiUrl');


  List<DeliveredCardModel> modelList = [];

  ScrollController scrollController = ScrollController();

  getDataByPostLoadIdDelivered(int i) async {

    if (this.mounted) {
      setState(() {
        DeliveredProgress = true;
      });
    }
    var bookingDataListWithPagei = await getDeliveredDataWithPageNo(i);
    for (var bookingData in bookingDataListWithPagei) {
      modelList.add(bookingData);
    }
    if (this.mounted) {
      setState(() {
        loading = false;
        DeliveredProgress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    getDataByPostLoadIdDelivered(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent * 0.7) {
        i = i + 1;
        getDataByPostLoadIdDelivered(i);
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
    return Container(
      height: MediaQuery.of(context).size.height -
          kBottomNavigationBarHeight -
          space_8,
      child: loading
          ? OnGoingLoadingWidgets()
          : modelList.length == 0
              ? Container(
                  margin: EdgeInsets.only(top: 153),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/images/EmptyLoad.png'),
                        height: 127,
                        width: 127,
                      ),
                      Text(
                        'stoppedLoad'.tr,
                        // 'Looks like you have not added any Loads!',
                        style: TextStyle(fontSize: size_8, color: grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: lightNavyBlue,
                  onRefresh: () {
                    setState(() {
                      modelList.clear();
                      loading = true;
                    });
                    return getDataByPostLoadIdDelivered(0);
                  },
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: space_15),
                      controller: scrollController,
                      itemCount: modelList.length,
                      itemBuilder: (context, index) =>
                          (index == modelList.length - 1)
                              ? Visibility(
                                  visible: DeliveredProgress,
                                  child: bottomProgressBarIndicatorWidget())
                              : DeliveredCard(
                                  model: modelList[index],
                                )
                      // {
                      //   return  DeliveredCard(
                      //           model: modelList[index],
                      //         );
                      // } //builder
                      ),
                ),
    );
  }
} //class end
