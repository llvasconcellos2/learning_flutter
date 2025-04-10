import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageOneDetails extends StatelessWidget {
  static const routeName = 'one_details';
  const PageOneDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PageOneDetails')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
