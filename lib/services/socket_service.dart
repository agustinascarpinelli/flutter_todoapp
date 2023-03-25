import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier{
ServerStatus _serverStatus =ServerStatus.Connecting;
late IO.Socket _socket;
ServerStatus get serverStatus=>_serverStatus;
IO.Socket get socket =>_socket;

SocketService(){
_initConfig();
}

void _initConfig(){
  _socket = IO.io('https://flutter-socket-server-oxcf.onrender.com/',{
  'transports':['websocket'],
  'autoConnect':true
});


  _socket.onConnect((_) {
    print('connect');
    _serverStatus=ServerStatus.Online;
    notifyListeners();
   
  });
  
  _socket.onDisconnect((_) {
    print('disconnect');
   _serverStatus=ServerStatus.Offline;
   notifyListeners();
});
//Emitir un msj




//Escuchar un msj
//socket.on('new-message',(payload){
//print('New message:');
//print('Name:' +payload['name']);
//print(payload.containsKey('msg')? payload['msg']: 'No hay mensaje');
//});

}

}