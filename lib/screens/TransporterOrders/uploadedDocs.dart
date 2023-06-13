import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/screens/TransporterOrders/imageDisplayUsingApi.dart';

class uploadedDocs extends StatefulWidget {
  bool verified;
  List docLinks = [];

  uploadedDocs({required this.docLinks, required this.verified});
  @override
  State<uploadedDocs> createState() => _uploadedDocsState();
}

class _uploadedDocsState extends State<uploadedDocs> {
  bool i1 = false;
  bool i2 = false;
  bool i3 = false;
  bool i4 = false;
  @override
  void initState() {
    super.initState();
    if (widget.docLinks.length > 0) {
      var image1 = Image.network(
        widget.docLinks[0].toString(),
      );
      if (image1 != null) {
        setState(() {
          i1 = true;
        });
      }
    }
    if (widget.docLinks.length > 1) {
      var image2 = Image.network(
        widget.docLinks[1].toString(),
      );
      if (image2 != null) {
        setState(() {
          i2 = true;
        });
      }
    }
    if (widget.docLinks.length > 2) {
      var image3 = Image.network(
        widget.docLinks[2].toString(),
      );
      if (image3 != null) {
        setState(() {
          i3 = true;
        });
      }
    }
    if (widget.docLinks.length > 3) {
      var image4 = Image.network(
        widget.docLinks[3].toString(),
      );
      if (image4 != null) {
        setState(() {
          i4 = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.verified
            ? Flexible(
                child: Container(
                  margin: EdgeInsets.only(right: 3, top: 4),
                  height: 120,
                  width: 180,
                  child: Image(
                    image: AssetImage("assets/images/verifiedDoc.png"),
                  ),
                ),
              )
            : Container(),
        widget.docLinks.length > 0
            ? Flexible(
                child: Stack(
                  children: [
                    i1
                        ? GestureDetector(
                            onTap: () {
                              Get.to(imageDisplayUsingApi(
                                docLink: widget.docLinks[0].toString(),
                              ));
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    color: whiteBackgroundColor,
                                    margin: EdgeInsets.only(right: 3, top: 4),
                                    height: 120,
                                    width: 180,
                                    child: Image.network(
                                      widget.docLinks[0].toString(),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Tap to Open".tr,
                                    style: TextStyle(
                                        fontSize: size_6, color: liveasyGreen),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
        widget.docLinks.length > 1
            ? Flexible(
                child: Stack(
                  children: [
                    i2
                        ? GestureDetector(
                            onTap: () {
                              Get.to(imageDisplayUsingApi(
                                docLink: widget.docLinks[1].toString(),
                              ));
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    color: whiteBackgroundColor,
                                    margin: EdgeInsets.only(right: 3, top: 4),
                                    height: 120,
                                    width: 180,
                                    child: Image.network(
                                      widget.docLinks[1].toString(),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Tap to Open".tr,
                                    style: TextStyle(
                                        fontSize: size_6, color: liveasyGreen),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
        widget.docLinks.length > 2
            ? Flexible(
                child: Stack(
                  children: [
                    i3
                        ? GestureDetector(
                            onTap: () {
                              Get.to(imageDisplayUsingApi(
                                docLink: widget.docLinks[2].toString(),
                              ));
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    color: whiteBackgroundColor,
                                    margin: EdgeInsets.only(right: 3, top: 4),
                                    height: 120,
                                    width: 180,
                                    child: Image.network(
                                      widget.docLinks[2].toString(),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Tap to Open".tr,
                                    style: TextStyle(
                                        fontSize: size_6, color: liveasyGreen),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
        widget.docLinks.length > 3
            ? Flexible(
                child: Stack(
                  children: [
                    i4
                        ? GestureDetector(
                            onTap: () {
                              Get.to(imageDisplayUsingApi(
                                docLink: widget.docLinks[3].toString(),
                              ));
                            },
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    color: whiteBackgroundColor,
                                    margin: EdgeInsets.only(right: 3, top: 4),
                                    height: 120,
                                    width: 180,
                                    child: Image.network(
                                      widget.docLinks[3].toString(),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Tap to Open".tr,
                                    style: TextStyle(
                                        fontSize: size_6, color: liveasyGreen),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
