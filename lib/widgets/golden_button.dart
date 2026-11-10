import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';

Widget goldButton(
  String text,
  VoidCallback onPressed, {
  IconData icon = Icons.mic_none_rounded,
}) {
  return SizedBox(
    width: double.infinity,
    height: 54,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.4),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: bg,
        backgroundColor: gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
