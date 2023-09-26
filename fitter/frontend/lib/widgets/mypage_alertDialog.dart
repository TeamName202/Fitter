import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';

class MyPageAlertDialog extends StatelessWidget {
  const MyPageAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 340,
        width: 340,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonMold(
                    btnText: "사 진 삭 제",
                    horizontalLength: 20,
                    verticalLength: 15,
                    buttonColor: false),
                ButtonMold(
                    btnText: "사 진 수 정",
                    horizontalLength: 20,
                    verticalLength: 15,
                    buttonColor: true)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: InputText(hintText: "이 름"),
            ),
            const Expanded(
              child: InputText(hintText: "박 스"),
            ),
          ],
        ),
      ),
    );
  }
}
