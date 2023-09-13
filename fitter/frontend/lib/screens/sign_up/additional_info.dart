import 'package:fitter/screens/sign_up/additional_box.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            // 넣어야 하는 것 : 사진 입력, 닉네임 입력
            const EmptyBox(boxSize: 3),
            Center(
              child: Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(80),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(180),
                    child: Image.asset(
                      "assets/images/default_user_img.jpg",
                    ),
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: InputText(hintText: "닉네임"),
                ),
                Flexible(
                  flex: 1,
                  child: ButtonMold(
                    btnText: " 중복 확인 ",
                    verticalLength: 10,
                    horizontalLength: 5,
                    buttonColor: true,
                  ),
                ),
              ],
            ),
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdditionalBox(),
                      fullscreenDialog: true,
                    ));
              },
              child: const ButtonMold(
                btnText: "다 음 으 로",
                horizontalLength: 25,
                verticalLength: 10,
                buttonColor: true,
              ),
            ),
            const EmptyBox(boxSize: 4),
          ],
        ),
      ),
    );
  }
}
