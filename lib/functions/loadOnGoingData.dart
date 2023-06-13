import 'package:flutter/material.dart';
import 'package:shipper_app/functions/shipperApis/shipperApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/BookingModel.dart';
import '/models/driverModel.dart';
import '/models/onGoingCardModel.dart';
import '/models/shipperModel.dart';
import 'driverApiCalls.dart';
import 'loadApiCalls.dart';

//TODO:later on ,put these variables inside the function
LoadApiCalls loadApiCalls = LoadApiCalls();

ShipperApiCalls shipperApiCalls = ShipperApiCalls();

TruckApiCalls truckApiCalls = TruckApiCalls();

DriverApiCalls driverApiCalls = DriverApiCalls();

Future<OngoingCardModel?> loadAllOngoingData(BookingModel bookingModel) async {
  // Map loadData = await loadApiCalls.getDataByLoadId(bookingModel.loadId!);
  ShipperModel shipperModel = await shipperApiCalls.getDataByShipperId(bookingModel.shipperId);

  OngoingCardModel loadALLDataModel = OngoingCardModel();
  loadALLDataModel.bookingDate = bookingModel.bookingDate;
  loadALLDataModel.bookingId = bookingModel.bookingId;
  loadALLDataModel.completedDate = bookingModel.completedDate;
  loadALLDataModel.deviceId = bookingModel.deviceId;
  loadALLDataModel.loadingPointCity = bookingModel.loadingPointCity;
  loadALLDataModel.unloadingPointCity = bookingModel.unloadingPointCity;
  loadALLDataModel.companyName = shipperModel.companyName;
  loadALLDataModel.shipperPhoneNum = shipperModel.shipperPhoneNum;
  loadALLDataModel.shipperLocation = shipperModel.shipperLocation;
  loadALLDataModel.shipperName = shipperModel.shipperName;
  loadALLDataModel.companyApproved = shipperModel.companyApproved;
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
