import 'dart:io';
import 'dart:ui';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:band_names_app/models/todo.dart';
import '../services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List <Todo> todos=[

];

@override
  void initState() {
     final socketService=Provider.of<SocketService>(context,listen:false);
     socketService.socket.on('active-todos', _handleActiveTodos);


    super.initState();
  }

 _handleActiveTodos(dynamic payload){
      todos=(payload as List)
      .map((todo) => Todo.fromMap(todo) ).toList();
      //setState para que redibuje el widget completo cuando se reciba un evento del tipo'active-todos'
      setState((){});
 }


//Si se destruye la pantalla dejamos de escuchar
@override
  void dispose() {
    final socketService=Provider.of<SocketService>(context,listen:false);
    socketService.socket.off('active-todos');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
 String convertedDateTime = "${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')}   ${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}";
       
   
   final socketService=Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(convertedDateTime,style: TextStyle(color:Colors.black87),)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin:const EdgeInsets.only(right: 10),
            child:socketService.serverStatus==ServerStatus.Online ?
             Icon(Icons.check_circle,color: Colors.green[200],):
              const Icon(Icons.offline_bolt,color: Colors.grey,),
          )
        ],
      ),
        
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:  todos.isEmpty?  Center(child: Text('Add a todo')) : Column(

children: [
  Text('Todos of the day',style: TextStyle(color: Colors.pinkAccent,fontSize: 15),),

  _showGraph(),
  //El expanded toma todo el espacio disponible en base a esta columna
  Expanded
  (
    child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int i) => _todosTile(todos[i])
            ),
  ),
],
        ),
      ),
        floatingActionButton:FloatingActionButton(
          onPressed:addNewTodo,
          elevation: 1,
          backgroundColor: Colors.pink,
          child: const Icon(Icons.add),
           ),
    );
  }

 _todosTile(Todo todo) {
 final socketService=Provider.of<SocketService>(context,listen: false);
    return Dismissible(
      key: Key(todo.id!),
      direction: DismissDirection.endToStart,
      onDismissed: (_){
       
        socketService.socket.emit('delete-todo',{'id':todo.id});
        //borrar en el server
      },
      background: Container(
        padding: const EdgeInsets.only(right: 10.0),
        color: Colors.grey,
        // ignore: prefer_const_constructors
        child: Align(
          alignment: Alignment.centerRight,
          child: const Text('Delete todo',style:TextStyle(color: Colors.white))),
      ),
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Text(todo.name!.toUpperCase().substring(0,1),style: TextStyle(color: Colors.pink[50]),),
            ),
            title: Text(todo.name!,style: TextStyle(color: Colors.pink[300])),
            trailing: FittedBox(
    child: Row(
      children: [
        IconButton(
          onPressed: () {
                 socketService.socket.emit('unRank-todo',{'id':todo.id});
          },
          icon: Icon(Icons.remove),
          color: Colors.pinkAccent
        ),
         Text('${todo.rank! }hr',style: const TextStyle(color: Colors.pink, fontSize: 20),),
        IconButton(
          onPressed: () {
             socketService.socket.emit('rank-todo',{'id':todo.id});
          },
          icon: Icon(Icons.add),
           color: Colors.pinkAccent
        ),
      ],
    ),
  ),
          ),
    );
  }

  addNewTodo(){
    final textControler=TextEditingController();
    if (Platform.isAndroid){
   return showDialog(
      context: context,
       builder: (_)=> AlertDialog(
          title: Text('New todo:',style: TextStyle(color: Colors.pink[200]),),
          content: TextField(cursorColor:Colors.pink[50],controller: textControler,),
          actions: [
            MaterialButton(
              elevation: 5,
              onPressed: ()=>addTodo(textControler.text),
              child: Text('ADD',style: TextStyle(color: Colors.pink[200]),))
          ],
        )
       );
       }
      
    showCupertinoDialog(
      context: context,
       builder: (_)=>  CupertinoAlertDialog(
          title:  Text('New todo:',style: TextStyle(color: Colors.pink[200]),),
          content: CupertinoTextField(cursorColor:Colors.pink[50],controller: textControler),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => addTodo(textControler.text),
              child: Text('ADD',style: TextStyle(color: Colors.pink[200]),),
              ),
                   CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
              child: Text('Dismiss',style: TextStyle(color: Colors.pink[200]),),
              )
          ],

        )
       );
  }

  void addTodo(String name){

if(name.length>1){
  final socketService=Provider.of<SocketService>(context,listen:false);
 socketService.socket.emit('new-todo',{'name':name});
  //Puedo agregar
}
Navigator.pop(context);
  }


  _showGraph(){
    Map <String, double>dataMap =new Map();
    todos.forEach((todo) {
   dataMap.putIfAbsent(todo.name!, () => todo.rank!.toDouble());
     });

 final List<Color>colorList=[

  Colors.pinkAccent,
  Colors.pink,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,


  

 ] ;        

return Container(
  width: double.infinity,
  height: 200,
  
  child: PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "Day",
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape:BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
 
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
      // gradientList: ---To add gradient colors---
      // emptyColorGradient: ---Empty Color gradient---
    ));
              
}
}