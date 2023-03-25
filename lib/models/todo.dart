import 'package:flutter/foundation.dart';

class Todo {
  String? id;
  String? name;
  int? rank;


  Todo ({
    this.id,
    this.name,
    this.rank,
  });


  factory Todo.fromMap(Map<String,dynamic>obj)=>Todo(
    
      id:obj.containsKey('id')?obj['id']:'noid',
      name:obj.containsKey('name')?obj['name']:'noname',
      rank:obj.containsKey('rank')?obj['rank']:0,
    
  );
}
