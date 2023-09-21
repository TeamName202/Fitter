import 'dart:io';

import 'package:fitter/screens/nav_bar.dart';
import 'package:fitter/screens/sign_up/additional_info.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Future<void> fetchHeader() async {
  //   final response = await http.get(
  //     Uri.parse("http://j9d202.p.ssafy.io:8000/api/oauth2/authorization/kakao"),
  //   );

  //   if (response.statusCode == 200) {
  //     final headers = response.headers;
  //     final autorization = headers['Authorization'];

  //     print('autorization: $autorization');
  //     print(headers);
  //   } else {
  //     // HTTP 요청이 실패한 경우
  //     print('Failed to load data');
  //   }
  // }

  Future onIsSign(OAuthToken token) async {
    // 헤더에 추가할 데이터
    Map<String, String> headers = {
      'Authorization': token.accessToken,
    };

// HTTP 요청 보내기
    var url = Uri.parse('https://example.com/api/endpoint');
    var response = await http.get(url, headers: headers);

// 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 응답을 받았을 때의 처리
      print('Response data: ${response.body}');
    } else {
      // 오류 처리
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  Future onLoginTap() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        onIsSign(token);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오톡으로 로그인 성공');
          onIsSign(token);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오톡으로 로그인 성공');
        onIsSign(token);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  onLogin() async {
    await onLoginTap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // GestureDetector(
          //     onTap: () {
          //       onLogin();
          //     },
          //     child: const ButtonMold(
          //         btnText: "임시",
          //         horizontalLength: 80,
          //         verticalLength: 120,
          //         buttonColor: true)),
          const EmptyBox(boxSize: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.asset('assets/images/fitter_logo.png'),
          ),
          const EmptyBox(boxSize: 1),
          GestureDetector(
            // 카카오 로그인
            onTap: onLogin,
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const AdditionalInfo()));
            // },
            child: Image.asset('assets/images/kakao_login_medium_wide.png'),
          ),
          const EmptyBox(boxSize: 8),
        ],
      ),
    );
  }
}
