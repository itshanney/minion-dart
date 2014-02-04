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
  TableElement table = querySelector('#servers');
  TableSectionElement tBody = table.createTBody();
  
  for(var server in Server.servers) {
    print('Server: $server');
    
    TableRowElement serverRow = tBody.insertRow(tBody.rows.length);
    serverRow.insertCell(0).text = server['hostname'];
    serverRow.insertCell(1).text = server['domain'];
    serverRow.insertCell(2).text = server['dataCenter'];
    serverRow.insertCell(3).text = server['serverType'];
    serverRow.insertCell(4).text = server['os'];
    serverRow.insertCell(5).text = server['cores'].toString();
    serverRow.insertCell(6).text = server['ram'].toString();
    serverRow.insertCell(7).text = server['hdd'].toString();
    serverRow.insertCell(8).text = server['tco'].toString();
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
  int _tco;
  
  Server.fromJSON(String jsonString) {
    Map server = JSON.decode(jsonString);
    _hostname   = server['hostname'];
    _domain     = server['domain'];
    _dataCenter = server['dataCenter'];
    _serverType = server['serverType'];
    _cores      = server['cores'];
    _ram        = server['ram'];
    _hdd        = server['hdd'];
    _tco        = server['tco'];
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