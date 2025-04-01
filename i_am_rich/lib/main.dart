import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blueGrey,
        primaryTextTheme: TextTheme(
          headlineLarge: TextStyle(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          title: Text('I Am Rich', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(child: Image.asset('images/diamond.png')),
      ),
    ),
  );
}
