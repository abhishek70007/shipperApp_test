import 'package:flutter/material.dart';
import '/constants/colors.dart';
import '/widgets/cancelIconWidget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TextFieldWidget extends StatefulWidget {
  // final TextEditingController controller;
  final dynamic onChanged;
  final String hintText;

  TextFieldWidget({
    // required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController controller=TextEditingController();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    print("hello start");
    controller=TextEditingController(text:  _speechToText.isListening
        ? '$_lastWords'
    // If listening isn't active but could be tell the user
    // how to start it, otherwise indicate that speech
    // recognition is not yet ready or not supported on
    // the target device
        : _speechEnabled
        ? 'Tap the microphone to start listening...'
        : 'Speech not available');
    print("$_lastWords ++++ $controller");
    setState(() {
    });
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: liveasyBlackColor, width: 0.8),
        borderRadius: BorderRadius.circular(30),
        color: widgetBackGroundColor,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        autofocus: true,
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
          // prefixIcon: IconButton(
          //   onPressed: (){_speechToText.isNotListening ? _startListening : _stopListening;},
          //   icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          // ),
          prefixIcon: GestureDetector(onTap:_speechToText.isNotListening ? _startListening : _stopListening,
              child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic)),
          suffixIcon: IconButton(
              onPressed: () {
                 controller.clear();
              },
              icon: CancelIconWidget()),
        ),
      ),
    );
  }
}
