import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/constants/spaces.dart';
import '/constants/radius.dart';
import '/constants/fontSize.dart';
import '/constants/borderWidth.dart';
import '/constants/elevation.dart';

class SignUpWithGoogleButton extends StatelessWidget {
  var onPressed;


  SignUpWithGoogleButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: space_8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius_3),
          border: Border.all(
            color: black,
            width: borderWidth_10,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: elevation_0,
            backgroundColor: Colors.black.withOpacity(0.01),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: space_4,
                  width: space_4,
                  child: const Image(
                    image: AssetImage("assets/icons/google_icon.png"),
                  )
              ),
              SizedBox(
                width: space_3,
              ),
              Text(
                "Login with Google",
                style: TextStyle(
                    fontSize: size_9,
                    fontFamily: "Monsterrat",
                    fontWeight: FontWeight.bold,
                    color: black
                ),
              ),
            ],
          ),
        )
    );
  }
}

