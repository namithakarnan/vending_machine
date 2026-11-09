import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';

Widget heading(String title, String subtitle, {double size = 34}) {
  return Column(
    children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: gold,
          fontSize: size,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.4,
        ),
      ),
      const SizedBox(height: 14),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style: const TextStyle(color: goldLight, fontSize: 15, height: 1.7),
      ),
    ],
  );
}
