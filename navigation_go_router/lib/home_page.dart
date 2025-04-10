import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_go_router/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/one');
              },
              child: const Text('Page One'),
            ),
            ElevatedButton(
              onPressed: () {
                //context.goNamed('two', extra: 'Hello Flutter');
                context.pushNamed('two', extra: 'PUSHED FLutter');
              },
              child: const Text('Page Two'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(
                  ProfilePage.routeName,
                  pathParameters: {'name': 'Leonardo'},
                );
              },
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/error');
              },
              child: const Text('Error Page'),
            ),
          ],
        ),
      ),
    );
  }
}
