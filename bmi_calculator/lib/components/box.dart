import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Color bgColor;
  final Widget? child;
  final GestureTapCallback? onTap;

  const Box({super.key, required this.bgColor, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: child,
      ),
    );
  }
}
