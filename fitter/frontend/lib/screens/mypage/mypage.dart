import 'package:fitter/models/user_profile.dart';
import 'package:fitter/screens/login_screen.dart';
import 'package:fitter/services/api_service.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/mypage_alertDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool button1 = false, button2 = false, button3 = false, button4 = false;
  late Future<UserProfile> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = ApiService.getUserProfile();
  }

  resign() async {
    final result = ApiService.resign();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Consumer<UserData>(
            builder: (context, userData, child) {
              userProfile.then((value) => userData.updateUserProfile(value));
              var user = userData.userProfile;
              if (user == null) {
                return const CircularProgressIndicator();
              }
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "설정",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  elevation: 0,
                  foregroundColor: const Color(0xFF0080FF),
                  backgroundColor: Colors.white,
                ),
                body: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: const Color(0xFF0080FF),
                                          width: 5,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: user.image,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      user.nickname,
                                      style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      user.box,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF7457b9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    iconSize: 30,
                                    alignment: Alignment.bottomRight,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible:
                                            true, // 바깥 영역 터치시 닫을지 여부
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const SingleChildScrollView(
                                                child: MyPageAlertDialog()),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.mode_edit_outline_rounded,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTapDown: (details) {
                    //     setState(() {
                    //       button1 = true;
                    //     });
                    //   },
                    //   onTapUp: (details) {
                    //     setState(() {
                    //       button1 = false;
                    //     });
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     child: ButtonMold(
                    //       btnText: "기 록  초 기 화",
                    //       horizontalLength: 140,
                    //       verticalLength: 30,
                    //       buttonColor: button1,
                    //     ),
                    //   ),
                    // ),
                    // GestureDetector(
                    //   onTapDown: (details) {
                    //     setState(() {
                    //       button2 = true;
                    //     });
                    //   },
                    //   onTapUp: (details) {
                    //     setState(() {
                    //       button2 = false;
                    //     });
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(vertical: 10),
                    //     child: ButtonMold(
                    //       btnText: "다 크 모 드",
                    //       horizontalLength: 150,
                    //       verticalLength: 30,
                    //       buttonColor: button2,
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          button3 = true;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          button3 = false;
                        });
                        ApiService.deleteToken();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ButtonMold(
                          btnText: "로 그 아 웃",
                          horizontalLength: 150,
                          verticalLength: 30,
                          buttonColor: button3,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          button4 = true;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          button4 = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              title: const Text(
                                '정말 탈퇴하시겠습니까?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: const Text(
                                          '확인',
                                          style: TextStyle(
                                            color: Color(0xFF0080FF),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          resign();
                                          ApiService.deleteToken();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: const Text(
                                          '취소',
                                          style: TextStyle(
                                            color: Color(0xFF0080FF),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ButtonMold(
                          btnText: "회 원 탈 퇴",
                          horizontalLength: 150,
                          verticalLength: 30,
                          buttonColor: button4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Scaffold();
      },
    );
  }
}
