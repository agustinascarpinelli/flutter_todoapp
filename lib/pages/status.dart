import 'package:band_names_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService=Provider.of<SocketService>(context);
    
    return Scaffold(
      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server status: ${socketService.serverStatus}')
          ],

        ),
    ),
    floatingActionButton: FloatingActionButton(
      child:Icon(Icons.message),
      onPressed: (){
socketService.socket.emit('new-message',{'name':'Agus','msg':'Hola desde flutter'});
print('Msg');
      }
      
      
      ),
    );
  }
}