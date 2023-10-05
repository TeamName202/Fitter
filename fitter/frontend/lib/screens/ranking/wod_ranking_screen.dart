// import 'package:fitter/widgets/record_widget.dart';
import 'package:fitter/models/my_wod_ranking_model.dart';
import 'package:fitter/models/pr_category_model.dart';
import 'package:fitter/models/pr_list_model.dart';
import 'package:fitter/models/wod_ranking_model.dart';
import 'package:fitter/screens/chart_screen.dart';
import 'package:fitter/services/record_api_service.dart';
import 'package:flutter/material.dart';

class WodRakingScreen extends StatefulWidget {
  const WodRakingScreen({super.key});

  @override
  State<WodRakingScreen> createState() => _PrRecordScreenState();
}

class _PrRecordScreenState extends State<WodRakingScreen> {
  final ScrollController _scrollController = ScrollController();

  // 운동 대분류
  late Future<List<String>> wodCategory;

  // 전체 랭킹 리스트
  late Future<List<WodRankingModel>> wodRakingLists;
  // 내 랭킹 리스트
  late Future<MyWodRankingModel> myWodRakingList;

  // 이건 하드코딩으로 해야할듯. 우선은 Murph밖에 없어서 Murph 하나만. 랭킹 기록 불러올때 처음에는 드롭다운 버튼 제일 첫번째꺼 기록 가져오기 위해서 이용함.
  List<String> wodList = <String>['Murph'];

  // DropdownButton에서 선택된 요소를 저장하는 변수
  String selectedWOD = '';

  String dropdownValue = '';

  // 선택된 요소에 따라 보여줄 리스트

  List<Map<String, dynamic>> currentList = [];

  @override
  void initState() {
    super.initState();
    wodCategory = RecordApiService.getWodCategoryLists();

    // 초기화 할 때는 대분류 첫번째의 운동 가져오기. (future 타입이라서 first 안먹혀서 리스트 하드코딩).
    myWodRakingList = RecordApiService.getMyWodRanking(wodList.first);
    // print(myWodRakingList);
    wodRakingLists = RecordApiService.getWodRanking(wodList.first);
  }

  // DropdownButton에서 선택된 항목이 변경되었을 때 호출되는 함수
  void onDropdownChanged(String newValue) {
    setState(() {
      selectedWOD = newValue;

      myWodRakingList = RecordApiService.getMyWodRanking(selectedWOD);
      wodRakingLists = RecordApiService.getWodRanking(selectedWOD);

      // 스크롤 제일 위로 올리기
      _scrollController.jumpTo(0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Wod 랭킹",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),

          // Dropdown Button
          FutureBuilder(
              future: wodCategory,
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
            height: 15,
          ),

          // 요소 설명 칸
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.black38, width: 1.0))),
                      child: const Text(
                        '순위',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.black38, width: 1.0))),
                      child: const Text(
                        '닉네임',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Colors.black38, width: 1.0))),
                      child: const Text(
                        'BOX',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: const Text(
                        '기록',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // 내 기록
          FutureBuilder(
              future: myWodRakingList,
              builder: (context, snapshot) {
                print(snapshot);
                if (snapshot.hasData) {
                  return Container(
                      height: 60,
                      color: const Color.fromARGB(255, 84, 145, 206),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 30),
                            // 내 랭킹
                            SizedBox(
                              width: 50,
                              child: Text(
                                snapshot.data!.ranking,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 8, 37, 115),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            //  닉네임 들어갈 위치
                            const SizedBox(
                              width: 30,
                            ),
                            const SizedBox(
                              width: 50,
                              child: Text(
                                '나',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 8, 37, 115),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  snapshot.data!.box,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // const SizedBox(width: 50),
                            Expanded(
                              child: SizedBox(
                                width: 100,
                                child: Text(
                                  snapshot.data!.count,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // const Expanded(
                            const SizedBox(width: 10),
                          ],
                        ),
                      ));
                }
                return const Text("...");
              }),
          const SizedBox(
            height: 15,
          ),
          // 다른 사람들 랭킹
          FutureBuilder(
              future: wodRakingLists,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                      child: makeWodList(snapshot, _scrollController));
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

ListView makeWodList(AsyncSnapshot<List<WodRankingModel>> snapshot,
    ScrollController scrollController) {
  return ListView.separated(
    scrollDirection: Axis.vertical,
    controller: scrollController, // ScrollController를 ListView에 연결.
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: snapshot.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var WodRaking = snapshot.data![index];
      print(WodRaking);
      return Container(
          height: 60,
          color: const Color(0XFFEEF1F4),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                // 랭킹
                SizedBox(
                  width: 50,
                  child: Text(
                    WodRaking.rank.toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 8, 37, 115),
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                ),
                // [Todo] 이미지 넣기

                //  닉네임
                SizedBox(
                  width: 50,
                  child: Text(
                    WodRaking.nickname,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                // 박스명
                Expanded(
                  child: SizedBox(
                    width: 50,
                    child: Text(
                      WodRaking.box,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                ),

                // 기록
                Expanded(
                  child: SizedBox(
                    width: 50,
                    child: Text(
                      WodRaking.count,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                ),
                // const Expanded(
                const SizedBox(width: 10),
              ],
            ),
          ));
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}
