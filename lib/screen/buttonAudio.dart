import "package:flutter/material.dart";
import 'package:speech_recognition/speech_recognition.dart';

class AudioButton extends StatefulWidget {
  String texto;
  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvaliable = false;
  String _currentLocale;
  bool _isListening = false;
  bool _end = true;

  _AudioButtonState() {
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
        widget.texto = texto;
        _end = true;
      });
    });

    _speech.setRecognitionCompleteHandler(() {
      setState(() {
        _isListening = false;
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
      onPressed: () async {
        print("\n\n\n$_isListening\n\n\n\n");
        var retorno = await _speech.listen(locale: _currentLocale);
        print("$retorno");
      },
    );
  }
}
