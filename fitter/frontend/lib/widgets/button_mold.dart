import 'package:flutter/material.dart';

class ButtonMold extends StatelessWidget {
  final String btnText;
  final double horizontalLength;
  final double verticalLength;
  final bool buttonColor;

  const ButtonMold({
    super.key,
    required this.btnText,
    required this.horizontalLength,
    required this.verticalLength,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalLength, vertical: verticalLength),
      decoration: BoxDecoration(
        color: buttonColor ? const Color(0xFF0080FF) : Colors.white,
        border: Border.all(
            color: buttonColor ? Colors.white : const Color(0xFF0080FF),
            width: 3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        btnText,
        style: TextStyle(
            color: buttonColor ? Colors.white : const Color(0xFF0080FF),
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
