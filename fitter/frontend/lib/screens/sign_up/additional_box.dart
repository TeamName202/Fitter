import 'dart:convert';

import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdditionalBox extends StatefulWidget {
  final String nickname;
  final String email;
  final String profileImagePath;
  final String age;
  final String gender;
  const AdditionalBox(
      {super.key,
      required this.nickname,
      required this.email,
      required this.profileImagePath,
      required this.age,
      required this.gender});

  @override
  State<AdditionalBox> createState() => _AdditionalBoxState();
}

class _AdditionalBoxState extends State<AdditionalBox> {
  @override
  void initState() {
    super.initState();
    onAll();
  }

  List<String> searchResults = [];
  FocusNode focusNode = FocusNode();
  final editingController = TextEditingController();
  final scrollController = ScrollController();
  bool isScrolling = false;
  bool isRightBox = false;
  late List<dynamic> boxList;
  List<String> boxLists = [];

  Future onCallServer() async {
// HTTP 요청 보내기
    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/box/list');
    var response = await http.get(url);

// 응답 처리
    if (response.statusCode == 200) {
      // 성공적으로 응답을 받았을 때의 처리
      print('Response data: ${response.body}');
      boxList = jsonDecode(response.body);
    } else {
      // 오류 처리
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  Future onMakeList() async {
    for (var box in boxList) {
      boxLists.add(box['boxName'].toString());
    }
  }

  Future onAll() async {
    await onCallServer();
    await onMakeList();
  }

  void getSearchResults(String query) {
    // onMakeList();
    print(boxLists);
    setState(() {
      searchResults = boxLists
          .where((result) => result.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void outSearchResults() {
    setState(() {
      searchResults = [];
    });
  }

  void getKeyboard() {
    setState(() {});
  }

  void checkRightBox(String query) {
    setState(() {
      if (boxLists.contains(query)) {
        isRightBox = true;
      } else {
        isRightBox = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: focusNode.hasFocus ? 0 : kToolbarHeight,
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const EmptyBox(boxSize: 1),
            Offstage(
              offstage: focusNode.hasFocus,
              child: const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fitter가 되신 것을 환영합니다.",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "정보를 입력해주세요.",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 320,
                        child: Divider(color: Color(0xFF0080FF), thickness: 3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const EmptyBox(boxSize: 1),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              child: Image.asset('assets/images/box_image.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: editingController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        labelText: "BOX",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(207, 74, 124, 174),
                        )),
                    onChanged: (query) {
                      // 검색에 따라 결과 업데이트
                      getSearchResults(query);
                      checkRightBox(query);
                    },
                    onTap: () {
                      outSearchResults();
                      getKeyboard();
                    },
                    onSubmitted: (query) => {getKeyboard()},
                    focusNode: focusNode,
                  ),
                  Offstage(
                    offstage: !focusNode.hasFocus,
                    child: SingleChildScrollView(
                      child: Container(
                        height: searchResults.length < 3
                            ? searchResults.length * 60
                            : 170,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff0080ff))),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                editingController.text = searchResults[index];
                                outSearchResults();
                                isRightBox = true;
                              },
                              child: ListTile(
                                title: Text(searchResults[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: isRightBox,
              child: const Text(
                "등록되어 있는 체육관만 입력할 수 있습니다.",
                style: TextStyle(color: Color(0xff0080ff), fontSize: 12),
              ),
            ),
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {},
              child: ButtonMold(
                btnText: isRightBox ? "다 음 으 로" : "건 너 뛰 기",
                horizontalLength: 25,
                verticalLength: 10,
                buttonColor: isRightBox ? true : false,
              ),
            ),
            const EmptyBox(boxSize: 3),
          ],
        ),
      ),
    );
  }
}
