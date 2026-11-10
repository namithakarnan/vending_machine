import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';

Widget productCan() {
  return Container(
    width: 105,
    height: 155,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(
        colors: [Color(0xFF8B1712), Color(0xFFEF3929), Color(0xFF9D1710)],
        stops: [0, 0.48, 1],
      ),
      border: Border.all(color: goldLight.withValues(alpha: 0.45)),
      boxShadow: [
        BoxShadow(color: Colors.orange.withValues(alpha: 0.15), blurRadius: 35),
      ],
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_drink, color: ivory, size: 33),
        SizedBox(height: 12),
        Text(
          'COLA',
          style: TextStyle(
            color: ivory,
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 6),
        Text('330 ml', style: TextStyle(color: ivory, fontSize: 10)),
      ],
    ),
  );
}
