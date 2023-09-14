import 'package:fitter/screens/login_screen.dart';
import 'package:fitter/screens/nav_bar.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExampleApp(),
    );
  }
}
