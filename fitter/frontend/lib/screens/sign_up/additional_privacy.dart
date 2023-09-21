import 'package:fitter/model/user_profile.dart';
import 'package:fitter/screens/sign_up/additional_box.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/dropdown.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';

class AdditionalPrivacy extends StatefulWidget {
  final String nickname;
  final String email;
  final String profileImagePath;

  const AdditionalPrivacy(
      {super.key,
      required this.nickname,
      required this.profileImagePath,
      required this.email});

  @override
  State<AdditionalPrivacy> createState() => _AdditionalPrivacyState();
}

class _AdditionalPrivacyState extends State<AdditionalPrivacy> {
  late String gender;
  late String age;
  bool isGender = false;
  bool isAge = false;
  bool isAll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            const EmptyBox(boxSize: 1),
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fitter가 되신 것을 환영합니다.",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "정보를 입력해주세요.",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
                width: 500,
                child: Divider(color: Color(0xFF0080FF), thickness: 3)),
            const EmptyBox(boxSize: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Dropdown(
                  dropList: const ["여성", "남성"],
                  hintText: "성별",
                  width: 150,
                  onSelected: (value) {
                    setState(() {
                      gender = value;
                      isGender = true;
                    });
                  },
                ),
                Dropdown(
                  dropList: const ["10대", "20대", "30대", "40대", "50대", "60대 이상"],
                  hintText: "연령대",
                  width: 150,
                  onSelected: (value) {
                    setState(() {
                      age = value;
                      isAge = true;
                    });
                  },
                ),
              ],
            ),
            const EmptyBox(boxSize: 4),
            Offstage(
              offstage: isAll,
              child: const Text(
                "성별과 연령대를 입력해야 합니다.",
                style: TextStyle(color: Color(0xff0080ff), fontSize: 12),
              ),
            ),
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {
                (isAge && isGender)
                    ? Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, anmation, secondaryAnimation) =>
                                  AdditionalBox(
                                      nickname: widget.nickname,
                                      email: widget.email,
                                      profileImagePath: widget.profileImagePath,
                                      age: age,
                                      gender: gender),
                        ))
                    : setState(() {
                        isAll = false;
                      });
              },
              child: const ButtonMold(
                  btnText: "다 음 으 로",
                  horizontalLength: 25,
                  verticalLength: 10,
                  buttonColor: true),
            ),
            const EmptyBox(boxSize: 2),
          ],
        ),
      ),
    );
  }
}
