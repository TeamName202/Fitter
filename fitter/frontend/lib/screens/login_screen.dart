import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const EmptyBox(boxSize: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset('assets/images/fitter_logo.png'),
          ),
          const EmptyBox(boxSize: 1),
          GestureDetector(
            // 카카오 로그인
            onTap: () {},
            child: Image.asset('assets/images/kakao_login_medium_wide.png'),
          ),
          const EmptyBox(boxSize: 8),
        ],
      ),
    );
  }
}
