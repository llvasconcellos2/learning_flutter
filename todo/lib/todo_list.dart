import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          for (var item in Todo.todos)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name),
                        Text(
                          'Priority: ${item.priority.desc}',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: item.completed,
                      onChanged: (value) {
                        setState(() {
                          item.completed = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
