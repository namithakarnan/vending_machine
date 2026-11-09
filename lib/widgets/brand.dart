import 'package:flutter/cupertino.dart';
import 'package:vending_machine/utils/colors.dart';

Widget brand({Key? key}) {
  return Column(
    key: key,
    children: [
      Image.asset(
        'assets/images/icon.png',
        fit: BoxFit.fill,
        width: 30,
        height: 50,
      ),
      const SizedBox(height: 9),
      const Text(
        'SMART VENDING',
        style: TextStyle(
          color: goldLight,
          fontSize: 11,
          letterSpacing: 3.2,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
