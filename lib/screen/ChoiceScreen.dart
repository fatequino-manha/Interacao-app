import 'package:fatequino_app/screen/ChatScreen.dart';
import 'package:fatequino_app/screen/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'style.dart' as style;

class ChoiceScreen extends StatelessWidget {
  /** Tela de escolha da comunicação (Wifi / bluetooth) */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: DrawerCuston(),
        ),
        appBar: AppBar(
          backgroundColor: style.secundaryColor,
          title: Text(
            "FATEQUINO :)",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  "Conversa com \n\t\t\to fatequino: ",
                  style: TextStyle(color: style.colorPrimary, fontSize: 30),
                  maxLines: 2,
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.wifi),
                  color: Colors.black,
                ),
                color: style.colorPrimary,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Web",
                  style: TextStyle(
                    color: style.colorPrimary,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: IconButton(
                  icon: Icon(
                    Icons.bluetooth,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                color: style.colorPrimary,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Bluetooth",
                  style: TextStyle(
                    color: style.colorPrimary,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "Versão 0.10",
                  style: TextStyle(color: style.colorPrimary),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
