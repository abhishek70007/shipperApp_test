import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/functions/bookingApiCallsOrders.dart';
import '/functions/loadOnGoingDeliveredDataOrders.dart';
import '/widgets/deliveredCardOrders.dart';
import '/widgets/loadingWidgets/completedLoadingWidgets.dart';

class DeliveredScreenOrders extends StatelessWidget {
  final BookingApiCallsOrders bookingApiCallsOrders = BookingApiCallsOrders();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.67,
        child: FutureBuilder(
          //getTruckData returns list of truck Model
          future: bookingApiCallsOrders.getDataByShipperIdDelivered(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return CompletedLoadingWidgets();
            }
            print('delivered snapshot length :' +
                '${snapshot.data.length}'); //number of cards

            if (snapshot.data.length == 0) {
              return Container(
                margin: EdgeInsets.only(top: 153),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/EmptyLoad.png'),
                      height: 127,
                      width: 127,
                    ),
                    Text(
                      'Loads will be available once delivered!',
                      style: TextStyle(fontSize: size_8, color: grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: loadAllDataOrders(snapshot.data[index]),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return CompletedLoadingWidgets();
                          }
                          return DeliveredCardOrders(
                            unitValue: snapshot.data['unitValue'],
                            vehicleNo: snapshot.data['truckNo'],
                            productType: snapshot.data['productType'],
                            noOfTrucks: snapshot.data['noOfTrucks'],
                            truckType: snapshot.data['truckType'],
                            posterLocation: snapshot.data['posterLocation'],
                            posterName: snapshot.data['posterName'],
                            companyApproved: snapshot.data['companyApproved'],
                            driverPhoneNum: snapshot.data['driverPhoneNum'],
                            transporterPhoneNumber:
                            snapshot.data['posterPhoneNum'],
                            rate: snapshot.data['rate'],
                            loadingPoint: snapshot.data['loadingPoint'],
                            unloadingPoint: snapshot.data['unloadingPoint'],
                            companyName: snapshot.data['companyName'],
                            truckNo: snapshot.data['truckNo'],
                            driverName: snapshot.data['driverName'],
                            startedOn: snapshot.data['startedOn'],
                            endedOn: snapshot.data['endedOn'],
                            bookingId: snapshot.data['bookingId'],
                            // imei: snapshot.data['imei'],
                            // phoneNum: snapshot.data['phoneNum'],
                          );
                        });
                  } //builder
              );
          } //else
          },
        ));
  }
} //class end
