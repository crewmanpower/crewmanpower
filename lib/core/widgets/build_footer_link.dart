import 'package:flutter/material.dart';

Widget buildFooterLink(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white.withOpacity(0.75),
        fontSize: 13,
      ),
    ),
  );
}
