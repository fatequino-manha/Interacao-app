library fatequino.api;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String _host = null;
String _port = null;
String _httpP = null;
bool ligado = false;

String get httpP => _httpP;

set httpP(value){
  _httpP = value;
}

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
    // var response = await http.post("http://$host:$port/");
    var response = await http.post("http://192.168.0.114:8080/");
    if (response.statusCode != 200) {
      throw ("erro");
    }
    text = response.body;
  });
  return text;
}

Future<String> sendMensagem({String mensagem}) async {
  // if (_host == null) {
  //   throw ("host Null");
  // }
  // http://$host:$port
  print("$host,$port");
  print(mensagem);
  // var response = await http.post('${_httpP}://${_host}:${_port}/',
  var response = await http.post("http://192.168.0.114:8080/",
      body: '{"text":"$mensagem"}',
      headers: {"content-type": "application/json"});
  if (response.statusCode != 200) {
    throw ("${response.body}");
  }
  var fatequino_resposta = jsonDecode(response.body);
  print(response.body);

  return fatequino_resposta['text'];
}
