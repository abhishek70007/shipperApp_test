import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/functions/getImageFromCamera.dart';
import '/widgets/accountVerification/roundedImageDisplay.dart';

import '../../constants/radius.dart';
import 'image_display.dart';

// ignore: must_be_immutable
class IdInputWidget extends StatefulWidget {
  var providerData;

  IdInputWidget({this.providerData});

  @override
  State<IdInputWidget> createState() => _IdInputWidgetState();
}

class _IdInputWidgetState extends State<IdInputWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          padding: EdgeInsets.all(space_3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "addAddressProof".tr,
                style: TextStyle(
                  fontWeight: mediumBoldWeight,
                  fontSize: size_8,
                ),
              ),
              Text(
                "docsExample".tr,
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      RoundedImageDisplay(
                        text: "idFront".tr,
                        onPressed: () async {
                          widget.providerData.addressProofFrontPhotoFile!=null?
                          Get.to(ImageDisplay(providerData: widget.providerData.addressProofFrontPhotoFile,imageName: 'addressProofFrontPhoto64',))
                              :showPicker(
                              widget.providerData.updateAddressProofFrontPhoto,
                              widget.providerData.updateAddressProofFrontPhotoStr,
                              context);
                        },
                        imageFile: widget.providerData.addressProofFrontPhotoFile,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: widget.providerData.addressProofFrontPhotoFile!=null?
                        Container(
                          margin: EdgeInsets.fromLTRB(space_22, 0, 0, space_1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radius_10),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.providerData.updateAddressProofFrontPhoto(null);
                                  widget.providerData.updateAddressProofFrontPhotoStr(null);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.rectangle),
                                height: space_5,
                                width: space_5,
                                child: const Center(
                                  child: Icon(
                                    Icons.clear,
                                    color: darkBlueColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):Container(),
                      ),

                    ],
                  ),
                  Stack(
                    children: [
                      RoundedImageDisplay(
                        text: "idBack".tr,
                        onPressed: () async {
                          widget.providerData.addressProofBackPhotoFile!=null?
                          Get.to(ImageDisplay(providerData: widget.providerData.addressProofBackPhotoFile,imageName: 'addressProofBackPhoto64',))
                              :showPicker(widget.providerData.updateAddressProofBackPhoto,
                              widget.providerData.updateAddressProofBackPhotoStr, context);
                        },
                        imageFile: widget.providerData.addressProofBackPhotoFile,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: widget.providerData.addressProofBackPhotoFile!=null?
                        Container(
                          margin: EdgeInsets.fromLTRB(space_22, 0, 0, space_1),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radius_10),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  widget.providerData.updateAddressProofBackPhoto(null);
                                  widget.providerData.updateAddressProofBackPhotoStr(null);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(shape: BoxShape.rectangle),
                                height: space_5,
                                width: space_5,
                                child: const Center(
                                  child: Icon(
                                    Icons.clear,
                                    color: darkBlueColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):Container(),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(
                height: space_3,
              ),
              Text(
                "addId".tr,
                style: TextStyle(
                    fontSize: size_8,
                    color: veryDarkGrey,
                    fontWeight: mediumBoldWeight),
              ),
              Text(
                "addIdExample".tr,
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_3,
              ),
              Stack(
                children: [
                  Center(
                    child: RoundedImageDisplay(
                      text: "panFront".tr,
                      onPressed: () async {
                        widget.providerData.panFrontPhotoFile!=null?
                        Get.to(ImageDisplay(providerData: widget.providerData.panFrontPhotoFile,imageName: "panFrontPhoto64",))
                            :showPicker(widget.providerData.updatePanFrontPhoto,
                            widget.providerData.updatePanFrontPhotoStr, context);
                      },
                      imageFile: widget.providerData.panFrontPhotoFile,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: widget.providerData.panFrontPhotoFile != null?
                      Container(
                      margin: EdgeInsets.fromLTRB(space_22, 0, 0, space_1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius_10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              widget.providerData.updatePanFrontPhoto(null);
                              widget.providerData.updatePanFrontPhotoStr(null);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(shape: BoxShape.rectangle),
                            height: space_5,
                            width: space_5,
                            child: const Center(
                              child: Icon(
                                Icons.clear_rounded,
                                color: darkBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ):Container(),
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
