import 'package:fitter/widgets/record_widget.dart';
import 'package:flutter/material.dart';

class PrRecordScreen extends StatefulWidget {
  const PrRecordScreen({super.key});

  @override
  State<PrRecordScreen> createState() => _PrRecordScreenState();
}

class _PrRecordScreenState extends State<PrRecordScreen> {
  final ScrollController _scrollController = ScrollController();

  List<String> prList = <String>[
    'Cleans',
    'Deadlifts',
    'Jerks',
    'Olympic Lifts',
    'Presses',
    'Squats',
    'Snatches',
    'Other'
  ];
  // DropdownButton에서 선택된 요소를 저장하는 변수
  String selectedPR = 'Cleans';

  String dropdownValue = '';

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
    dropdownValue = prList.first;
    currentList = Cleans;
  }

  // DropdownButton에서 선택된 항목이 변경되었을 때 호출되는 함수
  void onDropdownChanged(String newValue) {
    setState(() {
      selectedPR = newValue;

      // 선택된 항목에 따라 다른 리스트를 보여줍니다.
      if (selectedPR == 'Cleans') {
        currentList = Cleans;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Deadlifts') {
        currentList = Deadlifts;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Jerks') {
        currentList = Jerks;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Olympic Lifts') {
        currentList = OlympicLifts;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Presses') {
        currentList = Presses;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Squats') {
        currentList = Squats;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Snatches') {
        currentList = Snatches;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      } else if (selectedPR == 'Other') {
        currentList = Other;
        _scrollController.jumpTo(0.0); // 스크롤 제일 위로 올리는거
      }
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
                  initialSelection: prList.first,
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                    onDropdownChanged(dropdownValue);
                  },
                  dropdownMenuEntries:
                      prList.map<DropdownMenuEntry<String>>((String value) {
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
