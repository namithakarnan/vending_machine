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
import 'package:vending_machine/screens/welcome_screen.dart';
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

class VendingHome extends StatelessWidget {
  const VendingHome({super.key});

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
                      child: WelcomeScreen(),
                      // buildScreen(),
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
}
