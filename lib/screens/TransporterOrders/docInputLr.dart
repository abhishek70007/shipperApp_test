import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/spaces.dart';
import '/language/localization_service.dart';
//import '/screens/TransporterOrders/getDocApiCallVerify.dart';
//import '/screens/TransporterOrders/getDocumentApiCall.dart';
import '/screens/TransporterOrders/uploadedDocs.dart';
import '../../widgets/accountVerification/image_display.dart';
import 'docUploadBtn2.dart';
import 'dart:convert';
import 'dart:io';
import '/widgets/alertDialog/permissionDialog.dart';
import 'dart:io' as Io;
import 'package:permission_handler/permission_handler.dart';
//import 'getDocName.dart';
import '/functions/documentApi/getDocApiCallVerify.dart';
import '/functions/documentApi/getDocumentApiCall.dart';

class docInputLr extends StatefulWidget {
  var providerData;
  String? bookingId;

  docInputLr({
    this.providerData,
    this.bookingId,
  });

  @override
  State<docInputLr> createState() => _docInputLrState();
}

class _docInputLrState extends State<docInputLr> {
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
    docLinks = await getDocumentApiCall(bookid.toString(), "L");
    setState(() {
      docLinks = docLinks;
    });
    // print(docLinks);
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
    print("verifiedCheck called");
    jsonresponse = await getDocApiCallVerify(bookid.toString(), "L");
    print("from verifiedCheck ${jsonresponse}");
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
    print("current selected language :- ");
    print(LocalizationService().getCurrentLocale());
    currentLang = LocalizationService().getCurrentLocale().toString();
    print(currentLang);
    if (currentLang == "hi_IN") {
      // to change the image selecting image according to the language.
      setState(() {
        addDocImageEng = addDocImageHindi;
        addMoreDocImageEng = addMoreDocImageHindi;
      });
    }

    bookid = widget.bookingId.toString();
    uploadedCheck();
  }

  String? docType;

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
                  "Upload LR".tr,
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
                // mainAxisSize: MainAxisSize.max,
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
                                            "assets/images/verifiedDoc.png"))// to show verified document image if uploaded doucments get verified.
                                    : docUploadbtn2(
                                        // text1: "( Click Here to add".tr,
                                        // text2: "documents / Photos )".tr,
                                        assetImage: addDocImageEng,
                                        onPressed: () async {
                                          widget.providerData.LrPhotoFile !=
                                                  null
                                              ? Get.to(ImageDisplay(
                                                  providerData: widget
                                                      .providerData.LrPhotoFile,
                                                  imageName: 'LrPhoto64',
                                                ))
                                              : showUploadedDocs
                                                  ? showPickerDialog(
                                                      widget.providerData
                                                          .updateLrPhoto,
                                                      widget.providerData
                                                          .updateLrPhotoStr,
                                                      context)
                                                  : null;
                                        },
                                        imageFile:
                                            widget.providerData.LrPhotoFile,
                                      ),
                              ),
                            ],
                          ),
                        ),
                  showAddMoreDoc
                      // ? (docLinks.isEmpty
                      ? (widget.providerData.LrPhotoFile == null)
                          ? Flexible(
                              child: Container(
                                height: 110,
                                width: 170,
                                child: docUploadbtn2(
                                  assetImage: addMoreDocImageEng,
                                  onPressed: () async {
                                    if (widget.providerData.LrPhotoFile ==
                                        null) {
                                      // showUploadedDocs
                                      //     ?
                                      showPickerDialog(
                                          widget.providerData.updateLrPhoto,
                                          widget.providerData.updateLrPhotoStr,
                                          context);
                                      // : null;
                                    }
                                  },
                                  imageFile: null,
                                ),
                              ),
                            )
                          : Container()
                      : Container(),
                  // :
                  // (!(docCount >= availDocs.length && removeAddMore))
                  // ?
                  // Flexible(
                  //     // flex: 2,
                  //     // child: Stack(
                  //     //   children: [
                  //     child: Container(
                  //       height: 110,
                  //       width: 170,
                  //       child: docUploadbtn2(
                  //         // text1: "( Click Here to add more".tr,
                  //         // text2: "documents )".tr,
                  //         assetImage:
                  //             "assets/images/AddMoreDocImg.png",
                  //         onPressed: () async {
                  //           if (widget.providerData.LrPhotoFile ==
                  //               null)
                  //           // ? Get.to(ImageDisplay(
                  //           //     providerData: widget.providerData.EwayBillPhotoFile2,
                  //           //     imageName: 'EwayBill2Photo64',
                  //           //   ))
                  //           // :
                  //           {
                  //             // showUploadedDocs
                  //             //     ?
                  //             showPickerDialog(
                  //                 widget.providerData.updateLrPhoto,
                  //                 widget.providerData
                  //                     .updateLrPhotoStr,
                  //                 context);
                  //             setState(() {
                  //               docCount++;
                  //             });
                  //             if (docCount < availDocs.length) {
                  //               setState(() {
                  //                 removeAddMore = false;
                  //               });
                  //             }
                  //             // : null;
                  //           }
                  //         },
                  //         imageFile: null,
                  //         // widget.providerData.EwayBillPhotoFile,
                  //       ),
                  //       // ],
                  //     ),
                  //   ))
                  // : Container())
                  // : Container(),
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
            // shape:
            child: Wrap(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: white,
                  ),
                  width: 240,
                  // color: white,
                  child: ListTile(
                      textColor: black,
                      iconColor: black,
                      // selectedColor: darkBlueColor,
                      leading: const Icon(Icons.photo_library),
                      title: Text("Gallery".tr),
                      onTap: () async {
                        await getImageFromGallery2(
                            functionToUpdate, strToUpdate, context);
                        Navigator.of(context).pop();
                      }),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    color: white,
                  ),
                  width: 240,
                  child: ListTile(
                    textColor: black,
                    iconColor: black,
                    leading: const Icon(Icons.photo_camera),
                    title: Text("Camera".tr),
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
      //       source: ImageSource.camera
      //   );
      //   bytes = await pickedFile.readAsBytes();
      // } else {
      //   picker = ImagePicker();
      //   pickedFile = await picker.pickImage(source: ImageSource.camera);
      //   bytes = await Io.File(pickedFile!.path).readAsBytes();
      // }
      picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.camera);
      bytes = kIsWeb ? await pickedFile.readAsBytes() : await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
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
      //   picker = ImagePicker();
      //   pickedFile = await picker.pickImage(
      //       source: ImageSource.gallery
      //   );
      //   bytes = await pickedFile.readAsBytes();
      // } else {
      // picker = ImagePicker();
      // pickedFile = await picker.pickImage(source: ImageSource.gallery);
      // bytes = await Io.File(pickedFile!.path).readAsBytes();
      // }
      picker = ImagePicker();
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      // print("pickedFile!.path ${pickedFile!.path}");
      bytes = kIsWeb ? await pickedFile.readAsBytes() : await Io.File(pickedFile!.path).readAsBytes();
      String img64 = base64Encode(bytes);
      functionToUpdate(File(pickedFile.path));
      strToUpdate(img64);
      setState(() {});
    }
  }
}
