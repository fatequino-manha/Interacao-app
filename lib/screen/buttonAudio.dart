import 'package:fatequino_app/screen/widgets/mensage.dart';
import "package:flutter/material.dart";
import 'package:speech_recognition/speech_recognition.dart';
import 'package:fatequino_app/services/Apis_call.dart' as api;

class AudioButton extends StatefulWidget {
  AudioButton(this.send);
  Function send;
  List<Widget> lista;
  @override
  _AudioButtonState createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  SpeechRecognition _speech;
  bool _speechRecognitionAvaliable = false;
  String _currentLocale;
  bool _isListening = false;
  bool _end = true;
  String _texto;
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
        _texto = texto;
      });
    });

    _speech.setRecognitionCompleteHandler(() {
      setState(() {
        _isListening = false;
      });
      if (_isListening) {
        Mensagem eu = Mensagem(
          mensagem: _texto,
          minha: true,
        );
        Mensagem fatequino = Mensagem(
          mensagem: "oi",
          minha: false,
        );
        widget.send(eu, fatequino);
      }
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
        // if (_isListening) {
        //   _speech.stop().then((value) {
        //     _isListening = value;
        //   });
        // } else {
        // }
        if (!_isListening) {
          _speech.listen(locale: _currentLocale).then((value) {
            print("\n\n\n");
            _isListening = value;
            print("\n\n\n");
          });
        }
      },
    );
  }
}
