import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String text;

  const CalcButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Color(0xffeb1555),
        margin: EdgeInsets.only(top: 10),
        height: 80,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
