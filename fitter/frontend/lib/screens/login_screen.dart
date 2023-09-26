import 'dart:convert';

import 'package:fitter/screens/nav_bar.dart';
import 'package:fitter/screens/sign_up/additional_info.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    onPageOpen();
  }

  late SharedPreferences prefs;
  late OAuthToken kakaoToken;

  // 이 사람이 로그인 되어있는지 확인하는 함수!
  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final authorization = prefs.getString('Authorization');
    // if (authorization != null) {
    //   // 이러면 그냥 바로 이 화면 안 띄우고 메인으로 넘어가면 됨... 되려나?
    //   print("authorization : $authorization");
    //   Future.delayed(Duration.zero, () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => const NavBarWidget()),
    //     );
    //   });
    // }
  }

  // 카카오 토큰 백엔드로 전달
  Future onIsSign(OAuthToken token) async {
    Map<String, String> headers = {
      'Authorization': token.accessToken,
    };

    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/oauth2/kakao');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('Response data: ${response.headers}');
      print('Response data: ${response.body}');
      await onSetInfo(response);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

// 로그인 이후 페이지 넘김 처리
  Future onSetInfo(response) async {
    // var responsebody = jsonDecode(response.body);
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    prefs.setString("Authorization", response.headers['authorization']);
    print("access token : ${response.headers['authorization']}");
    prefs.setString(
        "Authorization-refresh", response.headers['authorization-refresh']);

    if (responseBody["user"] == "USER") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavBarWidget()),
      );
    } else {
      prefs.setInt("userID", responseBody["id"]);
      prefs.setString("userNickname", responseBody["nickname"]);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdditionalInfo(nickname: responseBody["nickname"].toString())),
      );
    }
  }

// 카카오톡으로 로그인
  Future onLoginTap() async {
    if (await isKakaoTalkInstalled()) {
      try {
        kakaoToken = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        // onIsSign(token);
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          kakaoToken = await UserApi.instance.loginWithKakaoAccount();
          print('카카오톡으로 로그인 성공');
          // onIsSign(token);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        kakaoToken = await UserApi.instance.loginWithKakaoAccount();
        print('카카오톡으로 로그인 성공 : ${kakaoToken.accessToken}');
        // onIsSign(token);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

// 화면 켜졌을 때
  Future onPageOpen() async {
    await initPrefs();
  }

// 버튼 눌렸을 떄
  onLogin() async {
    await onLoginTap();
    await onIsSign(kakaoToken);
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
            child: Image.asset('assets/images/kakao_login_medium_wide.png'),
          ),
          const EmptyBox(boxSize: 8),
        ],
      ),
    );
  }
}
