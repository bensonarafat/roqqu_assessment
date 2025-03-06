import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget? label;
  const AppInputField({
    super.key,
    this.prefix,
    this.suffix,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          isDense: true,
          label: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff373b3f)
                  : const Color(0xfff1f1f1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xff373b3f)
                  : const Color(0xfff1f1f1),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix),
    );
  }
}
