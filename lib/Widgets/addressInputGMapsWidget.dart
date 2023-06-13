import 'package:flutter/material.dart';
import '/constants/borderWidth.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import '/widgets/cancelIconWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: must_be_immutable
class AddressInputGMapsWidget extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final TextEditingController controller;
  var onTap;

  AddressInputGMapsWidget(
      {required this.hintText,
      required this.icon,
      required this.controller,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    // String kGoogleApiKey = FlutterConfig.get('mapKey').toString();
    String kGoogleApiKey = dotenv.get('mapKey');

    print(controller);
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
          providerData.updateResetActive(true);
          FocusScope.of(context).requestFocus(FocusNode());
          // var uuid = Uuid();
          // uuid.v4(); // for session token
         await PlacesAutocomplete.show(    // flutter_google_places is used here for auto suggestion of places
              context: context,
              apiKey: kGoogleApiKey,
              mode: Mode.fullscreen,
              language: 'en',
              // logo: Text(""),
              // sessionToken: "$uuid",
              strictbounds: false,
             overlayBorderRadius: BorderRadius.circular(10),
              types: ["establishment"],
              decoration:InputDecoration(
                  filled: true,
                  fillColor: widgetBackGroundColor,
                  hintText: 'Enter City Name',suffixIcon: GestureDetector(onTap: onTap, child: CancelIconWidget()),
                  contentPadding: EdgeInsets.symmetric(horizontal: space_2),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(space_6), borderSide: BorderSide(color: darkBlueColor,width: borderWidth_8))),
              components: [Component(Component.country,"in")]).then((value) {
            if (value != null) {
              print(value.description);
              List<String> result = value.description!.split(",");
              int resultLength = 0;
              for (var r in result) {
                resultLength++;
                r = r.trimLeft();
                r = r.trimRight();
                print(r);
              }
              if (resultLength > 2) {
                if (hintText == "Loading Point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateLoadingPointFindLoad(
                    place: result[resultLength - 3].toString(),
                          city: result[resultLength - 3].toString(),
                          state: result[resultLength - 2].toString());
                } else if (hintText == "Unloading Point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateUnloadingPointFindLoad(
                      place: result[resultLength - 3].toString(),
                          city: result[resultLength - 3].toString(),
                          state: result[resultLength - 2].toString());
                } else if (hintText == "Loading point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateLoadingPointPostLoad(
                      place: result[resultLength - 3].toString(),
                          city: result[resultLength - 3].toString(),
                          state: result[resultLength - 2].toString());
                } else if (hintText == "Unloading point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateUnloadingPointPostLoad(
                      place: result[resultLength - 3].toString(),
                          city: result[resultLength - 3].toString(),
                          state: result[resultLength - 2].toString());
                }
              } else {
                // only case of Delhi, India
                // updating values with Delhi (Delhi)
                if (hintText == "Loading Point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateLoadingPointFindLoad(
                      place: result[resultLength - 3].toString(),
                          city: result[0].toString(),
                          state: result[0].toString());
                } else if (hintText == "Unloading Point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateUnloadingPointFindLoad(
                      place: result[resultLength - 3].toString(),
                          city: result[0].toString(),
                          state: result[0].toString());
                } else if (hintText == "Loading point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateLoadingPointPostLoad(
                    place: result[0].toString(),
                          city: result[0].toString(),
                          state: result[0].toString());
                } else if (hintText == "Unloading point") {
                  Provider.of<ProviderData>(context, listen: false)
                      .updateUnloadingPointPostLoad(
                      place: result[0].toString(),
                          city: result[0].toString(),
                          state: result[0].toString());
                }
              }
            } else {}
          });
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          icon: icon,
          suffixIcon: GestureDetector(onTap: onTap, child: CancelIconWidget()),
        ),
      ),
    );
  }
}
