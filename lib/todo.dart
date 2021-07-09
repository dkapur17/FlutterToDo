class Todo {
  String task;
  bool completed;

  Todo({this.task, this.completed = false});

  Todo.fromJson(Map<String, String> json)
      : task = json['task'],
        completed = json['completed'] == "1";

  Map<String, String> toJson() =>
      {'task': task, 'completed': completed ? "1" : "0"};
}
