import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
class CompanyIdInputWidget extends StatefulWidget {
  var providerData;

  CompanyIdInputWidget({this.providerData});

  @override
  State<CompanyIdInputWidget> createState() => _CompanyIdInputWidgetState();
}

class _CompanyIdInputWidgetState extends State<CompanyIdInputWidget> {

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
                "companyId".tr,
                style: TextStyle(
                    fontSize: size_8,
                    color: veryDarkGrey,
                    fontWeight: mediumBoldWeight),
              ),
              Text(
                "companyIdExample".tr,
                style: TextStyle(fontSize: size_6, color: grey),
              ),
              SizedBox(
                height: space_4,
              ),
              Stack(
                children: [
                  Center(
                    child: RoundedImageDisplay(
                      text: "",
                      onPressed: () {
                        widget.providerData.companyIdProofPhotoFile!=null?
                        Get.to(ImageDisplay(providerData: widget.providerData.companyIdProofPhotoFile,imageName: 'companyIdProofPhoto64',))
                            :showPicker(
                            widget.providerData.updateCompanyIdProofPhoto,
                            widget.providerData.updateCompanyIdProofPhotoStr,
                            context
                        );
                      },
                      imageFile: widget.providerData.companyIdProofPhotoFile,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: widget.providerData.companyIdProofPhotoFile!=null?
                    Container(
                      margin: EdgeInsets.fromLTRB(space_22, 0, 0, space_1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(radius_10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              widget.providerData.updateCompanyIdProofPhoto(null);
                              widget.providerData.updateCompanyIdProofPhotoStr(null);
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
        ),
      ),
    );
  }
}