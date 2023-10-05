import 'dart:convert';
import 'dart:io';

import 'package:fitter/models/user_profile.dart';
import 'package:fitter/services/api_service.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MyPageAlertDialog extends StatefulWidget {
  const MyPageAlertDialog({super.key});

  @override
  State<MyPageAlertDialog> createState() => _MyPageAlertDialogState();
}

class _MyPageAlertDialogState extends State<MyPageAlertDialog> {
  late List<dynamic> boxList;

  List<Map<String, dynamic>> searchResults = [];
  FocusNode focusNode = FocusNode();
  final editingController = TextEditingController();

  final scrollController = ScrollController();
  String nickname = "";
  bool isScrolling = false;
  bool isRightBox = false;
  List<Map<String, dynamic>> boxLists = [];
  String? boxId;
  bool signUpPassed = false;
  String boxName = "";
  bool check = false;

  @override
  void initState() {
    super.initState();
    onAll();
    print(boxId);
  }

  Future<Image> xFileToImage(XFile xFile) async {
    // XFile에서 파일 경로를 가져옵니다.
    String filePath = xFile.path;

    // File을 읽어와서 Image로 변환합니다.
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final image = Image.memory(
      bytes,
      fit: BoxFit.cover,
    );

    return image;
  }

  Future onCallServer() async {
    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/box/list');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      boxList = jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Error message: ${response.body}');
    }
  }

  Future<void> onMakeList() async {
    for (var box in boxList) {
      Map<String, dynamic> boxInfo = {
        'boxName': box['boxName'].toString(),
        'boxAddress': box['boxAddress'].toString(),
        'id': box['id'].toString(),
      };
      boxLists.add(boxInfo);
    }
  }

// 동기처리 될 수 있도록 처리
  Future onAll() async {
    await onCallServer();
    await onMakeList();
  }

// 검색 결과를 띄우는 함수
  void getSearchResults(String query) {
    setState(() {
      searchResults = boxLists
          .where((result) =>
              result['boxName'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

// 검색 결과 리스트 초기화
  void outSearchResults() {
    setState(() {
      searchResults = [];
    });
  }

// 바뀐 state 업데이트 위한 빈 set state
  void getKeyboard() {
    setState(() {});
  }

// 유효하게 등록된 box인지 확인
  void checkRightBox(String query) {
    setState(() {
      if (boxLists.contains(query)) {
        isRightBox = true;
      } else {
        isRightBox = false;
        boxId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserData>(context);
    var user = provider.userProfile;
    nickname = user!.nickname;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 550,
        width: 340,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color(0xFF0080FF),
                        width: 5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: user.image,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await ApiService.deleteProfile();

                    setState(() {
                      ApiService.getUserProfile()
                          .then((value) => provider.updateUserProfile(value));
                    });
                  },
                  child: const ButtonMold(
                      btnText: "사 진 삭 제",
                      horizontalLength: 20,
                      verticalLength: 15,
                      buttonColor: false),
                ),
                GestureDetector(
                  onTap: () async {
                    final pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    var temp = await xFileToImage(pickedImage!);
                    ApiService.changeProfileImg(pickedImage);
                    //userProfile 은 Future<UserProfile>
                    setState(() {
                      ApiService.getUserProfile().then((value) {
                        print(value.image!.image);
                        user.image = temp;
                      });
                    });
                  },
                  child: const ButtonMold(
                      btnText: "사 진 수 정",
                      horizontalLength: 20,
                      verticalLength: 15,
                      buttonColor: true),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                user.nickname = value;
                print(user.nickname);
                setState(() {});
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3,
                  ),
                ),
                labelText: "이 름",
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(207, 74, 124, 174),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
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
                    child: Container(
                      height: searchResults.length < 3
                          ? searchResults.length * 60
                          : 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0080ff))),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              editingController.text =
                                  searchResults[index]['boxName'];
                              user.box = searchResults[index]['boxName'];
                              boxId = searchResults[index]['id'];
                              outSearchResults();
                              isRightBox = true;
                            },
                            child: ListTile(
                              title: Text(searchResults[index]['boxName']),
                              subtitle:
                                  Text(searchResults[index]['boxAddress']),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const ButtonMold(
                      btnText: "중복체크",
                      horizontalLength: 30,
                      verticalLength: 10,
                      buttonColor: false,
                    ),
                    onPressed: () {
                      ApiService.checkDuplicate(nickname).then((value) {
                        check = value;
                        print(check);
                        if (check) {
                          Fluttertoast.showToast(msg: "닉네임 사용 가능합니다.");
                        } else {
                          Fluttertoast.showToast(msg: "닉네임 사용 불가능합니다.");
                        }
                      });
                    },
                  ),
                  !check
                      ? TextButton(
                          child: const ButtonMold(
                            btnText: "수정완료",
                            horizontalLength: 30,
                            verticalLength: 10,
                            buttonColor: false,
                          ),
                          onPressed: () =>
                              Fluttertoast.showToast(msg: "중복 확인을 해주세요"),
                        )
                      : TextButton(
                          child: const ButtonMold(
                            btnText: "수정완료",
                            horizontalLength: 30,
                            verticalLength: 10,
                            buttonColor: true,
                          ),
                          onPressed: () {
                            print("onPressed : $nickname");
                            ApiService.updateProfile(nickname, boxId);
                            setState(() {
                              ApiService.getUserProfile().then((value) {
                                provider.updateUserProfile(value);
                              });
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
