import 'package:flutter/material.dart';
import '../../functions/shipperApis/shipperApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/BookingModel.dart';
import '/models/driverModel.dart';
import '/models/onGoingCardModel.dart';
import '/models/shipperModel.dart';
// import 'driverApiCalls.dart';
// import 'loadApiCalls.dart';

//TODO:later on ,put these variables inside the function
// LoadApiCalls loadApiCalls = LoadApiCalls();

ShipperApiCalls shipperApiCalls = ShipperApiCalls();

// TruckApiCalls truckApiCalls = TruckApiCalls();

// DriverApiCalls driverApiCalls = DriverApiCalls();

Future<OngoingCardModel?> loadAllOnGoingOrdersData(
    BookingModel bookingModel) async {
  // Map loadData = await loadApiCalls.getDataByLoadId(bookingModel.loadId!);
  // TransporterModel transporterModel = await ShipperApiCalls
  //     .getDataByShipperId(bookingModel.transporterId);

  ShipperModel transporterModel =
      await shipperApiCalls.getDataByShipperId(bookingModel.postLoadId);

  OngoingCardModel loadALLDataModel = OngoingCardModel();
  loadALLDataModel.bookingDate = bookingModel.bookingDate;
  loadALLDataModel.bookingId = bookingModel.bookingId;
  loadALLDataModel.completedDate = bookingModel.completedDate;
  loadALLDataModel.deviceId = bookingModel.deviceId;
  loadALLDataModel.loadingPointCity = bookingModel.loadingPointCity;
  loadALLDataModel.unloadingPointCity = bookingModel.unloadingPointCity;
  loadALLDataModel.companyName = transporterModel.companyName;
  loadALLDataModel.shipperPhoneNum = transporterModel.shipperPhoneNum;
  loadALLDataModel.shipperLocation = transporterModel.shipperLocation;
  loadALLDataModel.shipperName = transporterModel.shipperName;
  loadALLDataModel.companyApproved = transporterModel.companyApproved;
  loadALLDataModel.truckNo = bookingModel.truckNo;
  loadALLDataModel.truckType = 'NA';
  loadALLDataModel.imei = 'NA';
  loadALLDataModel.driverName = bookingModel.driverName;
  loadALLDataModel.driverPhoneNum = bookingModel.driverPhoneNum;
  loadALLDataModel.rate = bookingModel.rate.toString();
  loadALLDataModel.unitValue = bookingModel.unitValue;
  loadALLDataModel.noOfTrucks = 'NA';
  loadALLDataModel.productType = 'NA';

  return loadALLDataModel;
}
