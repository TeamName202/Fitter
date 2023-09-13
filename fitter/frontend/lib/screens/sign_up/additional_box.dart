import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';

class AdditionalBox extends StatelessWidget {
  const AdditionalBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EmptyBox(boxSize: 3),
          const InputText(hintText: "BOX"),
          const EmptyBox(boxSize: 1),
          GestureDetector(
            onTap: () {},
            child: const ButtonMold(
              btnText: "건 너 뛰 기",
              horizontalLength: 30,
              verticalLength: 10,
              buttonColor: false,
            ),
          ),
          const EmptyBox(boxSize: 3),
        ],
      ),
    );
  }
}
