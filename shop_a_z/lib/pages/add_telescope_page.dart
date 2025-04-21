import 'package:flutter/material.dart';

class AddTelescopePage extends StatefulWidget {
  static const String routeName = 'add_telescope';
  const AddTelescopePage({super.key});

  @override
  State<AddTelescopePage> createState() => _AddTelescopePageState();
}

class _AddTelescopePageState extends State<AddTelescopePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('add telescope')),
    );
  }
}
