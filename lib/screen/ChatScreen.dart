import 'package:fatequino_app/screen/ChoiceScreen.dart';
import 'package:fatequino_app/screen/buttonAudio.dart';
import 'package:fatequino_app/screen/widgets/mensage.dart';
import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'style.dart' as style;
import 'package:fatequino_app/services/Apis_call.dart' as api;

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatScreen();
  }
}

class _ChatScreen extends State<ChatScreen> {
  static TextEditingController txt = TextEditingController();
  static FocusNode _focusNode = new FocusNode();
  static List<Widget> _chatMensagem = [];
  Widget _button;
  String _text = "";
  SpeechRecognition _speech;

  bool _speechRecognitionAvaliable = false;

  String _currentLocale;

  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: style.secundaryColor,
          title: Text(
            "FATEQUINO :)",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _chatMensagem,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.all(5),
                  color: style.colorPrimary,
                  child: Form(
                    child: TextFormField(
                      onChanged: (e) {
                        setState(() {
                          _text = e;
                        });
                      },
                      maxLines: 3,
                      minLines: 1,
                      controller: txt,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffixIcon: sendMensagemButton(),
                        prefixIcon: audiobutton(),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendMensagemButton() {
    return IconButton(
      icon: Icon(Icons.send),
      color: Colors.yellow,
      onPressed: _text.trim().isNotEmpty
          ? () {
              if (!api.ligado) {
                api.sendMensagem(mensagem: this._text.trim()).then((value) {
                  Widget meu;
                  Widget fatequino;
                  print("passei aqui");
                  meu = Mensagem(
                    mensagem: this._text,
                    minha: true,
                  );
                  fatequino = Mensagem(
                    mensagem: value,
                    minha: false,
                  );
                  setState(() {
                    _chatMensagem.add(meu);
                    _chatMensagem.add(fatequino);
                    cleanInput();
                  });
                }).catchError((erro) {
                  debugPrint(erro.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChoiceScreen(),
                    ),
                  );
                });
              } else {
                _chatMensagem.add(
                  Mensagem(
                    mensagem: this._text,
                    minha: true,
                  ),
                );
                _chatMensagem.add(
                  Mensagem(
                    mensagem: "Mensagem fatequino",
                    minha: false,
                  ),
                );
                cleanInput();
              }
            }
          : null,
    );
  }

  void cleanInput() async {
    Future.delayed(Duration(milliseconds: 100), () {
      this.setState(() {
        txt.clear();
        this._text = "";
      });
    });
  }

  Widget audiobutton() {
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
        txt.text = texto;
        _text = texto;
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
    return IconButton(
        icon: Icon(_isListening ? Icons.stop : Icons.mic),
        onPressed: () {
          _speech.listen(locale: _currentLocale).then((value) {
            print("$value");
          });
        });
  }
}
