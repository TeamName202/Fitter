import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrRecordScreen extends StatefulWidget {
  const PrRecordScreen({super.key});

  @override
  State<PrRecordScreen> createState() => _PrRecordScreenState();
}

class _PrRecordScreenState extends State<PrRecordScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> prCategory = <String>[];
  List<dynamic> prLists = [];

  Future onCallServer() async {
    // HTTP 요청 보내기
    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/record/category');
    var response = await http.get(url);

// 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 응답을 받았을 때의 처리
      print('Response data: ${response.body}');
      prLists = jsonDecode(response.body);
    } else {
      // 오류 처리
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  Future onMakeList() async {
    for (var prList in prLists) {
      if (prList["type"] != "None") {
        if (prList["type"] != "N/A") {
          prCategory.add(prList['type'].toString());
        }
      }
    }
    print("최종 운동 목록 : ");
    print(prCategory);
  }

  Future onAll() async {
    await onCallServer();
    await onMakeList();
    print('데이터 받기 완료');
  }

  // DropdownButton에서 선택된 요소를 저장하는 변수
  String selectedPR = 'Abdominal';

  String dropdownValue = '';

  // 개인 pr List 싹 다 받아오는거. 여기에서 카테고리별로 나눠줘야 됨.
  // late Future<List<PrListModel>> prLists;

  // 선택된 요소에 따라 보여줄 리스트
  List<Map<String, dynamic>> Cleans = [
    {"id": 1, "user": 3, "workout": 'Clean', "max_weight": "100"},
    {"id": 2, "user": 3, "workout": 'Clean Extension', "max_weight": "124"},
    {"id": 3, "user": 3, "workout": 'Clean pull', "max_weight": "134"},
    {"id": 4, "user": 3, "workout": 'Hang Pull', "max_weight": "35"},
    {"id": 5, "user": 3, "workout": 'Hang Power Clean', "max_weight": "127"},
    {"id": 6, "user": 3, "workout": 'Hang Squat Clean', "max_weight": "137"},
    {"id": 7, "user": 3, "workout": 'Muscle Clean', "max_weight": "175"},
    {"id": 8, "user": 3, "workout": 'Power Clean', "max_weight": "168"},
    {"id": 9, "user": 3, "workout": 'Squat Clean', "max_weight": "111"},
    {"id": 10, "user": 3, "workout": 'Squat Pause Clean', "max_weight": "123"},
  ];
  List<Map<String, dynamic>> Deadlifts = [
    {"id": 1, "user": 3, "workout": 'Deadlift', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Romanian Deadlift', "max_weight": "195"},
    {
      "id": 3,
      "user": 3,
      "workout": 'Snatch Grip Deadlift',
      "max_weight": "195"
    },
    {
      "id": 4,
      "user": 3,
      "workout": 'Stiff-Legged Deadlift',
      "max_weight": "195"
    },
    {"id": 5, "user": 3, "workout": 'Sumo Deadlift', "max_weight": "195"},
    {
      "id": 6,
      "user": 3,
      "workout": 'Sumo Deadlift High Pull',
      "max_weight": "195"
    }
  ];
  List<Map<String, dynamic>> Jerks = [
    {"id": 1, "user": 3, "workout": 'Jerk Balance', "max_weight": "123"},
    {"id": 2, "user": 3, "workout": 'Jerk Dip', "max_weight": "321"},
    {"id": 3, "user": 3, "workout": 'Push Jerk', "max_weight": "124"},
    {"id": 4, "user": 3, "workout": 'Split Jerk', "max_weight": "214"},
    {"id": 5, "user": 3, "workout": 'Squat Jerk', "max_weight": "123"}
  ];
  List<Map<String, dynamic>> OlympicLifts = [
    {"id": 1, "user": 3, "workout": 'Clean & Jerk', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Power Clean & Jerk', "max_weight": "195"},
  ];
  List<Map<String, dynamic>> Presses = [
    {"id": 1, "user": 3, "workout": 'Bench Press', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Floor Press', "max_weight": "195"},
    {"id": 3, "user": 3, "workout": 'Push Press', "max_weight": "195"},
    {"id": 1, "user": 3, "workout": 'Seated Press', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Shoulder Press', "max_weight": "195"},
    {
      "id": 3,
      "user": 3,
      "workout": 'Snatch Grip Push Press',
      "max_weight": "195"
    },
    {"id": 3, "user": 3, "workout": 'Scotts Push Press', "max_weight": "195"},
  ];
  List<Map<String, dynamic>> Squats = [
    {"id": 1, "user": 3, "workout": 'Back Pause Squat', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Back Squat', "max_weight": "195"},
    {"id": 3, "user": 3, "workout": 'Box Squat', "max_weight": "195"},
    {"id": 4, "user": 3, "workout": 'Front Box Squat', "max_weight": "195"},
    {"id": 5, "user": 3, "workout": 'Front Pause Squat', "max_weight": "195"},
    {"id": 6, "user": 3, "workout": 'Front Squat', "max_weight": "195"},
    {"id": 7, "user": 3, "workout": 'High Bar Back Squat', "max_weight": "195"},
    {"id": 8, "user": 3, "workout": 'Low Bar Back Squat', "max_weight": "195"},
    {"id": 9, "user": 3, "workout": 'Overhead Squat', "max_weight": "195"},
    {"id": 10, "user": 3, "workout": 'Split Squat', "max_weight": "195"},
  ];
  List<Map<String, dynamic>> Snatches = [
    {"id": 1, "user": 3, "workout": 'Hang Power Snatch', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Hang Squat Snatch', "max_weight": "195"},
    {"id": 3, "user": 3, "workout": 'Muscle Snatch', "max_weight": "195"},
    {"id": 4, "user": 3, "workout": 'Power Snatch', "max_weight": "195"},
    {"id": 5, "user": 3, "workout": 'Snatch', "max_weight": "195"},
    {"id": 6, "user": 3, "workout": 'Snatch Balance', "max_weight": "195"},
    {"id": 7, "user": 3, "workout": 'Snatch Extension', "max_weight": "195"},
    {"id": 8, "user": 3, "workout": 'Snatch Pull', "max_weight": "195"},
    {"id": 9, "user": 3, "workout": 'Snatch Pause Snatch', "max_weight": "195"},
    {"id": 10, "user": 3, "workout": 'Squat Snatch', "max_weight": "195"},
  ];
  List<Map<String, dynamic>> Other = [
    {"id": 1, "user": 3, "workout": 'Back Rack Lunges', "max_weight": "195"},
    {"id": 2, "user": 3, "workout": 'Bent Over Row', "max_weight": "195"},
    {"id": 3, "user": 3, "workout": 'Front Rack Lunges', "max_weight": "195"},
    {"id": 4, "user": 3, "workout": 'Good Morning', "max_weight": "195"},
    {"id": 5, "user": 3, "workout": 'Overhead Lunge', "max_weight": "195"},
    {"id": 6, "user": 3, "workout": 'Pendlay Row', "max_weight": "195"},
    {
      "id": 7,
      "user": 3,
      "workout": 'Squat Clean Thruster',
      "max_weight": "195"
    },
    {"id": 8, "user": 3, "workout": 'Step up', "max_weight": "195"},
    {"id": 9, "user": 3, "workout": 'Thruster', "max_weight": "195"},
  ];

  List<Map<String, dynamic>> currentList = [];

  @override
  void initState() {
    super.initState();
    // print("스택 오버플로우 : $categoryList");
    print("위쪽 테스트");
    onAll();
    print("아래쪽 테스트");
    dropdownValue = prCategory.first;
    print("드롭다운 선택 된거 : $dropdownValue");
    // print(dropdownValue);
    // prLists = ApiService.getPrList(dropdownValue);
    print("인잇에서 $prCategory");
    // print(prLists);
    // _fetchPrCategories();

    currentList = Cleans;
  }

  // Future<void> _fetchPrCategories() async {
  //   try{
  //     final prList = await ApiService.getPrList(selectedPR); // 선택된 항목에 따라 데이터 가져오기
  //   setState(() {
  //     currentList = prList;
  //   });
  //   } catch(e) {
  //     print('Error fetching PR list: $e');
  //   }
  // }

  // DropdownButton에서 선택된 항목이 변경되었을 때 호출되는 함수
  void onDropdownChanged(String newValue) {
    setState(() {
      selectedPR = newValue;
      // prLists = ApiService.getPrList(dropdownValue);
      _scrollController.jumpTo(0.0);
      // 선택된 항목에 따라 다른 리스트를 보여줍니다.
      // if (selectedPR == 'Cleans') {
      //   currentList = Cleans;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Deadlifts') {
      //   currentList = Deadlifts;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Jerks') {
      //   currentList = Jerks;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Olympic Lifts') {
      //   currentList = OlympicLifts;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Presses') {
      //   currentList = Presses;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Squats') {
      //   currentList = Squats;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Snatches') {
      //   currentList = Snatches;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // } else if (selectedPR == 'Other') {
      //   currentList = Other;
      //   _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      // }
    });
  }

  // final Future<List<PrRecordModel>> prRecords;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const Text('pr 레코드'),
          const SizedBox(
            height: 30,
          ),
          // Dropdown Button
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.blue), // 선택되지 않았을 때 테두리 선 색상 설정
                  borderRadius:
                      BorderRadius.circular(5), // 선택되지 않았을 때 버튼 모서리 둥글게 설정
                ),
                child: DropdownMenu<String>(
                  width: 190,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20), // dropbdown 되기 전에 보여지는 글자 두께
                  initialSelection: prCategory.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                    onDropdownChanged(dropdownValue);
                  },
                  dropdownMenuEntries:
                      prCategory.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              controller: _scrollController, // ScrollController를 ListView에 연결.
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: currentList.length,
              itemBuilder: (BuildContext context, int index) {
                var prRecord = currentList[index];
                return Container(
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
                                prRecord["workout"],
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          // const SizedBox(width: 50),
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
