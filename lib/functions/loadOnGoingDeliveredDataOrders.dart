import '/functions/postLoadIdApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/BookingModel.dart';
import '/models/driverModel.dart';
import 'driverApiCalls.dart';
import 'loadApiCalls.dart';

final LoadApiCalls loadApiCalls = LoadApiCalls();

final PostLoadIdApiCalls postLoadIdApiCalls = PostLoadIdApiCalls();

final TruckApiCalls truckApiCalls = TruckApiCalls();

final DriverApiCalls driverApiCalls = DriverApiCalls();

Future<Map> loadAllDataOrders(BookingModel bookingModel) async {
  Map loadDetails;
  Map postLoadIdData;

  if (bookingModel.loadId != 'NA') {
    loadDetails = await loadApiCalls.getDataByLoadId(bookingModel.loadId!);
  } else {
    loadDetails = {
      'loadingPointCity': 'NA',
      'unloadingPointCity': 'NA',
      'truckType': 'NA',
      'productType': 'NA',
      'noOfTrucks': 'NA',
    };
  }

  if (bookingModel.postLoadId != 'NA') {
    postLoadIdData = bookingModel.postLoadId![0] == "t"
        ? await postLoadIdApiCalls
            .getDataByShipperId(bookingModel.postLoadId!)
        : await postLoadIdApiCalls.getDataByShipperId(bookingModel.postLoadId!);
  } else {
    postLoadIdData = {
      'companyName': 'NA',
      'posterPhoneNum': '',
      'posterName': 'NA',
      "posterLocation": 'NA',
      "companyApproved": false
    };
  }

  Map truckData =
      await truckApiCalls.getDataByTruckId(bookingModel.truckId![0]);

  DriverModel driverModel =
      await driverApiCalls.getDriverByDriverId(driverId: truckData['driverId']);

  Map cardDataModel = {
    'unitValue': bookingModel.unitValue == null ? "NA" : bookingModel.unitValue,
    'startedOn': bookingModel.bookingDate,
    'endedOn': bookingModel.completedDate,
    'loadingPoint': loadDetails['loadingPointCity'] == null
        ? "NA"
        : loadDetails['loadingPointCity'],
    'unloadingPoint': loadDetails['unloadingPointCity'] == null
        ? "NA"
        : loadDetails['unloadingPointCity'],
    'truckType':
        truckData['truckType'] == null ? "NA" : truckData['truckType'],
    'productType':
        loadDetails['productType'] == null ? "NA" : loadDetails['productType'],
    'noOfTrucks':
        loadDetails['noOfTrucks'] == null ? "NA" : loadDetails['noOfTrucks'],
    'rate': bookingModel.rateString,
    'bookingId': bookingModel.bookingId,
    // 'transporterName' : transporterData['transporterName'],
    'posterPhoneNum': postLoadIdData['posterPhoneNum'] == null
        ? "NA"
        : postLoadIdData['posterPhoneNum'],
    'posterLocation': postLoadIdData['posterLocation'] == null
        ? "NA"
        : postLoadIdData['posterLocation'],
    'companyName': postLoadIdData['companyName'] == null
        ? "NA"
        : postLoadIdData['companyName'],
    "companyApproved": postLoadIdData['companyApproved'] == null
        ? false
        : postLoadIdData['companyApproved'],
    'posterName': postLoadIdData['posterName'] == null
        ? "NA"
        : postLoadIdData['posterName'],
    'truckNo': truckData['truckNo'] == null ? "NA" : truckData['truckNo'],
    'imei': "truckData['imei']",
    'driverName':
        driverModel.driverName == null ? "NA" : driverModel.driverName,
    'driverPhoneNum': driverModel.phoneNum == null ? "NA" : driverModel.phoneNum
  };

  return cardDataModel;
}
