// import 'package:flutter/material.dart';
// import '/functions/getRequestorDetailsFromPostLoadId.dart';
// import '/models/BookingModel.dart';
// import '/models/loadApiModel.dart';
// import '/widgets/getBookingTruckDetails.dart';
//
// import 'loadingWidget.dart';
//
// // ignore: must_be_immutable
// class GetCustomerDetails extends StatefulWidget {
//   BookingModel? bookingModel;
//   LoadApiModel? loadApiModel;
//
//   GetCustomerDetails({this.bookingModel, this.loadApiModel});
//
//   @override
//   _GetCustomerDetailsState createState() => _GetCustomerDetailsState();
// }
//
// class _GetCustomerDetailsState extends State<GetCustomerDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future:
//             getRequestorDetailsFromPostLoadId(widget.loadApiModel!.postLoadId),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data == null) {
//             return Container(
//                 padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.2),
//                 child: LoadingWidget());
//           }
//           return GetBookingTruckDetails(
//             bookingModel: widget.bookingModel,
//             loadApiModel: widget.loadApiModel,
//             loadPosterModel: snapshot.data,
//           );
//         });
//   }
// }
