import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  final int boxSize;

  const EmptyBox({
    super.key,
    required this.boxSize,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: boxSize,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
    );
  }
}
