import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = 'profile';
  final String name;
  const ProfilePage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Page')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
    );
  }
}
