import 'package:flutter/material.dart';
import 'package:vending_machine/utils/colors.dart';
import 'package:vending_machine/widgets/brand.dart';
import 'package:vending_machine/widgets/heading.dart';
import 'package:vending_machine/widgets/microphone.dart';

Widget welcomeScreen() {
  return Column(
    key: const ValueKey('welcome'),
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 20),
      brand(),
      const SizedBox(height: 40),
      heading(
        'Welcome!',
        'Just speak to get your\nfavorite drink or snack.',
        // 'What Can I Get You, Drink or Snack?',
        size: 38,
      ),
      const SizedBox(height: 25),

      Image.asset(
        'assets/images/land.png',
        fit: BoxFit.fill,
        width: 100,
        height: 200,
      ),

      SizedBox(height: 10),
      microphone(size: 80, pulseController: pulseController),
      const SizedBox(height: 12),
      const Text(
        'Say "Start" to begin',
        style: TextStyle(color: goldLight, fontSize: 12, letterSpacing: 3),
      ),
      const SizedBox(height: 22),
      // const Text(
      //   'TRY SAYING',
      //   style: TextStyle(color: muted, fontSize: 11, letterSpacing: 2.5),
      // ),
      // const SizedBox(height: 14),
      // Wrap(
      //   spacing: 9,
      //   runSpacing: 9,
      //   alignment: WrapAlignment.center,
      //   children: [
      //     GestureDetector(
      //       onTap: () => simulateVoiceRequest('Coke'),
      //       child: commandChip('Get me a Coke', Icons.local_drink_outlined),
      //     ),
      //     GestureDetector(
      //       onTap: () => simulateVoiceRequest('Chips'),
      //       child: commandChip('I want chips', Icons.fastfood_outlined),
      //     ),
      //     GestureDetector(
      //       onTap: () => simulateVoiceRequest('Water'),
      //       child: commandChip('Get a water', Icons.water_drop_outlined),
      //     ),
      //   ],
      // ),
      // const SizedBox(height: 22),
      // goldButton('Preview listening screen', startListening),
      // const SizedBox(height: 12),
      const Text(
        'VOICE-POWERED  •  SIMPLE  •  SEAMLESS',
        style: TextStyle(color: muted, fontSize: 9, letterSpacing: 1.5),
      ),
      const SizedBox(height: 15),
    ],
  );
}
