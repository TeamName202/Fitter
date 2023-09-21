import 'dart:ffi';
import 'package:flutter/material.dart';

class WodRecordScreen extends StatefulWidget {
  const WodRecordScreen({super.key});

  @override
  State<WodRecordScreen> createState() => _WodRecordScreenState();
}

class _WodRecordScreenState extends State<WodRecordScreen> {
  List<Map<String, dynamic>> heroWodRecords = [
    {"id": 1, "user": 3, "workout": 'murph', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'hero1', "max_weight": "123"},
    {"id": 3, "user": 3, "workout": 'hero2', "max_weight": "178"},
    {"id": 4, "user": 3, "workout": 'hero4', "max_weight": "333"},
    {"id": 5, "user": 3, "workout": 'hero5', "max_weight": "242"},
    {"id": 6, "user": 3, "workout": 'hero6', "max_weight": "98"},
    {"id": 7, "user": 3, "workout": 'hero7', "max_weight": "78"},
    {"id": 8, "user": 3, "workout": 'hero8', "max_weight": "32"},
    {"id": 9, "user": 3, "workout": 'hero9', "max_weight": "111"},
  ];

  List<Map<String, dynamic>> girlWodRecords = [
    {"id": 1, "user": 2, "workout": 'Amanda', "max_weight": "195"},
    {"id": 2, "user": 1, "workout": 'Barbara', "max_weight": "45"},
    {"id": 3, "user": 2, "workout": 'Chelsea', "max_weight": "141"},
    {"id": 4, "user": 2, "workout": 'Cindy', "max_weight": "321"},
    {"id": 5, "user": 2, "workout": 'Elizabeth', "max_weight": "42"},
    {"id": 6, "user": 2, "workout": 'Eva', "max_weight": "123"},
    {"id": 7, "user": 2, "workout": 'Fran', "max_weight": "41"},
    {"id": 8, "user": 2, "workout": 'Helen', "max_weight": "87"},
    {"id": 9, "user": 2, "workout": 'Isabel', "max_weight": "120"},
    {"id": 10, "user": 2, "workout": 'Kelly', "max_weight": "134"},
  ];

  List<Map<String, dynamic>> currentData = [];

  bool girlClicked = true;

  bool heroClicked = false;

  @override
  void initState() {
    // girl's wod 기본으로 보여줄거임.
    super.initState();
    setState(() {
      girlClicked = true;

      heroClicked = false;
      currentData = girlWodRecords;
    });
  }

  void selectGirlWod() {
    girlClicked = true;
    heroClicked = false;
    setState(() {
      currentData = girlWodRecords;
      // 버튼 스타일 변경
    });
  }

  void selectHeroWod() {
    girlClicked = false;
    heroClicked = true;
    setState(() {
      currentData = heroWodRecords;
      // 버튼 스타일 변경
    });
  }

  // final Future<List<PrRecordModel>> prRecords;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // const Text('wod 레코드'),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: [
              const SizedBox(
                width: 10,
              ),
              // 첫 번째 버튼
              ElevatedButton(
                onPressed: selectGirlWod,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      girlClicked ? Colors.blue : Colors.white),
                  foregroundColor: MaterialStateProperty.all(
                      girlClicked ? Colors.white : Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.blue), // 버튼 테두리 색 주기
                    ),
                  ),
                ),
                child: const Text("Girl's name"),
              ),
              const SizedBox(
                width: 10,
              ),
              // 두 번째 버튼
              ElevatedButton(
                onPressed: selectHeroWod,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      heroClicked ? Colors.blue : Colors.white),
                  foregroundColor: MaterialStateProperty.all(
                      heroClicked ? Colors.white : Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(color: Colors.blue), // 버튼 테두리 색 주기
                    ),
                  ),
                ),
                child: const Text("Hero"),
              ),
            ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: currentData.length,
              itemBuilder: (BuildContext context, int index) {
                var prRecord = currentData[index];
                return Container(
                    height: 50,
                    color: const Color(0XFFEEF1F4),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              prRecord["workout"],
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                              child: Text(
                            prRecord["max_weight"] + 'lb',
                            textAlign: TextAlign.center,
                          )),
                          // const Expanded(
                          const Icon(Icons.chevron_right_rounded,
                              color: Colors.black),
                          // ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
