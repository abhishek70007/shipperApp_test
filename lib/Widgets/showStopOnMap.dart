import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class showStopOnMap extends StatefulWidget {
  var validStop;
  var validAddress;

  showStopOnMap({
    required this.validStop,
    required this.validAddress,
  });

  @override
  _showStopOnMapState createState() => _showStopOnMapState();
}

class _showStopOnMapState extends State<showStopOnMap>
    with WidgetsBindingObserver {

  List<Marker> currentStoppage = [];
  var validStop;
  var validAddress;

  void initFunction() {
    setState(() {
      validStop = widget.validStop;
      validAddress = widget.validAddress;
    });
    print("HEY HEY HEY HEY");
    print("$validAddress");
  }

  @override
  void initState() {
    super.initState();
    initFunction();
    currentStoppage.add(Marker(
      markerId: MarkerId("stoppage"),
      draggable: false,
      position: LatLng(validStop.latitude, validStop.longitude),
    ));
  }


  late LatLng latLngMarker = LatLng(validStop.latitude, validStop.longitude);
  late CameraPosition _camPosition =
      CameraPosition(target: latLngMarker, zoom: 12);
  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$validAddress"),
        titleTextStyle: TextStyle(

          color: Colors.black
        ),
      ),
        body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _camPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: Set.from(currentStoppage)
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => _googleMapController
            .animateCamera(CameraUpdate.newCameraPosition(_camPosition)),
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}
