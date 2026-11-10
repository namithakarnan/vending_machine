import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';

Widget outlineButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: goldLight,
        side: BorderSide(color: gold.withValues(alpha: 0.6)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(text),
    ),
  );
}
