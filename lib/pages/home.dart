import 'dart:io';

import 'package:band_names_app/models/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
List <Todo> todos=[
  Todo(id:'1',name:'Limpiar',rank: 1),
  Todo(id:'1',name:'Estudiar',rank: 2),
  Todo(id:'1',name:'Ejercicio',rank: 3),
  Todo(id:'1',name:'Compras',rank: 4)
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('List of todos',style: TextStyle(color:Colors.black87),)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
        
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int i) => _todosTile(todos[i])
        ),
        floatingActionButton:FloatingActionButton(
          onPressed:addNewTodo,
          elevation: 1,
          backgroundColor: Colors.pink,
          child: Icon(Icons.add),
           ),
    );
  }

 _todosTile(Todo todo) {
    return Dismissible(
      key: Key(todo.id!),
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        print('direction:$direction');
        //borrar en el server
      },
      background: Container(
        padding: EdgeInsets.only(right: 10.0),
        color: Colors.grey,
        // ignore: prefer_const_constructors
        child: Align(
          alignment: Alignment.centerRight,
          child: Text('Delete todo',style:TextStyle(color: Colors.white))),
      ),
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.pink[100],
              child: Text(todo.name!.toUpperCase().substring(0,1),style: TextStyle(color: Colors.pink[50]),),
            ),
            title: Text(todo.name!,style: TextStyle(color: Colors.pink[300])),
            trailing: Text('${todo.rank!}',style: const TextStyle(color: Colors.pink, fontSize: 20),),
            onTap: (){
              print(todo.name);
            },
          ),
    );
  }

  addNewTodo(){
    final textControler=TextEditingController();
    if (Platform.isAndroid){
    showDialog(
      context: context,
       builder: (BuildContext context){
        return AlertDialog(
          title: Text('New todo:',style: TextStyle(color: Colors.pink[200]),),
          content: TextField(cursorColor:Colors.pink[50],controller: textControler,),
          actions: [
            MaterialButton(
              elevation: 5,
              onPressed: ()=>addTodo(textControler.text),
              child: Text('ADD',style: TextStyle(color: Colors.pink[200]),))
          ],
        );
       }
       );
       }
       if (!Platform.isAndroid){
    showCupertinoDialog(
      context: context,
       builder: (BuildContext context){
        return  CupertinoAlertDialog(
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

        );
       }
       );
  }}

  void addTodo(String name){
if(name.length>1){
  todos.add(Todo(id:DateTime.now().toString(),name: name,rank: 5));
  setState(() {
    
  });
  //Puedo agregar
}
Navigator.pop(context);
  }
}