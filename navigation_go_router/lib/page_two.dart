import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final String greetings;
  const PageTwo({super.key, required this.greetings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Two')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text(greetings)],
        ),
      ),
    );
  }
}
