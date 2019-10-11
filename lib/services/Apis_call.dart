library fatequino.api;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String _host = null;
String _port = null;
bool ligado = false;

String get host => _host;

set host(value) {
  _host = value;
}

String get port => _port;
set port(value) {
  _port = value;
}

makeConnection() async {
  if (_host == null) {
    throw ("host Null");
  }
  String text = "Erro";
  var d = await Timer(Duration(seconds: 10), () async {
    var response = await http.post("http://$host:$port/...");
    if (response.statusCode != 200) {
      throw ("erro");
    }
    text = response.body;
  });
  return text;
}

Future<String> sendMensagem({String mensagem}) async {
  if (_host == null) {
    throw ("host Null");
  }
  var response;
  try {
    response = await http.post("http://$host:$port/",
        body: '"text":"$mensagem"',
        headers: {"Content-Type": "application/json"});
  } catch (e) {
    return "";
  }
  if (response.statusCode != 200) {
    throw ("erro");
  }
  var fatequino_resposta = jsonDecode(response.body);

  return fatequino_resposta['text'];
}
