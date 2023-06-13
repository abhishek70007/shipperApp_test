// nearbyPlacesSearch Refactoring & documentation underway

import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

Future<void> openMap(String coordinates) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$coordinates';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
