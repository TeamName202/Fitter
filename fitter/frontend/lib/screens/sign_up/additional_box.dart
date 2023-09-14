import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';

class AdditionalBox extends StatelessWidget {
  const AdditionalBox({super.key});

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
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
            const EmptyBox(boxSize: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              child: Image.asset('assets/images/box_image.png'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InputText(hintText: "BOX"),
            ),
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {},
              child: const ButtonMold(
                btnText: "건 너 뛰 기",
                horizontalLength: 25,
                verticalLength: 10,
                buttonColor: false,
              ),
            ),
            const EmptyBox(boxSize: 3),
          ],
        ),
      ),
    );
  }
}
