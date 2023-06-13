import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/functions/loadApis/runSuggestedLoadApiWithPageNo.dart';
import '/models/loadDetailsScreenModel.dart';
import '/widgets/homeScreenLoadsCard.dart';
import '/widgets/loadingWidgets/bottomProgressBarIndicatorWidget.dart';

// ignore: must_be_immutable
class SuggestedLoadsWidget extends StatefulWidget {
  @override
  _SuggestedLoadsWidgetState createState() => _SuggestedLoadsWidgetState();
}

class _SuggestedLoadsWidgetState extends State<SuggestedLoadsWidget> {
  //Scroll Controller for Pagination
  ScrollController scrollController = ScrollController();

  //for pageNo
  int i = 0;

  //list for load models
  List<LoadDetailsScreenModel> data = [];

  //API CALL--------------------------------------------------------------------
  runSuggestedLoadApi(int i) async {
    if (this.mounted) {
      var suggestedLoadDataList = await runWidgetSuggestedLoadApiWithPageNo(i);
      for (var suggestedLoadData in suggestedLoadDataList) {
        setState(() {
          data.add(suggestedLoadData);
        });
      }
    }
  }

  //API CALL--------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    runSuggestedLoadApi(i);

    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent * 0.7) {
        i = i + 1;
        runSuggestedLoadApi(i);
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
    return data.isEmpty
        ? Center(
            child: CircularProgressIndicator(color: darkBlueColor),
          )
        : RefreshIndicator(
            color: lightNavyBlue,
            onRefresh: () {
              setState(() {
                data.clear();
              });
              return runSuggestedLoadApi(0);
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: data.length + 1,
              itemBuilder: (context, index) => index == data.length
                  ? bottomProgressBarIndicatorWidget()
                  : HomeScreenLoadsCard(
                      loadDetailsScreenModel: data[index],
                    ),
            ),
          );
  }
}
