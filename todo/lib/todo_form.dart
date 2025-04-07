import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/todo.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final txtController = TextEditingController();
  TodoPriority priority = TodoPriority.normal;

  bool _save() {
    if (txtController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Atenção'),
            titlePadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(10),
            children: [
              Text('O campo de texto não pode ficar em branco.'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  // SizedBox(width: 10,),
                ],
              ),
            ],
          );
        },
      );
      return false;
    }
    var todo = Todo(id: 1, name: txtController.text, priority: priority);
    Todo.todos.add(todo);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: txtController,
          decoration: const InputDecoration(
            hintText: 'Entre sua tarefa',
            //labelText: 'Name',
            label: Row(
              children: [
                Icon(Icons.task),
                SizedBox(width: 10),
                Text('O que fazer?'),
              ],
            ),
          ),
          onChanged: (value) {
            if (kDebugMode) {
              print(value);
            }
          },
        ),
        SizedBox(height: 20),
        Text('Selecione a prioridade'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio<TodoPriority>(
              value: TodoPriority.low,
              groupValue: priority,
              onChanged: (TodoPriority? value) {
                setState(() {
                  priority = value!;
                });
              },
            ),
            Text(TodoPriority.low.desc),
            SizedBox(width: 10),
            Radio<TodoPriority>(
              value: TodoPriority.normal,
              groupValue: priority,
              onChanged: (TodoPriority? value) {
                setState(() {
                  priority = value!;
                });
              },
            ),
            Text(TodoPriority.normal.desc),
            SizedBox(width: 10),
            Radio<TodoPriority>(
              value: TodoPriority.high,
              groupValue: priority,
              onChanged: (TodoPriority? value) {
                setState(() {
                  priority = value!;
                });
              },
            ),
            Text(TodoPriority.high.desc),
          ],
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            if (_save()) {
              Navigator.pop(context);
            }
          },
          child: Text('SAVE'),
        ),
      ],
    );
  }
}
