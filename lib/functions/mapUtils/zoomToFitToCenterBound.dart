import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> zoomToFitToCenterBound(GoogleMapController controller, LatLngBounds bounds,
    LatLng centerBounds) async {
  bool keepZoomingOut = true;

  while (keepZoomingOut) {
    final LatLngBounds screenBounds = await controller.getVisibleRegion();
    if (fits(bounds, screenBounds)) {
      keepZoomingOut = false;
      final double zoomLevel = await controller.getZoomLevel() - 1.5;
      controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: centerBounds,
            zoom: zoomLevel,
          ),
        ),
      );
      break;
    } else {
      // Zooming out by 0.1 zoom level per iteration
      final double zoomLevel = await controller.getZoomLevel() - 0.1;
      controller.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: centerBounds,
            zoom: zoomLevel,
          ),
        ),
      );
    }
  }
}

bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
  final bool northEastLatitudeCheck =
      screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
  final bool northEastLongitudeCheck =
      screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

  final bool southWestLatitudeCheck =
      screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
  final bool southWestLongitudeCheck =
      screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

  return northEastLatitudeCheck &&
      northEastLongitudeCheck &&
      southWestLatitudeCheck &&
      southWestLongitudeCheck;
}
