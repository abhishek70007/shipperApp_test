import 'package:flutter/cupertino.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';

class WelcomeToLiveasy extends StatefulWidget {
  const WelcomeToLiveasy({Key? key}) : super(key: key);

  @override
  State<WelcomeToLiveasy> createState() => _WelcomeToLiveasyState();
}

class _WelcomeToLiveasyState extends State<WelcomeToLiveasy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Welcome to Liveasy",
        style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: size_11,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          color: black,
        ),
      ),
    );
  }
}
