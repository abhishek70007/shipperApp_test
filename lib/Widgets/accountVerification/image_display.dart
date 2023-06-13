import 'package:flutter/material.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../constants/fontSize.dart';
import '../../constants/fontWeights.dart';
import '../../constants/radius.dart';
import '../../constants/spaces.dart';

class ImageDisplay extends StatefulWidget{
  
  // late final image;
  var providerData;
  String imageName;
  ImageDisplay({Key? key,required this.providerData,required this.imageName});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    void clearImage(String image){

      if(image=="addressProofBackPhoto64"){
        providerData.updateAddressProofBackPhoto(null);
        providerData.updateAddressProofBackPhotoStr(null);
      }else if(image=="addressProofFrontPhoto64"){
        providerData.updateAddressProofFrontPhoto(null);
        providerData.updateAddressProofFrontPhotoStr(null);
      }else if(image=="panFrontPhoto64"){
        providerData.updatePanFrontPhoto(null);
        providerData.updatePanFrontPhotoStr(null);
      }else if(image == "companyIdProofPhoto64"){
        providerData.updateCompanyIdProofPhoto(null);
        providerData.updateCompanyIdProofPhotoStr(null);
      }else if(image == "profilePhoto64"){
        providerData.updatePanFrontPhoto(null);
        providerData.updatePanFrontPhotoStr(null);
      }

    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(space_22, 0, 0, space_1),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius_10),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          clearImage(widget.imageName);
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.rectangle),
                        height: space_10,
                        width: space_10,
                        child: Center(
                          child: Icon(
                            Icons.clear,
                            color: darkBlueColor,
                            size: size_15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0,left: 10,right: 10),
                  child: Image.file(widget.providerData),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: activeButtonColor,
                ),
                child: Container(
                  height: space_8,
                  child: Center(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: white,
                          fontSize: size_8,
                          fontWeight: mediumBoldWeight),
                    ),
                  ),
                ),
                onPressed: (){

                  Navigator.pop(context);
              }
              ),
            ),
          ],
        ),
      ),
    );
  }




}