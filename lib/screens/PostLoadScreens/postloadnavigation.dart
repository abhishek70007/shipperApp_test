import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoadDetails.dart';
import '/widgets/addPostLoadHeader.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import '/screens/PostLoadScreens/PostLoadScreenLoacationDetails.dart';
import '/screens/PostLoadScreens/PostLoadScreenMultiple.dart';
class PostLoadNav extends StatefulWidget {
  const PostLoadNav({Key? key}) : super(key: key);

  @override
  State<PostLoadNav> createState() => _PostLoadNavState();
}

class _PostLoadNavState extends State<PostLoadNav> {
  PageController pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(space_4, space_2, space_4, space_0),
                  child: AddPostLoadHeader(
                      reset: true,
                      resetFunction: (){
                        if(providerData.upperNavigatorIndex2==0)
                          {
                            providerData.resetPostLoadScreenOne();
                          }
                        else
                          {
                            providerData.resetPostLoadScreenMultiple();
                          }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(space_4, space_2, space_4, space_0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: (){
                        providerData.updateUpperNavigatorIndex2(0);
                        pageController.jumpToPage(0);
                      }, child: Text("Single".tr,
                          style: TextStyle(
                            fontSize: size_10,
                            fontWeight: boldWeight,
                            color: providerData.upperNavigatorIndex2==0?darkBlueColor:lightGrey
                          ),)),
                      TextButton(onPressed: (){
                        providerData.updateUpperNavigatorIndex2(1);
                        pageController.jumpToPage(1);
                      }, child: Text("Multiple".tr,
                          style:TextStyle(
                            fontSize: size_10,
                            fontWeight: boldWeight,
                            color: providerData.upperNavigatorIndex2==1?darkBlueColor:lightGrey
                          ) ,)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Divider(
                      thickness: 5,
                      indent: 0,
                      color: providerData.upperNavigatorIndex2==0?darkBlueColor:lightGrey,
                    )),
                    Expanded(child: Divider(
                      thickness: 5,
                      color: providerData.upperNavigatorIndex2==1?darkBlueColor:lightGrey,
                    )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(space_4, space_2, space_4, space_0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.75,
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (val){
                            setState(() {
                              providerData.updateUpperNavigatorIndex2(val);
                            });
                          },
                          children: [
                            PostLoadScreenOne(),
                            PostLoadScreenMultiple()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
