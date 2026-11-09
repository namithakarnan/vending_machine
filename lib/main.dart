// import 'package:flutter/material.dart';
// import 'package:vending_machine/screens/landing_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
//       home: const LandingScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machine/provider/voice_provider.dart';
import 'package:vending_machine/utils/colors.dart';
import 'package:vending_machine/widgets/microphone.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => VoiceProvider(),
      child: const SmartVendingApp(),
    ),
  );
}

enum VendingState {
  welcome,
  listening,
  processing,
  confirmation,
  dispensing,
  success,
  error,
  ready,
}

class SmartVendingApp extends StatelessWidget {
  const SmartVendingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Vending',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(primary: gold, surface: panel),
      ),
      home: const VendingHome(),
    );
  }
}

class VendingHome extends StatefulWidget {
  const VendingHome({super.key});

  @override
  State<VendingHome> createState() => _VendingHomeState();
}

class _VendingHomeState extends State<VendingHome>
    with TickerProviderStateMixin {
  VendingState state = VendingState.welcome;
  String product = 'Coke';
  Timer? timer;

  late final AnimationController pulseController;
  late final AnimationController waveController;

  @override
  void initState() {
    super.initState();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    timer?.cancel();
    pulseController.dispose();
    waveController.dispose();
    super.dispose();
  }

  void changeState(VendingState next) {
    timer?.cancel();
    if (!mounted) return;
    setState(() => state = next);
  }

  void startListening() {
    changeState(VendingState.listening);
  }

  // UI preview only: replace with actual speech recognition.
  void simulateVoiceRequest(String item) {
    product = item;
    changeState(VendingState.processing);

    timer = Timer(const Duration(seconds: 2), () {
      if (mounted) changeState(VendingState.confirmation);
    });
  }

  void confirmRequest() {
    changeState(VendingState.dispensing);

    // Preview only. Production code must wait for device status.
    timer = Timer(const Duration(seconds: 3), () {
      if (mounted) changeState(VendingState.success);
    });
  }

  void finishTransaction() {
    changeState(VendingState.ready);

    timer = Timer(const Duration(seconds: 3), () {
      if (mounted) changeState(VendingState.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.15,
            colors: [Color(0xFF2A190D), bg, Color(0xFF080605)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 18,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      switchInCurve: Curves.easeOutCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.025),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: buildScreen(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildScreen() {
    switch (state) {
      case VendingState.welcome:
        return welcomeScreen();
      case VendingState.listening:
        return listeningScreen();
      case VendingState.processing:
        return processingScreen();
      case VendingState.confirmation:
        return confirmationScreen();
      case VendingState.dispensing:
        return dispensingScreen();
      case VendingState.success:
        return successScreen();
      case VendingState.error:
        return errorScreen();
      case VendingState.ready:
        return readyScreen();
    }
  }

  Widget soundWaves() {
    return AnimatedBuilder(
      animation: waveController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(13, (index) {
            final distance = (index - 6).abs();
            final height =
                (12 + (6 - distance) * 7) *
                (0.55 + waveController.value * 0.45);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 3,
              height: height,
              decoration: BoxDecoration(
                color: gold.withValues(alpha: 0.45 + (6 - distance) * 0.07),
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        );
      },
    );
  }

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
            child: Text(
              text,
              style: const TextStyle(color: ivory, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

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
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: bg,
          backgroundColor: gold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget outlineButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: goldLight,
          side: BorderSide(color: gold.withValues(alpha: 0.6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(text),
      ),
    );
  }

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
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.15),
            blurRadius: 35,
          ),
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

  Widget listeningScreen() {
    return Column(
      key: const ValueKey('listening'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        heading("I'm listening...", 'What would you like?'),
        soundWaves(),
        microphone(size: 155),
        const Text(
          'LISTENING FOR YOUR REQUEST',
          style: TextStyle(color: goldLight, fontSize: 11, letterSpacing: 2),
        ),
        const Text(
          'Say “Get me a Coke” or “I want chips”',
          textAlign: TextAlign.center,
          style: TextStyle(color: muted, fontSize: 13),
        ),
        outlineButton(
          'Cancel preview',
          () => changeState(VendingState.welcome),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget processingScreen() {
    return Column(
      key: const ValueKey('processing'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        heading(
          'Processing...',
          'Let me check availability\nfor your request.',
        ),
        microphone(size: 115),
        const CircularProgressIndicator(color: gold, strokeWidth: 2),
        Text(
          'Checking availability for $product',
          style: const TextStyle(color: goldLight, fontSize: 14),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget confirmationScreen() {
    return Column(
      key: const ValueKey('confirmation'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        heading('Your selection', 'I heard you request:'),
        Text(
          product,
          style: const TextStyle(
            color: goldLight,
            fontSize: 34,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (product.toLowerCase() == 'coke')
          productCan()
        else
          Icon(
            product.toLowerCase() == 'water'
                ? Icons.water_drop_outlined
                : Icons.fastfood_outlined,
            size: 100,
            color: gold,
          ),
        const Text(
          'Say “Yes” to continue or “No” to try again.',
          textAlign: TextAlign.center,
          style: TextStyle(color: muted, fontSize: 14),
        ),
        goldButton('Yes, dispense', confirmRequest, icon: Icons.check_rounded),
        outlineButton('No, try again', startListening),
      ],
    );
  }

  Widget dispensingScreen() {
    return Column(
      key: const ValueKey('dispensing'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        heading(
          'Dispensing...',
          'Please wait while we prepare\nyour selection.',
        ),
        product == 'Coke'
            ? productCan()
            : Icon(
                product == 'Water'
                    ? Icons.water_drop_outlined
                    : Icons.fastfood_outlined,
                color: gold,
                size: 120,
              ),
        const LinearProgressIndicator(
          backgroundColor: Color(0xFF45301D),
          color: gold,
          minHeight: 4,
        ),
        const Text(
          'Your order is being prepared',
          style: TextStyle(color: muted, fontSize: 13),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget successScreen() {
    return Column(
      key: const ValueKey('success'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: gold, width: 2),
            boxShadow: [
              BoxShadow(color: gold.withValues(alpha: 0.18), blurRadius: 35),
            ],
          ),
          child: const Icon(Icons.check_rounded, color: goldLight, size: 75),
        ),
        heading(
          'Enjoy your drink!',
          '$product is ready.\nThank you for choosing us.',
        ),
        const Text(
          'DISPENSE CONFIRMED',
          style: TextStyle(color: gold, fontSize: 11, letterSpacing: 2.5),
        ),
        goldButton(
          'Finish',
          finishTransaction,
          icon: Icons.check_circle_outline,
        ),
      ],
    );
  }

  Widget errorScreen() {
    return Column(
      key: const ValueKey('error'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        const Icon(Icons.error_outline_rounded, color: errorRed, size: 85),
        heading(
          'Item Not Found',
          'Sorry, I couldn’t find that item.\nPlease try another request.',
          size: 29,
        ),
        commandChip('Try asking for water', Icons.water_drop_outlined),
        commandChip('Try asking for chips', Icons.fastfood_outlined),
        goldButton('Speak again', startListening),
        outlineButton(
          'Return to welcome',
          () => changeState(VendingState.welcome),
        ),
      ],
    );
  }

  Widget readyScreen() {
    return Column(
      key: const ValueKey('ready'),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        brand(),
        microphone(size: 135),
        heading('Ready!', 'Speak to choose\nyour next favorite.'),
        soundWaves(),
        goldButton('Start next interaction', startListening),
      ],
    );
  }
}
