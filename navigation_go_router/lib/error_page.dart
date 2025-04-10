import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ERRRRROOOOO')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text('Página não encontrada')],
        ),
      ),
    );
  }
}
