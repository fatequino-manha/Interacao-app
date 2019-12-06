import "package:flutter/material.dart";
import 'package:speech_recognition/speech_recognition.dart';

class AudioButton extends StatefulWidget {
  AudioButton(this.send, this.value);
  TextEditingController send;
  String texto;
  var value;
  List<Widget> lista;
  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvaliable = false;
  String _currentLocale;
  bool _isListening = false;
  @override
  void initState() {
    super.initState();
    loadSpeech();
  }

  void loadSpeech() {
    _speech = SpeechRecognition();
    _speech.setAvailabilityHandler((bool result) {
      setState(() {
        _speechRecognitionAvaliable = result;
      });
    });

    _speech.setCurrentLocaleHandler((String locale) {
      setState(() {
        _currentLocale = locale;
      });
    });

    _speech.setRecognitionStartedHandler(() {
      setState(() {
        _isListening = true;
      });
    });

    _speech.setRecognitionResultHandler((String texto) {
      setState(() {
        widget.send.text = texto;
        widget.value._text = texto;
        widget.value.sets();
      });
    });

    _speech.setRecognitionCompleteHandler(() {
      setState(() {
        _isListening = false;
        widget.value.sets();
      });
    });

    _speech.activate().then((res) {
      setState(() {
        _speechRecognitionAvaliable = res;
      });
    });
  }

  @override
  build(BuildContext context) {
    return IconButton(
        icon: Icon(_isListening ? Icons.stop : Icons.mic),
        onPressed: () {
          _speech
              .listen(locale: _currentLocale)
              .then((value) { print("$value");});
        });
  }
}
