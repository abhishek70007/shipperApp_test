import 'package:flutter/material.dart';
import '/constants/spaces.dart';
import '/providerClass/providerData.dart';
import 'package:provider/provider.dart';
import '/constants/colors.dart';
import '/constants/radius.dart';
import '/constants/fontSize.dart';

class EmailAddressTextField extends StatefulWidget {
  const EmailAddressTextField({Key? key}) : super(key: key);

  @override
  State<EmailAddressTextField> createState() => _EmailAddressTextFieldState();
}

class _EmailAddressTextFieldState extends State<EmailAddressTextField> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ProviderData provider = Provider.of<ProviderData>(context);

    return Container(
      decoration: BoxDecoration(
        color: widgetBackGroundColor,
        borderRadius: BorderRadius.circular(radius_2),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(
                left: space_2,
                right: space_2,
              ),
              child: Expanded(
                child:TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: size_7,
                      // color: darkCharcoal,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size_7,
                  ),
                ),
              )
          ),
        ),
      ),
    );
  }
}
