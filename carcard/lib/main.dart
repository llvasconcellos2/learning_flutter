import 'package:carcard/input_widgets_page.dart';
import 'package:carcard/profile_page.dart';
import 'package:flutter/material.dart';

import 'bmw_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PageView(
          children: [InputWidgetsPage(), BMWPage(), ProfilePage()],
        ),
      ),
    );
  }
}
