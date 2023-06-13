// import 'package:flutter/material.dart';
// import '/constants/colors.dart';
// import '/constants/fontWeights.dart';
// import '/constants/spaces.dart';
// import '/models/BookingModel.dart';
// import '/models/driverModel.dart';
// import '/models/loadApiModel.dart';
// import '/models/loadPosterModel.dart';
// import '/models/truckModel.dart';
// import '/widgets/trackButton.dart';
// import 'LoadEndPointTemplate.dart';
// import 'linePainter.dart';
// import 'loadLabelValueTemplate.dart';
//
// // ignore: must_be_immutable
// class BookingCard extends StatefulWidget {
//   BookingModel? bookingModel;
//   LoadApiModel? loadApiModel;
//   LoadPosterModel? loadPosterModel;
//   TruckModel? truckModel;
//   DriverModel? driverModel;
//
//   BookingCard(
//       {this.bookingModel,
//       this.loadApiModel,
//       this.loadPosterModel,
//       this.truckModel,
//       this.driverModel});
//
//   @override
//   _BookingCardState createState() => _BookingCardState();
// }
//
// class _BookingCardState extends State<BookingCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Card(
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.all(space_4),
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           LoadEndPointTemplate(
//                               text:
//                                   widget.loadApiModel!.loadingPointCity != null
//                                       ? widget.loadApiModel!.loadingPointCity
//                                           .toString()
//                                       : 'NA',
//                               endPointType: 'loading'),
//                           Container(
//                               padding: EdgeInsets.only(left: 2),
//                               height: space_6,
//                               width: space_12,
//                               child: CustomPaint(
//                                 foregroundPainter: LinePainter(),
//                               )),
//                           LoadEndPointTemplate(
//                               text: widget.loadApiModel!.unloadingPointCity !=
//                                       null
//                                   ? widget.loadApiModel!.unloadingPointCity
//                                       .toString()
//                                   : 'NA',
//                               endPointType: 'unloading'),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(right: space_1),
//                             child: Image(
//                                 height: 16,
//                                 width: 23,
//                                 color: black,
//                                 image: AssetImage(
//                                     'assets/icons/buildingIcon.png')),
//                           ),
//                           Text(
//                             widget.loadPosterModel!.loadPosterCompanyName !=
//                                     null
//                                 ? widget.loadPosterModel!.loadPosterCompanyName
//                                     .toString()
//                                 : 'NA',
//                             style: TextStyle(
//                               color: liveasyBlackColor,
//                               fontWeight: mediumBoldWeight,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: space_4),
//                     child: Column(
//                       children: [
//                         LoadLabelValueTemplate(
//                             value: widget.truckModel!.truckNo.toString(),
//                             label: 'Vehicle Number.'),
//                         LoadLabelValueTemplate(
//                             value: widget.driverModel!.driverName.toString(),
//                             label: 'Driver Name'),
//                         LoadLabelValueTemplate(
//                             value: widget.bookingModel!.bookingDate.toString(),
//                             label: 'Started on')
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: contactPlaneBackground,
//               padding: EdgeInsets.symmetric(
//                 vertical: space_2,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   TrackButton(truckApproved: false),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
