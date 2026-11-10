import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machine/main.dart';
import 'package:vending_machine/provider/voice_provider.dart';
import 'package:vending_machine/utils/colors.dart';
import 'package:vending_machine/widgets/brand.dart';
import 'package:vending_machine/widgets/heading.dart';
import 'package:vending_machine/widgets/microphone.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController pulseController;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    Provider.of<VoiceProvider>(context, listen: false).initialize();
  }

  @override
  void dispose() {
    pulseController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        const Text(
          'VOICE-POWERED  •  SIMPLE  •  SEAMLESS',
          style: TextStyle(color: muted, fontSize: 9, letterSpacing: 1.5),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
