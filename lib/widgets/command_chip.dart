import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';

Widget commandChip(String text, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.025),
      border: Border.all(color: gold.withValues(alpha: 0.45)),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: gold, size: 17),
        const SizedBox(width: 9),
        Flexible(
          child: Text(text, style: const TextStyle(color: ivory, fontSize: 12)),
        ),
      ],
    ),
  );
}
