import 'dart:html';
import 'dart:convert' show JSON;
import 'dart:async' show Future;

void main() {
  Server.readyTheServers()
    .then((_) {
      loadServers();
    })
    .catchError((arrr) {
      print('Error initializing pirate names: $arrr');
    });
}

void loadServers() {
  for(var server in Server.servers) {
    print('Server: $server');
  }
}

class Server {
  static List<Server> servers = [];
  
  String _hostname;
  String _domain;
  String _dataCenter;
  String _serverType;
  int _cores;
  int _ram;
  int _hdd;
  
  Server.fromJSON(String jsonString) {
    Map server = JSON.decode(jsonString);
    _hostname   = server['hostname'];
    _domain     = server['domain'];
    _dataCenter = server['dataCenter'];
    _serverType = server['serverType'];
    _cores      = server['cores'];
    _ram        = server['ram'];
    _hdd        = server['hdd'];
  }
  
  static Future readyTheServers() {
    return HttpRequest.getString('servers.json')
        .then(_parseServersFromJSON);
  }
  
  static _parseServersFromJSON(String jsonString) {
    servers = JSON.decode(jsonString);
    print('Servers: $servers');
  }
}