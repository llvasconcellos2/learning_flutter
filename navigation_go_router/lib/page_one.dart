import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_go_router/page_one_details.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page One')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Home'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(PageOneDetails.routeName);
              },
              child: const Text('Page One Details'),
            ),
          ],
        ),
      ),
    );
  }
}
