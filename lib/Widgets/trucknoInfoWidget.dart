import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

Widget trucknoInfoWindow(var truckno){
  return  Container(
   // height: 300,
    margin: EdgeInsets.fromLTRB(100, 80, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          
          decoration: BoxDecoration(
            color: Color(0xff152968),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Container(
                //  margin: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "$truckno",
                    style: TextStyle(
                        color: white,
                        fontSize: size_5,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ),

                
              ],
            ),
          ),
          width: 100,
          height: 30,
        ),
      ],
    ),
  );

}