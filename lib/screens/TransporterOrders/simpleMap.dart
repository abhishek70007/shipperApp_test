import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:screenshot/screenshot.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


class simpleMap extends StatefulWidget {
  @override
  _simpleMapState createState() => _simpleMapState();
}

class _simpleMapState extends State<simpleMap> with WidgetsBindingObserver {
  final Set<Polyline> _polyline = {};
  Map<PolylineId, Polyline> polylines =
      {}; //polylines are the blue lines that is displayed on the map to represent route by using polylineCoordinates.
  late GoogleMapController _googleMapController;
  late LatLng lastlatLngMarker = LatLng(28, 77.25);

  ScreenshotController screenshotController = ScreenshotController();
  late BitmapDescriptor pinLocationIcon;
  late BitmapDescriptor pinLocationIconTruck;
  CustomInfoWindowController _customDetailsInfoWindowController =
      CustomInfoWindowController();
  late CameraPosition camPosition =
      CameraPosition(target: lastlatLngMarker, zoom: 8);
  var logger = Logger();

  Completer<GoogleMapController> _controller = Completer();

  String googleAPiKey = dotenv.get('mapKey');

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  // bool isAnimation = false;
  double mapHeight = 600;

  var maptype = MapType.normal;
  double zoom = 15;
  bool zoombutton = false;
  bool showBottomMenu = true;

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle("[]");
    _controller.complete(controller);
    _customInfoWindowController.googleMapController = controller;
    _customDetailsInfoWindowController.googleMapController = controller;
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        final GoogleMapController controller = await _controller.future;
        onMapCreated(controller);
        print('appLifeCycleState resumed');
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    logger.i("Activity in trackscreen is disposed");
    // timer.cancel();
    // timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double threshold = 100;
    return SafeArea(
      child: Scaffold(
        backgroundColor: statusBarColor,
        body: GestureDetector(
          onTap: () {
            setState(() {
              showBottomMenu = !showBottomMenu;
            });
          },
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dy > threshold) {
              this.setState(() {
                showBottomMenu = false;
              });
            } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
              this.setState(() {
                showBottomMenu = true;
              });
            }
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: -250,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: height,
                  child: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
                          _customDetailsInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                          _customDetailsInfoWindowController.onCameraMove!();
                        },
                        // markers: customMarkers.toSet(),
                        polylines: Set.from(polylines.values),
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        initialCameraPosition: camPosition,
                        compassEnabled: true,
                        mapType: maptype,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          _customInfoWindowController.googleMapController =
                              controller;
                          _customDetailsInfoWindowController
                              .googleMapController = controller;
                          // setState(() {
                          //   loading_map =
                          //       true; //variable is made true when map is created.
                          // });
                        },
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        ].toSet(),
                      )
                      // //   :Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // );
  }
}
