import 'package:fitter/screens/bunsan_screen.dart';
import 'package:fitter/screens/login_screen.dart';
import 'package:fitter/screens/ranking/wod_ranking_screen.dart';
import 'package:fitter/screens/record/record_screen.dart';
import 'package:fitter/models/user_profile.dart';
import 'package:fitter/screens/daily/daily_calendar.dart';
import 'package:fitter/screens/login_screen.dart';
import 'package:fitter/screens/ranking/wod_ranking_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  KakaoSdk.init(
    nativeAppKey: "db6c538af12e033ffc7eb3bbb87fc646",
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserData(), // 초기 UserProfile 객체를 생성합니다.
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return const MaterialApp(
        // home: LoginScreen());
        // home: RecordScreen());
        home: WodRakingScreen());
    // home: BunsanScreen());

    // return const MaterialApp(home: LoginScreen());
    // home: RecordScreen());
    // home: WodRakingScreen());
    // home: CrossfitRankingScreen());
  }
}
