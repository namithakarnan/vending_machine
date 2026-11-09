import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100B08),
      body:
          // Positioned.fill(
          //   child:
          // Opacity(
          //     opacity: 0.7, // 60% opacity
          //     child: Image.asset(
          //       'assets/images/land.png',
          //       fit: BoxFit.fill,
          //       width: double.infinity,
          //       height: double.infinity,
          //     ),
          //   ),
          // ),
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'What Can I Get You Today?',
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFD6AD67),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Image.asset(
                  //   'assets/images/land.png',
                  //   fit: BoxFit.fill,
                  //   width: 100,
                  //   height: 200,
                  // ),
                  Text('j'),
                  Text(
                    'Voice Only System',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFD6AD67),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
