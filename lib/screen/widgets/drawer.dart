import 'package:flutter/material.dart';
import 'package:fatequino_app/services/Apis_call.dart' as api;

class DrawerCuston extends StatefulWidget {
  /** Drawer de configuraçoes do fatequino para conexão 
   * Classe não permanente apenas usada para conectar a api.
  */
  String host;
  String port;
  String httpP;
  @override
  _DrawerCustonState createState() => _DrawerCustonState();
}

class _DrawerCustonState extends State<DrawerCuston> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Host"),
            onChanged: (e) => widget.host = e,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Port"),
            onChanged: (e) => widget.port = e,
          ),
          TextField(
            decoration: InputDecoration(hintText: "http"),
            onChanged: (e) => widget.httpP = e,
          ),
          FlatButton(
            child: Text("Alterar"),
            onPressed: () {
              setState(() {
                api.host = widget.host;
                api.port = widget.port;
                api.httpP = widget.httpP;
              });
            },
          ),
          Text("host: ${api.host}"),
          Text("port: ${api.port}"),
          Text("http: ${api.httpP}"),
          Spacer(),
          Switch(
            onChanged: (e) {
              api.ligado = e;
            },
            value: api.ligado,
          )
        ],
      ),
    );
  }
}
