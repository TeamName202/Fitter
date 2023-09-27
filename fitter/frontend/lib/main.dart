import 'package:fitter/screens/daily/daily_calendar.dart';
import 'package:fitter/screens/chart_screen.dart';
import 'package:fitter/screens/login_screen.dart';
import 'package:fitter/screens/pr_input_screen.dart';
import 'package:fitter/screens/daily_keyword_screen.dart';
import 'package:fitter/screens/wod/wod_detail_screen.dart';
import 'package:fitter/screens/wod/wod_input_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  KakaoSdk.init(
    nativeAppKey: "db6c538af12e033ffc7eb3bbb87fc646",
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: WodDetailScreen(wodName: "Murph", type: "For Time", wodId: "1"),
      // home: WodInputScreen(wodName: "Murph", type: "For Time", wodId: "1"),

      home: LoginScreen(),
      // home: ChartScreen(workoutName: "Clean"),
      // home: RecordScreen(),
      // home: DailyKeyword(),
    );
  }
}
