import 'package:fatequino_app/screen/ChoiceScreen.dart';
import 'package:fatequino_app/screen/buttonAudio.dart';
import 'package:fatequino_app/screen/widgets/mensage.dart';
import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:fatequino_app/services/Apis_call.dart' as api;

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatScreen();
  }
}

class _ChatScreen extends State<ChatScreen> {
  static TextEditingController txt = TextEditingController();
  static FocusNode _focusNode = new FocusNode();
  static List<Widget> _chatMensagem = [];
  static ScrollController _scroolController = new ScrollController();
  bool _sendEnabled = false;
  Widget _button;

  _ChatScreen() {
    _button = AudioButton(this.add);
  }

  void add(Mensagem eu, Mensagem fatequino){
    setState(() {
      _chatMensagem.add(eu);
      _chatMensagem.add(fatequino);
    });
  }

  String _text = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                child: TextField(
                  onChanged: (e) {
                    _text = e;
                    String teste = _text.trim();
                    if (teste.isNotEmpty) {
                      setState(() {
                        this.selectbutton(1);
                      });
                    } else {
                      setState(() {
                        this.selectbutton(2);
                      });
                    }
                  },
                  maxLines: 3,
                  minLines: 1,
                  controller: txt,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: _button,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectbutton(int widget) {
    if (widget == 1) {
      _button = this.sendMensagemButton();
    }
    if (widget == 2) {
      _button = AudioButton(this.add);
    }
  }

  Widget audioButton() {
    return IconButton(
      icon: Icon(Icons.mic),
      onPressed: () {},
    );
  }

  Widget sendMensagemButton() {
    return IconButton(
      icon: Icon(Icons.send),
      color: Colors.yellow,
      onPressed: () {
        if (!api.ligado) {
          api.sendMensagem(mensagem: this._text).then((value) {
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
      },
    );
  }

  void cleanInput() async {
    Future.delayed(Duration(milliseconds: 100), () {
      this.setState(() {
        txt.clear();
        this._text = "";
        this.selectbutton(2);
      });
    });
  }
}
