// import 'package:fitter/widgets/record_widget.dart';
import 'package:fitter/models/pr_category_model.dart';
import 'package:fitter/models/pr_list_model.dart';
import 'package:fitter/screens/chart_screen.dart';
import 'package:fitter/services/record_api_service.dart';
import 'package:flutter/material.dart';

class PrRecordScreen extends StatefulWidget {
  const PrRecordScreen({super.key});

  @override
  State<PrRecordScreen> createState() => _PrRecordScreenState();
}

class _PrRecordScreenState extends State<PrRecordScreen> {
  final ScrollController _scrollController = ScrollController();

  // 운동 대분류
  late Future<List<String>> prCategory;

  // 운동 기록 리스트
  late Future<List<PrListModel>> prRecordLists;

  List<String> prList = <String>[
    'Abdominal',
    'Bike',
    'Burpees',
    'Cleans',
    'Climb',
    'Curl',
    'Deadlifts',
    'Dip',
    'Hyperextension',
    'Jerk',
    'Jump Rope',
    'Jumps',
    'Lunges',
    'Muscle-up',
    'Presses',
    'Pull-up',
    'Push',
    'Push-up',
    'Rest',
    'Row',
    'Run',
    'Snatch',
    'Squats',
    'Static',
    'Strongman',
    'Swimming',
    'Swing',
    'Throw',
    'Thruster',
    'Walking',
  ];
  // DropdownButton에서 선택된 요소를 저장하는 변수
  String selectedPR = '';

  String dropdownValue = '';

  // 선택된 요소에 따라 보여줄 리스트

  List<Map<String, dynamic>> currentList = [];

  @override
  void initState() {
    super.initState();
    prCategory = RecordApiService.getPrCategory();

    // 초기화 할 때는 대분류 첫번째의 운동 가져오기. (future 타입이라서 first 안먹혀서 리스트 하드코딩).
    prRecordLists = RecordApiService.getPrRecordList(prList.first);
  }

  // DropdownButton에서 선택된 항목이 변경되었을 때 호출되는 함수
  void onDropdownChanged(String newValue) {
    setState(() {
      selectedPR = newValue;

      prRecordLists = RecordApiService.getPrRecordList(selectedPR);

      // 스크롤 제일 위로 올리기
      _scrollController.jumpTo(0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // const Text('pr 레코드'),
          const SizedBox(
            height: 30,
          ),
          // Dropdown Button

          FutureBuilder(
              future: prCategory,
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
                  final List<String> prCategoryList = snapshot.data!;
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blue), // 선택되지 않았을 때 테두리 선 색상 설정
                          borderRadius: BorderRadius.circular(
                              5), // 선택되지 않았을 때 버튼 모서리 둥글게 설정
                        ),
                        child: DropdownMenu<String>(
                          width: 190,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20), // dropbdown 되기 전에 보여지는 글자 두께
                          initialSelection: prCategoryList.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                            onDropdownChanged(dropdownValue);
                          },
                          dropdownMenuEntries: prCategoryList
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }
              }),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: prRecordLists,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: makePrList(snapshot, _scrollController));
                }
                return Container();
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

ListView makePrList(AsyncSnapshot<List<PrListModel>> snapshot,
    ScrollController scrollController) {
  return ListView.separated(
    scrollDirection: Axis.vertical,
    controller: scrollController, // ScrollController를 ListView에 연결.
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: snapshot.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var prRecord = snapshot.data![index];
      print(prRecord);
      return GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChartScreen(workoutName: prRecord.name),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
            height: 60,
            color: const Color(0XFFEEF1F4),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        prRecord.name,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 50),
                  Expanded(
                      child: Text(
                    '${prRecord.max_weight}lb',
                    textAlign: TextAlign.center,
                  )),
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
