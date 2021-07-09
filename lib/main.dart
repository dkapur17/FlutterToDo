import 'package:flutter/material.dart';
import 'package:todo_list/pages/list_todos.dart';
import 'package:todo_list/pages/add_todo.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListTodos(),
        '/add': (context) => AddTodo(),
      },
    );
  }
}
