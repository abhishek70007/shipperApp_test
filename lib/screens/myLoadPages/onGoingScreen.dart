import 'package:flutter/material.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/functions/bookingApi/getOngoingDataWithPageNo.dart';
import '/models/onGoingCardModel.dart';
import '/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';
import '/widgets/loadingWidgets/onGoingLoadingWidgets.dart';
import '/widgets/onGoingCard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class OngoingScreen extends StatefulWidget {
  @override
  _OngoingScreenState createState() => _OngoingScreenState();
}

class _OngoingScreenState extends State<OngoingScreen> {
  //Scroll Controller for Pagination
  ScrollController scrollController = ScrollController();

  bool loading = true; //false
  DateTime yesterday =
      DateTime.now().subtract(Duration(days: 1, hours: 5, minutes: 30));
  late String from;
  late String to;
  DateTime now = DateTime.now().subtract(Duration(hours: 5, minutes: 30));

  //for counting page numbers
  int i = 0;

  bool OngoingProgress = true;

  final String bookingApiUrl = dotenv.get('bookingApiUrl');

  List<OngoingCardModel> modelList = [];

  getDataByPostLoadIdOnGoing(int i) async {
    if (this.mounted) {
      setState(() {
        OngoingProgress = true;
      });
    }
    var bookingDataListWithPagei = await getOngoingDataWithPageNo(i);
    for (var bookingData in bookingDataListWithPagei) {
      modelList.add(bookingData);
    }

    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        loading = false;

        OngoingProgress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    from = yesterday.toIso8601String();
    to = now.toIso8601String();
    getDataByPostLoadIdOnGoing(i);
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent * 0.7) {
        i = i + 1;
        getDataByPostLoadIdOnGoing(i);
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
                        'noOnGoingLoad'.tr,
                        // 'Looks like you have not added any Loads!',
                        style: TextStyle(fontSize: size_8, color: grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : modelList.length > 0
                  ? RefreshIndicator(
                      color: lightNavyBlue,
                      onRefresh: () {
                        setState(() {
                          modelList.clear();
                          loading = true;
                        });
                        return getDataByPostLoadIdOnGoing(0);
                      },
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(bottom: space_15),
                          itemCount: modelList.length,
                          itemBuilder: (context, index) {
                            return (index == modelList.length)
                                ? Visibility(
                                    visible: OngoingProgress,
                                    child: bottomProgressBarIndicatorWidget())
                                : (index < modelList.length)
                                    ? OngoingCard(
                                        loadAllDataModel: modelList[index],
                                      )
                                    : Container();
                          }),
                    )
                  : Container(),
    );
  }
} //class end
