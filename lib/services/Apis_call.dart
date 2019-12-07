library fatequino.api;

/** Biblioteca para comunicação com as api do fatequino */

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

Future<String> sendMensagem({String mensagem}) async {
  print("$host,$port");
  var response = await http.post('${_httpP}://${_host}:${_port}/',
      body: '{"text":"$mensagem"}',
      headers: {"content-type": "application/json"});
  if (response.statusCode != 200) {
    throw ("${response.body}");
  }
  var fatequinoResposta = jsonDecode(response.body);
  print(response.body);

  return fatequinoResposta['text'];
}
