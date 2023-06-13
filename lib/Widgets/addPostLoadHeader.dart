import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/constants/colors.dart';
import '/constants/fontSize.dart';
import '/constants/fontWeights.dart';
import '/constants/spaces.dart';
import '/widgets/buttons/backButtonWidget.dart';
import 'package:provider/provider.dart';
import '/providerClass/providerData.dart';
import 'package:get/get.dart';

class AddPostLoadHeader extends StatefulWidget {
  dynamic resetFunction;
  bool reset = true;

  AddPostLoadHeader({this.resetFunction, required this.reset});

  @override
  _AddPostLoadHeaderState createState() => _AddPostLoadHeaderState();
}

class _AddPostLoadHeaderState extends State<AddPostLoadHeader> {
  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            !kIsWeb?Container(
                margin: EdgeInsets.only(right: space_2),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                    providerData.updateUpperNavigatorIndex2(0);
                  },
                  child: const Icon(Icons.arrow_back_ios_rounded),
                )):const SizedBox(width: 0.5,),
            Text('postLoad'.tr,
                // AppLocalizations.of(context)!.postLoad,
                style: TextStyle(
                  fontSize: size_10,
                  fontWeight: mediumBoldWeight,
                )),
          ],
        ),
        widget.reset
            ? TextButton(
                onPressed:
                    providerData.resetActive ? widget.resetFunction : null,
                child: Text('reset'.tr,
                    // AppLocalizations.of(context)!.reset,
                    style: TextStyle(
                      color:
                          providerData.resetActive ? truckGreen : unactiveReset,
                      fontSize: size_10,
                      fontWeight: regularWeight,
                    )))
            : const SizedBox()
      ],
    );
  }
}
