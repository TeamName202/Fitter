import 'package:fitter/screens/sign_up/additional_info.dart';
import 'package:fitter/screens/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdditionalInfo(),
    );
  }
}
