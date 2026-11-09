import 'package:flutter/material.dart';

import 'package:vending_machine/utils/colors.dart';

Widget microphone({
  double size = 150,
  required AnimationController pulseController,
}) {
  return AnimatedBuilder(
    animation: pulseController,
    builder: (context, child) {
      final pulse = pulseController.value;

      return SizedBox(
        width: size + 72,
        height: size + 72,
        child: Stack(
          alignment: Alignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Container(
                width: size + 20 + i * 24 + pulse * 8,
                height: size + 20 + i * 24 + pulse * 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: gold.withValues(alpha: 0.18 - i * 0.045),
                    width: 1,
                  ),
                ),
              ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF503016), Color(0xFF170D07)],
                ),
                border: Border.all(
                  color: goldLight.withValues(alpha: 0.9),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gold.withValues(alpha: 0.13 + pulse * 0.17),
                    blurRadius: 30 + pulse * 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.mic_none_rounded,
                size: size * 0.42,
                color: ivory,
              ),
            ),
          ],
        ),
      );
    },
  );
}
