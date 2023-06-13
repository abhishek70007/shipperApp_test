import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/functions/nearbySearchFunctions.dart';
import '/models/placesNearbyDataModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPlaceInfoCard extends StatefulWidget {
  final double pinPillPosition;
  var placeOnTheMapTag;
  PlacesNearbyData placesNearbyData;
  final int placesIndex;

  NearbyPlaceInfoCard({
    required this.pinPillPosition,
    required this.placeOnTheMapTag,
    required this.placesNearbyData,
    required this.placesIndex,
  });

  @override
  _NearbyPlaceInfoCardState createState() => _NearbyPlaceInfoCardState();
}

class _NearbyPlaceInfoCardState extends State<NearbyPlaceInfoCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: widget.pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {},
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.all(20),
            height: 72,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 10),
                  child: ClipOval(
                      child: Image.asset(
                          "assets/icons/" + widget.placeOnTheMapTag + ".png",
                          fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            widget.placesNearbyData.results![widget.placesIndex]
                                .name
                                .toString(),
                            style: TextStyle(
                                fontSize: size_7,
                                fontWeight: mediumBoldWeight,
                                color: darkBlueColor),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Text(
                            'Distance: ${widget.placesNearbyData.results![widget.placesIndex].distance!.toStringAsFixed(1)} km',
                            style: TextStyle(
                                fontSize: size_6,
                                fontWeight: mediumBoldWeight,
                                color: Colors.grey)),
                        Flexible(
                          child: Text(
                            '${widget.placesNearbyData.results![widget.placesIndex].vicinity.toString()}',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      openMap(widget
                              .placesNearbyData
                              .results![widget.placesIndex]
                              .geometry!
                              .location!
                              .lat
                              .toString() +
                          ',' +
                          widget.placesNearbyData.results![widget.placesIndex]
                              .geometry!.location!.lng
                              .toString());
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Image.asset("assets/icons/navigateIcon.png",
                          width: 50, height: 50),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
