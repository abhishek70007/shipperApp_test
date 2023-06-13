import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/radius.dart';
import '/constants/spaces.dart';

class imageDisplayUsingApi extends StatefulWidget {
  // const imageDisplayUsingApi({Key? key}) : super(key: key);
  String? docLink;
  imageDisplayUsingApi({this.docLink});

  @override
  State<imageDisplayUsingApi> createState() => _imageDisplayUsingApiState();
}

class _imageDisplayUsingApiState extends State<imageDisplayUsingApi> {
  bool progressBar = false;
  bool downloaded = false;
  bool downloading = false;

  void _saveNetworkImage(String path) async {
    // String path =
    //     'https://image.shutterstock.com/image-photo/montreal-canada-july-11-2019-600w-1450023539.jpg';
    GallerySaver.saveImage(path, albumName: "Liveasy").then((bool? success) {
      setState(() {
        print('Image is saved');
        progressBar = false;
        downloaded = true;
        downloading = false;
      });
    });
  }

  // ReceivePort _port = ReceivePort();

  // @override
  // void initState() {
  //   super.initState();

  //   IsolateNameServer.registerPortWithName(
  //       _port.sendPort, 'downloader_send_port');
  //   _port.listen((dynamic data) {
  //     String id = data[0];
  //     DownloadTaskStatus status = data[1];
  //     int progress = data[2];
  //     setState(() {});
  //   });

  //   FlutterDownloader.registerCallback(downloadCallback);
  // }

  // @override
  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }

  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send!.send([id, status, progress]);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: size_15 + 30,
              color: whiteBackgroundColor,
              child: Row(
                children: [
                  // Flexible(
                  //   flex: 3,
                  // child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: darkBlueColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: space_1,
                      ),
                      Text(
                        "Download Image".tr,
                        style: TextStyle(
                          fontSize: size_10 - 1,
                          fontWeight: boldWeight,
                          color: darkBlueColor,
                          // letterSpacing: -0.408
                        ),
                      ),
                    ],
                  ),
                  // ),
                ],
              ),
            ),
            Divider(
              height: size_3,
              color: darkGreyColor,
            ),
            downloading
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text("( Downloading.... )".tr),
                  )
                : Container(),
            downloaded
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("( Downloaded )".tr),
                  )
                : Container(),
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(30),
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: darkBlueColor,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(minHeight: 100),
                      color: whiteBackgroundColor,
                      child: Image.network(
                        widget.docLink.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(children: [
              // Flexible(
              //     child: ElevatedButton(
              //   child: Text("Edit"),
              //   onPressed: () async {
              //     await _cropImage(
              //         imageFile: providerData.LrPhotoFile);
              //   },
              // )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 7.5, bottom: 10, top: 10),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Color(0xFFE75347),
                      child: Container(
                        height: space_10,
                        child: Center(
                          child: Text(
                            "Cancel".tr,
                            style: TextStyle(
                                color: white,
                                fontSize: size_9,
                                fontWeight: mediumBoldWeight),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 7.5, right: 15, bottom: 10, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        child: Container(
                          color: Color(0xFF09B778),
                          height: space_10,
                          child: Center(
                            child: progressBar
                                ? CircularProgressIndicator(
                                    color: white,
                                  )
                                : Text(
                                    "Download".tr,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: size_8,
                                        fontWeight: FontWeight.bold),
                                  ),
                            // ),
                          ),
                        ),
                        onTapUp: (value) {
                          setState(() {
                            progressBar = true;
                            downloading = true;
                          });
                        },
                        onTap: () async {
                          _saveNetworkImage(widget.docLink.toString());

                          // final status = await Permission.storage.request();
                          // if (status.isGranted) {
                          //   final externalDir =
                          //       await path.getExternalStorageDirectory();

                          // Directory? directory;
                          // // try {
                          // if (Platform.isAndroid) {
                          //   if (status.isGranted) {
                          //     directory =
                          //         await path.getExternalStorageDirectory();
                          // String newPath = "";
                          // //     print(directory);
                          // List<String> paths = externalDir!.path.split("/");
                          // for (int x = 1; x < paths.length; x++) {
                          //   String folder = paths[x];
                          //   if (folder != "Android") {
                          //     setState(() {
                          //       newPath += "/" + folder;
                          //     });
                          //   } else {
                          //     break;
                          //   }
                          //     }
                          //     print(directory);
                          //     newPath = newPath + "/LiveasyApp";
                          //     directory = Directory(newPath);
                          //     print(directory);
                          //   } else {
                          //     // return false;
                          //   }
                          // } else {
                          //   print(directory);
                          //   final permis =
                          //       await Permission.photos.request();
                          //   if (permis.isGranted) {
                          //     print(directory);
                          //     directory =
                          //         await path.getTemporaryDirectory();
                          //     print(directory);
                          //   } else {
                          //     // return false;
                          //   }
                          // }

                          // if (!await directory!.exists()) {
                          //   print(directory);
                          //   await directory.create(recursive: true);
                          //   print(directory);
                          // }
                          // if (await directory!.exists()) {
                          //   print(directory);
                          //   File saveFile = File(directory.path +
                          //       "/$widget.docLink.toString()");

                          // if (newPath.isNotEmpty)
                          // final taskId = await FlutterDownloader.enqueue(
                          //   url: widget.docLink.toString(),
                          //   // headers: {}, // optional: header send with url (auth token etc)
                          //   savedDir: externalDir.path,
                          //   // externalDir!.path,
                          //   // directory.toString(),
                          //   // "Internal storage/DCIM/",
                          //   // externalDir!.path,
                          //   showNotification:
                          //       true, // show download progress in status bar (for Android)
                          //   openFileFromNotification: true,
                          // );

                          // await FlutterDownloader.registerCallback(
                          //     downloadCallback); // callback is a top-level or static function

                          // }
                          // }
                        },
                      ),
                    )),
                // downloading
                //     ? Padding(
                //         padding: const EdgeInsets.only(bottom: 5),
                //         child: Text("( Downloading.... )".tr),
                //       )
                //     : Container(),
                // downloaded
                //     ? Padding(
                //         padding: const EdgeInsets.only(bottom: 5.0),
                //         child: Text("( Downloaded )".tr),
                //       )
                //     : Container(),,
                // )),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
