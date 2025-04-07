import 'package:flutter/material.dart';
import 'package:todo/todo_form.dart';
import 'package:todo/todo_list.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData.dark(useMaterial3: false),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: const MyHomePage(title: 'T O D O'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TodoForm();
      },
    ).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: Icon(Icons.check_box),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.help))],
      ),
      body: TodoList(),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey.shade300,
        hoverColor: Colors.green,
        onPressed: () {
          showModal();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
