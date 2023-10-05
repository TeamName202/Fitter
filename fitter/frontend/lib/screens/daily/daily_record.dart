import 'package:fitter/screens/nav_bar.dart';
import 'package:fitter/services/api_service.dart';
import 'package:flutter/material.dart';

class DailyExerciseRecord extends StatefulWidget {
  final DateTime selectedDay;
  const DailyExerciseRecord({super.key, required this.selectedDay});

  @override
  State<DailyExerciseRecord> createState() => _DailyExerciseRecordState();
}

class _DailyExerciseRecordState extends State<DailyExerciseRecord> {
  int? selectedIndex;
  final TextEditingController detailController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final sendPostRequest = ApiService().sendPostRequest;

  String getTypeText(int? selectedType) {
    switch (selectedType) {
      case 1:
        return 'For Time';
      case 2:
        return 'EMOM';
      case 3:
        return 'AMRAP';
      case 4:
        return 'Custom';
      default:
        return 'Custom'; // 선택된 타입이 없는 경우 빈 문자열 반환 또는 다른 기본값 설정
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "데일리",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(Icons.arrow_back_sharp)),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Type',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  // 현재 selectedIndex는 -1 인데 해당 버튼이 선택되면 0~4로 바뀌게 되고 그에 맞춰 T/F 보내게 되고 bool 값을 통해 색깔을 바꾼다.
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = 1;
                        }),
                        child: TypeButtonBox(
                          typeText: 'For Time',
                          isSelected: selectedIndex == 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = 2;
                        }),
                        child: TypeButtonBox(
                          typeText: 'EMOM',
                          isSelected: selectedIndex == 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = 3;
                        }),
                        child: TypeButtonBox(
                          typeText: 'AMRAP',
                          isSelected: selectedIndex == 3,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          selectedIndex = 4;
                        }),
                        child: TypeButtonBox(
                          typeText: 'Custom',
                          isSelected: selectedIndex == 4,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Detail',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(
                    hintText: '어떤 운동을 하셨나요?', // placeholder
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Memo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextContainer(
                  memoController: memoController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      sendPostRequest(
                        selectedDay: widget.selectedDay
                            .toIso8601String()
                            .substring(0, 10),
                        detail: detailController.text,
                        memo: memoController.text,
                        type: {
                          'id': selectedIndex, // 클릭된 요소의 정보를 사용
                          'type': getTypeText(selectedIndex), // 클릭된 요소의 정보를 사용
                        },
                      );
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBarWidget()),
                          (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text('submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TypeButtonBox extends StatelessWidget {
  final String typeText;
  final bool isSelected;

  const TypeButtonBox({
    Key? key,
    required this.typeText,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xff136AF3) : Colors.white,
            border: Border.all(color: Colors.blue.shade400),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          typeText,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TextContainer extends StatefulWidget {
  final TextEditingController memoController;
  const TextContainer({
    super.key,
    required this.memoController,
  });

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  bool isSelected = false;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 리스너는 예기치 못한 변수 방지를 위해 initState 안에 적는 것이 좋다.
    //
    focusNode.addListener(() {
      if (focusNode.hasFocus != isSelected) {
        setState(() {
          isSelected = !isSelected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          FocusScope.of(context).requestFocus(focusNode);
        }
      },
      // 아래 textField는 자체적으로 gestureDetector가 있어서 container에 걸어놓은 onTap이 적용되지 않음
      // 이를 해결하기 위해 focusNode를 사용함
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected
                  ? Colors.blue
                  : Colors.grey), // 선택 여부에 따라 테두리 색상 변경
          borderRadius: BorderRadius.circular(8), // 테두리의 둥근 모서리 설정 (선택사항)
        ),
        width: double.infinity, // 가로 너비를 최대로 설정
        height: 200,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ), // 내부 여백 설정
        child: TextField(
          controller: widget.memoController,
          focusNode: focusNode,
          decoration: const InputDecoration(
            hintText: '오늘 한 와드에 대해 일기를 기록 해보세요.',
            border: InputBorder.none,
          ),
          maxLines: null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 리소스 정리
    focusNode.dispose();
    super.dispose();
  }
}
