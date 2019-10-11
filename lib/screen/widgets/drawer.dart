import 'package:flutter/material.dart';
import 'package:fatequino_app/services/Apis_call.dart' as api;

class DrawerCuston extends StatefulWidget {
  String host;
  String port;
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
          FlatButton(
            child: Text("Alterar"),
            onPressed: () {
              setState(() {
                api.host = widget.host;
                api.port = widget.port;
              });
            },
          ),
          Text("host: ${api.host}"),
          Text("port: ${api.port}"),
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
