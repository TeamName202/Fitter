import 'package:fitter/screens/sign_up/additional_box.dart';
import 'package:fitter/screens/sign_up/additional_info.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/dropdown.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';

class AdditionalPrivacy extends StatelessWidget {
  const AdditionalPrivacy({super.key});

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Dropdown(
                  dropList: ["여성", "남성"],
                  hintText: "성별",
                  width: 150,
                ),
                Dropdown(
                  dropList: ["10대", "20대", "30대", "40대", "50대", "60대 이상"],
                  hintText: "연령대",
                  width: 150,
                ),
              ],
            ),
            const EmptyBox(boxSize: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
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
                      pageBuilder: (context, anmation, secondaryAnimation) =>
                          const AdditionalBox(),
                    ));
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
