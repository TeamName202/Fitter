// import 'dart:ffi';
import 'package:fitter/models/wod_list_model.dart';
import 'package:fitter/screens/chart_screen.dart';
import 'package:fitter/screens/wod/wod_detail_screen.dart';
import 'package:fitter/services/record_api_service.dart';
import 'package:flutter/material.dart';

class WodRecordScreen extends StatefulWidget {
  const WodRecordScreen({super.key});

  @override
  State<WodRecordScreen> createState() => _WodRecordScreenState();
}

class _WodRecordScreenState extends State<WodRecordScreen> {
  final ScrollController _scrollController = ScrollController();

  late Future<List<WodListModel>> heros;
  late Future<List<WodListModel>> girls;

  late Future<List<WodListModel>> currentData;

  bool girlClicked = true;

  bool heroClicked = false;

  String selected = 'Girls';

  @override
  void initState() {
    // girl's wod 기본으로 보여줄거임.
    super.initState();
    setState(() {
      girlClicked = true;

      heroClicked = false;
      selected = 'Girls';
    });
    currentData = RecordApiService.getNamedWods(selected);
  }

  void selectGirlWod() {
    girlClicked = true;
    heroClicked = false;
    selected = 'Girls';
    setState(() {
      currentData = RecordApiService.getNamedWods(selected);
      // 스크롤 제일 위로 올리기
      _scrollController.jumpTo(0.0);

      // 버튼 스타일 변경
    });
  }

  void selectHeroWod() {
    girlClicked = false;
    heroClicked = true;
    selected = 'Hero';
    setState(() {
      currentData = RecordApiService.getNamedWods(selected);
      // 스크롤 제일 위로 올리기
      _scrollController.jumpTo(0.0);

      // 버튼 스타일 변경
    });
  }

  // final Future<List<PrRecordModel>> prRecords;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          FutureBuilder(
              future: currentData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 가져오는 중인 경우
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // 에러가 발생한 경우
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  // 데이터가 없는 경우
                  return const Text('No Data');
                } else {
                  return Expanded(
                    child: makeList(snapshot, _scrollController),
                  );
                }
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<WodListModel>> snapshot,
    ScrollController scrollController) {
  return ListView.separated(
    scrollDirection: Axis.vertical,
    controller: scrollController, // ScrollController를 ListView에 연결.
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: snapshot.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var prRecord = snapshot.data![index];
      return GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              // DetailScreen은 wod 상세 페이지로 수정하셈.
              builder: (context) => WodDetailScreen(
                  wodId: prRecord.id.toString(), wodName: prRecord.name),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
            height: 50,
            color: const Color(0XFFEEF1F4),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      prRecord.name,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 50),
                  // const Expanded(
                  const Icon(Icons.chevron_right_rounded, color: Colors.black),
                  // ),
                  const SizedBox(width: 10),
                ],
              ),
            )),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}
