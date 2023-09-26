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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                "http://www.econotelling.com/news/photo/202004/2875_3504_1147.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "김 싸 피",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "구미 크로스핏 체육관",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Colors.black.withOpacity(0.4),
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
                              barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
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
