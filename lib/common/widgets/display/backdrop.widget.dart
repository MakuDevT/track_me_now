import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {
  final Widget? child;
  final Color? color;

  const Backdrop({super.key, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white.withOpacity(0.7),
      child: child,
    );
  }
}
