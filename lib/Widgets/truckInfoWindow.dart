import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';

Widget truckInfoWindow(var truckno,var truckAddress){
  return  Container(
   // height: 300,
    margin: EdgeInsets.fromLTRB(150, 50, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Container(
                //  margin: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "$truckno",
                    style: TextStyle(
                        color: Color(0xff152968),
                        fontSize: size_5,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ),

                Text(
                  "at",
                  style: TextStyle(
                      color:  Color(0xff152968),
                      fontSize: size_3,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500
                  ),
                ),
                
                Text(
                  "  ${truckAddress}",
                  maxLines: 3,
                  style: TextStyle(
                      color: Color(0xff152968),
                      fontSize: size_5,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          width: 250,
          height: 90,
        ),
      ],
    ),
  );

}