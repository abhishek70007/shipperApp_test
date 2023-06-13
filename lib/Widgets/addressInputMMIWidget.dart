import 'package:flutter/material.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/screens/cityNameInputScreen.dart';
import 'package:get/get.dart';
import '/widgets/cancelIconWidget.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';

// ignore: must_be_immutable
class AddressInputMMIWidget extends StatefulWidget {
  final String page;
  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  var onTap;

  AddressInputMMIWidget(
      {required this.page,
      required this.hintText,
      required this.icon,
      required this.controller,
      required this.onTap});

  @override
  State<AddressInputMMIWidget> createState() => _AddressInputMMIWidgetState();
}

class _AddressInputMMIWidgetState extends State<AddressInputMMIWidget> {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    late String value;
    ProviderData providerData = Provider.of<ProviderData>(context);
    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(space_6),
    //     border: Border.all(color: darkBlueColor, width: borderWidth_8),
    //     color: widgetBackGroundColor,
    //   ),
    //   padding: EdgeInsets.symmetric(horizontal: space_3),
    //   child: TextFormField(
    //     readOnly: true,
    //     onTap: () {
    //
    //       providerData.updateResetActive(true);
    //
    //       FocusScope.of(context).requestFocus(FocusNode());
    //       // MapBox api is used for autosuggestion but city data is too less for use in india
    //       // Navigator.push(
    //       //   context,
    //       //   MaterialPageRoute(
    //       //     builder: (context) => MapBoxAutoCompleteWidget(
    //       //       apiKey: "pk.eyJ1IjoiZ2Fydml0YTkzNiIsImEiOiJjbDg0ZWNwZXkwMmJmM3ZwNWFzbnJpcXNlIn0.8WpvYsCUf889t6-nGoc4cA",
    //       //       hint: 'enterCityName'.tr,
    //       //       onSelect: (place) {
    //       //         controller.text = place.placeName!;
    //       //       },
    //       //       country: "IND",
    //       //       limit: 10,
    //       //       // location: Location(78.96,20.59),
    //       //       closeOnSelect: true,
    //       //     ),
    //       //   ),
    //       // );
    //       Get.to(() => CityNameInputScreen(page,hintText));   // for MapMyIndia api
    //     },
    //     controller: controller,
    //     decoration: InputDecoration(
    //       hintText: hintText,
    //       icon: icon,
    //     suffixIcon: GestureDetector(onTap: onTap, child: CancelIconWidget()),
    //     ),
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(space_6),
        border: Border.all(color: darkBlueColor, width: borderWidth_8),
        color: widgetBackGroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: space_3),
      child: TextFormField(
        readOnly: true,
        onTap: () async {
          final hasPermission = await _handleLocationPermission();
          if (hasPermission){
          providerData.updateResetActive(true);
          FocusScope.of(context).requestFocus(FocusNode());
          value = await Get.to(
              () => CityNameInputScreen(widget.page, widget.hintText)); // for MapMyIndia api
        }},
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: widget.icon,
          suffixIcon: GestureDetector(onTap: widget.onTap,
              child: widget.hintText == "Loading point 2"|| widget.hintText == "Unloading point 2"?
              Icon(Icons.delete_outline):
              CancelIconWidget()),
        ),
      ),
    );
  }
}
