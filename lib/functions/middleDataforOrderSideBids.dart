import '/functions/getRequestorDetailsFromPostLoadId.dart';
import '/models/loadPosterModel.dart';


import 'loadApiCalls.dart';

Future<Map> middleDataForOrderSideBids({loadId}) async {

  final LoadApiCalls loadApiCalls = LoadApiCalls();



  Map loadData = await loadApiCalls.getDataByLoadId(loadId);
  LoadPosterModel loadPosterModel = await getLoadPosterDetailsFromPostLoadId(loadData['postLoadId']);

  Map middleData = {
    'loadingPointCity' : loadData['loadingPointCity'],
    'unloadingPointCity' : loadData['unloadingPointCity'],
    'noOfTrucks' : loadData['noOfTrucks'],
    'productType' : loadData['productType'],
    'postLoadId' : loadData['postLoadId'],
    'loadPosterModel' : loadPosterModel
  };

  return middleData;
}