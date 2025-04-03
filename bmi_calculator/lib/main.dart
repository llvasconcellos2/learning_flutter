import 'package:flutter/material.dart';

import 'screens/input_page.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(useMaterial3: false),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0x000a0e21),
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pinkAccent,
          primary: Colors.red,
          secondary: Colors.pink,
          brightness: Brightness.dark,
        ),
        highlightColor: Colors.red,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      home: InputPage(),
      initialRoute: '/',
      // routes: {'/result': (context) => ResultPage()},
    );
  }
}
