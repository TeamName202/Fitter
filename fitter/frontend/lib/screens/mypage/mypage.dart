import 'package:fitter/models/user_profile.dart';
import 'package:fitter/services/api_service.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/mypage_alertDialog.dart';
import 'package:flutter/material.dart';

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
    setState(() {
      userProfile = ApiService.getUserProfile();
    });
  }

  resign() async {
    final result = ApiService.resign();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "설정",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
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
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: const Color(0xFF0080FF),
                                  width: 5,
                                ),
                              ),
                              child: FutureBuilder(
                                future: userProfile,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        snapshot.data!.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(
                                      Icons.person,
                                      size: 90,
                                    ),
                                  );
                                },
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          FutureBuilder(
                            future: userProfile,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.nickname,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                );
                              }
                              return const Text("...");
                            },
                          ),
                          FutureBuilder(
                            future: userProfile,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!.box,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                );
                              }
                              return const Text("...");
                            },
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
                              barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  content: const MyPageAlertDialog(),
                                  actions: [
                                    Center(
                                      child: TextButton(
                                        child: const ButtonMold(
                                          btnText: "수정완료",
                                          horizontalLength: 30,
                                          verticalLength: 10,
                                          buttonColor: true,
                                        ),
                                        onPressed: () {
                                          // 수정한 내용 저장하는 로직 작성해야 함
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
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
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                button1 = true;
              });
            },
            onTapUp: (details) {
              setState(() {
                button1 = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ButtonMold(
                btnText: "기 록  초 기 화",
                horizontalLength: 140,
                verticalLength: 30,
                buttonColor: button1,
              ),
            ),
          ),
          GestureDetector(
            onTapDown: (details) {
              setState(() {
                button2 = true;
              });
            },
            onTapUp: (details) {
              setState(() {
                button2 = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ButtonMold(
                btnText: "다 크 모 드",
                horizontalLength: 150,
                verticalLength: 30,
                buttonColor: button2,
              ),
            ),
          ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
