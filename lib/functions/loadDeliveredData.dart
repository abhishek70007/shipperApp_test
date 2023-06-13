import 'package:flutter/material.dart';
import 'package:shipper_app/functions/shipperApis/shipperApiCalls.dart';
import '/functions/truckApis/truckApiCalls.dart';
import '/models/deliveredCardModel.dart';
import '/models/driverModel.dart';
import '/models/onGoingCardModel.dart';
import '/models/shipperModel.dart';
import 'driverApiCalls.dart';
import 'loadApiCalls.dart';


Future<DeliveredCardModel> loadAllDeliveredData(bookingModel) async {
  final LoadApiCalls loadApiCalls = LoadApiCalls();

  final ShipperApiCalls shipperApiCalls = ShipperApiCalls();

  final TruckApiCalls truckApiCalls = TruckApiCalls();

  DriverModel driverModel = DriverModel();

  Map loadData = await loadApiCalls.getDataByLoadId(bookingModel.loadId);
  ShipperModel transporterModel = await shipperApiCalls.getDataByShipperId(bookingModel.shipperId);

  Map truckData = await truckApiCalls.getDataByTruckId(bookingModel.truckId[0]);
  if(truckData['driverId'] != "NA"){
    driverModel = await getDriverByDriverId(driverId: truckData['driverId']);
  }
  else{
    driverModel.driverId =  'NA';
    driverModel.transporterId =  'NA';
    driverModel.phoneNum =  'NA';
    driverModel.driverName =  'NA';
    driverModel.truckId =  'NA';
  }

  DeliveredCardModel loadALLDataModel = DeliveredCardModel();
  loadALLDataModel.bookingDate= bookingModel.bookingDate;
  loadALLDataModel.bookingId = bookingModel.bookingId;
  loadALLDataModel.completedDate = bookingModel.completedDate;
  loadALLDataModel.loadingPointCity = loadData['loadingPointCity'];
  loadALLDataModel.unloadingPointCity = loadData['unloadingPointCity'];
  loadALLDataModel.companyName =  transporterModel.companyName;
  loadALLDataModel.transporterPhoneNum = transporterModel.shipperPhoneNum;
  loadALLDataModel.transporterLocation = transporterModel.shipperLocation;
  loadALLDataModel.transporterName = transporterModel.shipperName;
  loadALLDataModel.companyApproved=transporterModel.companyApproved;
  loadALLDataModel.truckNo =truckData['truckNo'];
  loadALLDataModel.truckType= truckData['truckType'];
  loadALLDataModel.imei = truckData['imei'];
  loadALLDataModel.driverName= driverModel.driverName;
  loadALLDataModel.driverPhoneNum= driverModel.phoneNum;
  loadALLDataModel.rate= bookingModel.rate.toString();
  loadALLDataModel.unitValue =  bookingModel.unitValue;
  loadALLDataModel.noOfTrucks = loadData['noOfTrucks'];
  loadALLDataModel.productType =loadData['productType'];

  return loadALLDataModel;
}