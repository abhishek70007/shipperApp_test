import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class ProfilePhotoWidget extends StatefulWidget {
  var providerData;

  ProfilePhotoWidget({this.providerData});

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.providerData.profilePhotoFile != null
        ? Container(
            height: space_23,
            width: space_23,
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: grey,
                  blurRadius: 5.0,
                ),
              ],
              image: DecorationImage(
                  image: Image.file(widget.providerData.profilePhotoFile).image,
                  fit: BoxFit.fitWidth),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(space_14, 0, 0, space_1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius_11),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            widget.providerData.updateProfilePhoto(null);
                            widget.providerData.updateProfilePhotoStr(null);
                          });
                        },
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.rectangle),
                          height: space_4,
                          width: space_4,
                          child: Container(
                            // width: space_5,
                            // height: space_5,
                            color: darkBlueColor,
                            child: const Center(
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tap to Open",
                    style: TextStyle(fontSize: size_7, color: liveasyGreen),
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: space_23,
            width: space_23,
            decoration: const BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: grey,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: space_6 + 1,
                    width: space_6 - 2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/icons/defaultAccountIcon.png"),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(space_15, 0, 0, space_1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius_11),
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        height: space_4,
                        width: space_4,
                        child: const Center(
                          child: Icon(
                            Icons.add_box_rounded,
                            color: darkBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}