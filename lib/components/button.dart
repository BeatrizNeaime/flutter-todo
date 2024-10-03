import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String label;
  VoidCallback onPressed;

  Button({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      height: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 16,
          fontFamily: 'OpenSans',
        ),
      ),
    );
  }
}
