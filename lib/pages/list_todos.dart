import 'package:flutter/material.dart';
import 'package:todo_list/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ListTodos extends StatefulWidget {
  @override
  _ListTodosState createState() => _ListTodosState();
}

class _ListTodosState extends State<ListTodos> {
  // Data Members
  List<dynamic> todos;
  String encodedTodos;
  bool completedInitialFetch;
  Icon completed = Icon(
    Icons.beenhere,
    size: 30,
    color: Colors.green,
  );
  Icon incomplete = Icon(
    Icons.access_time,
    size: 30,
    color: Colors.red,
  );

  // Methods
  @override
  void initState() {
    super.initState();
    todos = [];
    encodedTodos = "[]";
    completedInitialFetch = false;
    fetchTodos();
  }

  // Store Related
  Future<void> fetchTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    encodedTodos = prefs.getString('todos') ?? "[]";
    List<dynamic> rawTodos = jsonDecode(encodedTodos);
    rawTodos.forEach((todo) {
      setState(() {
        todos
            .add(Todo(task: todo['task'], completed: todo['completed'] == "1"));
      });
    });
    completedInitialFetch = true;
  }

  Future<void> updateTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    encodedTodos = jsonEncode(todos);
    prefs.setString('todos', encodedTodos);
  }

  Future<void> resetTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', "[]");
  }

  @override
  Widget build(BuildContext context) {
    if (completedInitialFetch) updateTodos();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: todos.length > 0
          ? ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(1, 4, 1, 0),
                  child: Card(
                    color: Colors.grey[todos[index].completed ? 850 : 800],
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          todos[index].completed = !todos[index].completed;
                        });
                      },
                      leading: todos[index].completed ? completed : incomplete,
                      title: Text(
                        todos[index].task,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            todos.removeAt(index);
                          });
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.cyan[700],
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              children: <Widget>[
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Woohoo!",
                      style: TextStyle(fontSize: 50, color: Colors.cyan[700]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "You're all caught up!",
                      style: TextStyle(fontSize: 30, color: Colors.grey[700]),
                    ),
                  ],
                )
              ],
            ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            dynamic data = await Navigator.pushNamed(context, '/add');
            if (data != null) {
              setState(() {
                todos.add(Todo(task: data['task']));
              });
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Added \"${data['task']}\"",
                      style: TextStyle(color: Colors.cyan[700])),
                ],
              )));
            }
          },
          backgroundColor: Colors.cyan[700],
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}
