import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/fontWeights.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';

class MapScreenBarButton extends StatelessWidget {
  final String text;
  final int value;
  final PageController pageController;

  MapScreenBarButton({required this.text, required this.value , required this.pageController});

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Container(
    //  height: 26,
      width: 80,
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: GestureDetector(
        
        onTap: () {
          providerData.updateUpperNavigatorIndex(value);
          pageController.jumpToPage(value);
        },
        child: Text(
          
          '$text',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            decoration: providerData.upperNavigatorIndex == value?TextDecoration.underline:null,
            color: black,
            fontWeight: normalWeight,
          ),
        ),
      ),
    );
  }

}