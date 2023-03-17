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
    
      id:obj['id'],
      name:obj['name'],
      rank:obj['rank']
    
  );
}
