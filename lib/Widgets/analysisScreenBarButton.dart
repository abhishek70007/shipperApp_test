import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '/controller/analysisScreenNavController.dart';

class AnalysisScreenBarButton extends StatelessWidget {
  final String text;
  final int value;
  final PageController pageController;

  AnalysisScreenBarButton({required this.text, required this.value , required this.pageController});

  AnalysisScreenNavController analysisScreenNavController = Get.put(AnalysisScreenNavController());

  @override
  Widget build(BuildContext context) {

    return Container(
        width: 115,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Obx( () => GestureDetector(
            onTap: () {
              analysisScreenNavController.updateUpperNavIndex(value);
              pageController.jumpToPage(value);
            },
            child: Text(
              '$text',
              textAlign: TextAlign.center,
              textScaleFactor: 1,
              style:
                analysisScreenNavController.upperNavIndex.value == value ?
                Theme.of(context).textTheme.bodyText1
                ?.underlined(
                  distance: 5,
                  color: Color.fromRGBO(21, 41, 104, 1),
                  thickness: 4,
                ): null
              ),
            ),
          ),
        );
  }
}

extension TextStyleX on TextStyle {
  /// A method to underline a text with a customizable [distance] between the text
  /// and underline. The [color], [thickness] and [style] can be set
  /// as the decorations of a [TextStyle].
  TextStyle underlined({
    Color? color,
    double distance = 1,
    double thickness = 1,
    TextDecorationStyle style = TextDecorationStyle.solid,
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: this.color ?? Colors.black,
          offset: Offset(0, -distance),
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: thickness,
      decorationColor: color ?? this.color,
      decorationStyle: style,
      //fontSize: 14
    );
  }
}
