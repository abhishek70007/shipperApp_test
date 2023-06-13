import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/language/localization_service.dart';
import '/screens/TransporterOrders/uploadedDocs.dart';
import '../../widgets/accountVerification/image_display.dart';
import 'docUploadBtn2.dart';
import 'dart:convert';
import 'dart:io';
import '/widgets/alertDialog/permissionDialog.dart';
import 'dart:io' as Io;
import 'package:permission_handler/permission_handler.dart';
//import 'getDocApiCallVerify.dart';
//import 'getDocumentApiCall.dart';
import '/functions/documentApi/getDocApiCallVerify.dart';
import '/functions/documentApi/getDocumentApiCall.dart';


// ignore: must_be_immutable
class docInputWgtReceipt extends StatefulWidget {
  var providerData;
  String? bookingId;

  docInputWgtReceipt({
    this.providerData,
    this.bookingId,
  });

  @override
  State<docInputWgtReceipt> createState() => _docInputWgtReceiptState();
}

class _docInputWgtReceiptState extends State<docInputWgtReceipt> {
  String? bookid;
  bool showUploadedDocs = true;
  bool verified = false;
  bool showAddMoreDoc = true;
  var jsonresponse;
  var docLinks = [];

  String? currentLang;

  String addDocImageEng = "assets/images/AddDocumentImg.png";
  String addDocImageHindi = "assets/images/AddDocumentImgHindi2.png";

  String addMoreDocImageEng = "assets/images/AddMoreDocImg.png";
  String addMoreDocImageHindi = "assets/images/AddMoreDocImgHindi.png";

  uploadedCheck() async {
    docLinks = [];
    docLinks = await getDocumentApiCall(bookid.toString(), "W");
    setState(() {
      docLinks = docLinks;
    });
    print(docLinks);
    if (docLinks.isNotEmpty) {
      setState(() {
        showUploadedDocs = false;
      });
      if (docLinks.length == 4) {
        setState(() {
          showAddMoreDoc = false;
        });
      }
      verifiedCheck();
    }
  }

  verifiedCheck() async {
    jsonresponse = await getDocApiCallVerify(bookid.toString(), "W");
    print(jsonresponse);
    if (jsonresponse == true) {
      setState(() {
        verified = true;
      });
    } else {
      verified = false;
    }
  }

  @override
  void initState() {
    super.initState();
    bookid = widget.bookingId;

    currentLang = LocalizationService().getCurrentLocale().toString();
    print(currentLang);
    if (currentLang == "hi_IN") {
      setState(() {
        addDocImageEng = addDocImageHindi;
        addMoreDocImageEng = addMoreDocImageHindi;
      });
    }

    uploadedCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: darkBlueColor,
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 6, bottom: 6),
                child: Text(
                  "Upload Weight receipt".tr,
                  style: TextStyle(
                    color: white,
                    fontSize: size_7,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: space_2,
            ),
            Container(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  !showUploadedDocs
                      ? Flexible(
                          flex: 2,
                          child: uploadedDocs(
                            docLinks: docLinks,
                            verified: verified,
                          ),
                        )
                      : Flexible(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3, top: 4),
                                height: 120,
                                width: 180,
                                child: verified
                                    ? Image(
                                        image: AssetImage(
                                            "assets/images/verifiedDoc.png"))
                                    : docUploadbtn2(
                                        assetImage: addDocImageEng,
                                        onPressed: () async {
                                          widget.providerData
                                                      .WeightReceiptPhotoFile !=
                                                  null
                                              ? Get.to(ImageDisplay(
                                                  providerData: widget
                                                      .providerData
                                                      .WeightReceiptPhotoFile,
                                                  imageName:
                                                      'WeightReceiptPhoto64',
                                                ))
                                              : showUploadedDocs
                                                  ? showPickerDialog(
                                                      widget.providerData
                                                          .updateWeightReceiptPhoto,
                                                      widget.providerData
                                                          .updateWeightReceiptPhotoStr,
                                                      context)
                                                  : null;
                                        },
                                        imageFile: widget.providerData
                                            .WeightReceiptPhotoFile,
                                      ),
                              ),
                            ],
                          ),
                        ),
                  showAddMoreDoc
                      ? (widget.providerData.WeightReceiptPhotoFile == null)
                          ? Flexible(
                              child: Container(
                                height: 110,
                                width: 170,
                                child: docUploadbtn2(
                                  assetImage: addMoreDocImageEng,
                                  onPressed: () async {
                                    if (widget.providerData
                                            .WeightReceiptPhotoFile ==
                                        null) {
                                      showPickerDialog(
                                          widget.providerData
                                              .updateWeightReceiptPhoto,
                                          widget.providerData
                                              .updateWeightReceiptPhotoStr,
                                          context);
                                    }
                                  },
                                  imageFile: null,
                                ),
                                // ],
                              ),
                            )
                          : Container()
                      : Container(),
                ],
              ),
            ),
            docLinks.length > 0
                ? Text(
                    "( Uploaded )".tr,
                    style: TextStyle(color: black),
                  )
                : Container(),
          ],
        ),
      ),
      // ),
    );
  }

  showPickerDialog(var functionToUpdate, var strToUpdate, var context) {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return
              // child:
              Dialog(
                child: Wrap(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        color: white,
                      ),
                      width: 240,
                      // color: white,
                      child: new ListTile(
                          textColor: black,
                          iconColor: black,
                          // selectedColor: darkBlueColor,
                          leading: new Icon(Icons.photo_library),
                          title: new Text("Gallery".tr),
                          onTap: () async {
                            await getImageFromGallery2(
                                functionToUpdate, strToUpdate, context);
                            Navigator.of(context).pop();
                          }),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: white,
                      ),
                      width: 240,
                      child: new ListTile(
                        textColor: black,
                        iconColor: black,
                        leading: new Icon(Icons.photo_camera),
                        title: new Text("Camera".tr),
                        onTap: () async {
                          await getImageFromCamera2(
                              functionToUpdate, strToUpdate, context);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              );
          // );
        });
  }

  Future getImageFromCamera2(
      var functionToUpdate, var strToUpdate, var context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        final picker = ImagePicker();
        var pickedFile = await picker.pickImage(source: ImageSource.camera);
        final bytes = await Io.File(pickedFile!.path).readAsBytes();
        String img64 = base64Encode(bytes);
        functionToUpdate(File(pickedFile.path));
        strToUpdate(img64);
        setState(() {});
      } else {
        showDialog(context: context, builder: (context) => PermissionDialog());
        // }
      }
    } else {
      final picker;
      var pickedFile;
      final bytes;
      // if(kIsWeb) {
      //   picker = ImagePickerPlugin();
      //   pickedFile = await picker.pickImage(
      //       source: ImageSource.gallery
      //   );
      //   bytes = await pickedFile.readAsBytes();
      // } else {
      //   picker = ImagePicker();
      //   pickedFile = await picker.pickImage(source: ImageSource.gallery);
      //   bytes = await Io.File(pickedFile!.path).readAsBytes();
      // }
      picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      bytes = await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      print("Base64 is $img64");
      functionToUpdate(File(pickedFile.path));
      strToUpdate(img64);
      setState(() {});
    }
  }

  Future getImageFromGallery2(
      var functionToUpdate, var strToUpdate, var context) async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        final picker = ImagePicker();
        var pickedFile = await picker.pickImage(source: ImageSource.gallery);
        final bytes = await Io.File(pickedFile!.path).readAsBytes();
        String img64 = base64Encode(bytes);
        functionToUpdate(File(pickedFile.path));
        strToUpdate(img64);
      } else {
        showDialog(context: context, builder: (context) => PermissionDialog());
        // }
      }
    } else {
      final picker;
      var pickedFile;
      final bytes;
      // if(kIsWeb) {
      //   picker = ImagePickerPlugin();
      //   pickedFile = await picker.pickImage(
      //       source: ImageSource.gallery
      //   );
      //   bytes = await pickedFile.readAsBytes();
      // } else {
      //   picker = ImagePicker();
      //   pickedFile = await picker.pickImage(source: ImageSource.gallery);
      //   bytes = await Io.File(pickedFile!.path).readAsBytes();
      // }
      picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      bytes = kIsWeb ? await pickedFile.readAsBytes() : await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      functionToUpdate(File(pickedFile.path));
      strToUpdate(img64);
      setState(() {});
    }
  }
}
