import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController taskController = new TextEditingController();
  SnackBar emptyTask = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "You need a task!",
          style: TextStyle(color: Colors.cyan[700]),
        ),
      ],
    ),
    duration: Duration(seconds: 1),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text("Add a new To DO"),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0,
        ),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("What's the Task?",
                    style: TextStyle(color: Colors.cyan[700], fontSize: 20)),
                SizedBox(height: 20),
                TextField(
                  controller: taskController,
                  cursorColor: Colors.cyan[700],
                  style: TextStyle(fontSize: 15, color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        String task = taskController.text;
                        if (task != "") {
                          taskController.text = "";
                          Navigator.pop(context, {'task': task});
                        } else
                          Scaffold.of(context).showSnackBar(emptyTask);
                      },
                      color: Colors.cyan[700],
                      child: Text("Add To-Do"),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
