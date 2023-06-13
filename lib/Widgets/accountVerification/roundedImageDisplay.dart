import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';

// ignore: must_be_immutable
class RoundedImageDisplay extends StatelessWidget {
  String text;
  var onPressed;
  var imageFile;

  RoundedImageDisplay(
      {required this.onPressed, required this.imageFile, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 132,
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(space_3),
            ))
        ),
        child: Container(
          decoration: imageFile != null
              ? BoxDecoration(
                  image: DecorationImage(
                      image: Image.file(imageFile).image, fit: BoxFit.fill),
                )
              : BoxDecoration(),
          padding: EdgeInsets.symmetric(vertical: space_6),
          child: imageFile == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: darkGreyColor,
                    ),
                    text != ""
                        ? Text(
                            text,
                            style: TextStyle(
                                fontSize: size_7,
                                fontWeight: regularWeight,
                                color: veryDarkGrey),
                          )
                        : Container()
                  ],
                )
              : Center(
                  child: Text(
                    "Tap to Open",
                    style: TextStyle(fontSize: size_6, color: liveasyGreen),
                  ),
                ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
