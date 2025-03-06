import 'package:flutter/material.dart';

class Appbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? color;
  final Widget child;
  final List<Color>? gradient;
  const Appbutton(
      {super.key,
      required this.onPressed,
      this.color,
      required this.child,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: gradient != null
            ? WidgetStateProperty.all<Color>(Colors.transparent)
            : color == null
                ? WidgetStateProperty.all<Color>(const Color(0xff25c26e))
                : WidgetStateProperty.all<Color>(color!),
      ),
      child: Ink(
          decoration: BoxDecoration(
            gradient: gradient == null
                ? null
                : LinearGradient(
                    colors: gradient!,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
              constraints: gradient == null
                  ? null
                  : const BoxConstraints(minHeight: 50), // Minimum height
              alignment: Alignment.center,
              child: child)),
    );
  }
}
