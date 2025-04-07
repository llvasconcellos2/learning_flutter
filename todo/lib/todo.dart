enum TodoPriority {
  low('Baixa'),
  normal('Normal'),
  high('Alta');

  final String desc;
  const TodoPriority(this.desc);
}

class Todo {
  int id;
  String name;
  TodoPriority priority;
  bool completed;

  Todo({
    required this.id,
    required this.name,
    required this.priority,
    this.completed = false,
  });

  static List<Todo> todos = [];
}
