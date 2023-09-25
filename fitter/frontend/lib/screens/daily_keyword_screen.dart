import 'dart:math';

import 'package:flutter/material.dart';
import 'package:card_slider/card_slider.dart';

class DailyKeyword extends StatelessWidget {
  const DailyKeyword({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Rect> buttonRects = [];

    // 오늘의 키워드 위치 계산
    Offset getRandomPosition(double maxWidth, double maxHeight,
        double buttonWidth, double buttonHeight) {
      final random = Random();
      double left, top;
      bool isIntersecting;
      do {
        isIntersecting = false;
        left = random.nextDouble() * (maxWidth - buttonWidth);
        top = random.nextDouble() * (maxHeight - buttonHeight);

        // 현재 버튼과 이전 버튼들 간의 충돌 검사
        for (var rect in buttonRects) {
          if (rect
              .overlaps(Rect.fromLTWH(left, top, buttonWidth, buttonHeight))) {
            isIntersecting = true;
            break;
          }
        }
      } while (isIntersecting);
      buttonRects.add(Rect.fromLTWH(left, top, buttonWidth, buttonHeight));
      return Offset(left, top);
    }

    // 카드 안에 들어갈 것
    List<Color> valuesDataColors = [
      Colors.purple,
      Colors.yellow,
      Colors.green,
    ];

    // 뉴스 카드 캐러샐 만들기
    List<Widget> valuesWidget = [];
    for (int i = 0; i < valuesDataColors.length; i++) {
      valuesWidget.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: valuesDataColors[i],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "뉴스 $i".toString(),
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
          )));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "오늘의 키워드",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double maxWidth = constraints.maxWidth;
                      double maxHeight = constraints.maxHeight;

                      return Stack(
                        children: List.generate(
                          5,
                          (i) {
                            double buttonWidth = 80;
                            double buttonHeight = 40;

                            Offset position = getRandomPosition(
                                maxWidth, maxHeight, buttonWidth, buttonHeight);

                            return Positioned(
                              left: position.dx,
                              top: position.dy,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  // 버튼이라서~
                                },
                                child: Text(
                                  '뉴스키워드 $i',
                                  style:
                                      const TextStyle(color: Color(0xff0080ff)),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                )),
            Flexible(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: CardSlider(
                    cards: valuesWidget,
                    bottomOffset: .0003,
                    cardHeight: 0.75,
                    containerHeight: MediaQuery.of(context).size.height - 100,
                    itemDotOffset: -0.05,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
