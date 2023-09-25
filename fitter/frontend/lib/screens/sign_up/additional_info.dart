import 'dart:convert';

import 'package:fitter/screens/sign_up/additional_privacy.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdditionalInfo extends StatefulWidget {
  final String nickname;
  const AdditionalInfo({super.key, required this.nickname});

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  FocusNode mailFocusNode = FocusNode();
  FocusNode nicknameFocusNode = FocusNode();
  final nicknameTextEditController = TextEditingController();
  final emailTextEditController = TextEditingController();

  late SharedPreferences prefs;

  late String name;
  String checkResponse = "";
  String isUniqueNickname = "";
  File? _image;
  String imagePath = "false";
  String imageName = "default.jpg";

//   Future<void> saveImageToFile(FileImage imageFile) async {
//   final directory = await getApplicationDocumentsDirectory();
//   final imagePath = directory.path + '/my_image.png';
//   await imageFile.copy(imagePath);
// }

  Future<void> _getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        imagePath = pickedImage.path;
        imageName = pickedImage.name;
      }
    });
  }

  Future checkNickname() async {
    prefs = await SharedPreferences.getInstance();
    var url =
        Uri.parse('http://j9d202.p.ssafy.io:8000/api/user/nickname/duplicate');

    final headers = {
      'Authorization': prefs.getString('Authorization').toString(),
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({"닉네임": nicknameTextEditController.text});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      setState(() {
        print('요청 성공: ${response.body}');
        isUniqueNickname = response.body;
      });
    } else {
      // 요청이 실패한 경우
      setState(() {
        print(checkResponse = '요청 실패: ${response.statusCode}');
      });
    }
  }

  void getKeyboard() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    nicknameTextEditController.text = widget.nickname;
  }

  @override
  Widget build(BuildContext context) {
    Widget messageWidget;

    if (isUniqueNickname == "") {
      messageWidget = const Text("닉네임 중복 확인을 해주세요.");
    } else if (isUniqueNickname == "false") {
      messageWidget = const Text("중복된 닉네임입니다.");
    } else {
      messageWidget = Text("반갑습니다 ${nicknameTextEditController.text}님!");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const EmptyBox(boxSize: 5),
            Offstage(
              offstage: mailFocusNode.hasFocus || nicknameFocusNode.hasFocus,
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
                    ],
                  ),
                ],
              ),
            ),
            Offstage(
              offstage: mailFocusNode.hasFocus || nicknameFocusNode.hasFocus,
              child: const SizedBox(
                  child: Divider(color: Color(0xFF0080FF), thickness: 3)),
            ),
            const EmptyBox(boxSize: 1),
            InkWell(
              onTap: _getImageFromGallery,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: _image == null
                      ? Image.asset(
                          "assets/images/default_user_img.jpg",
                          fit: BoxFit.cover,
                        )
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            const EmptyBox(boxSize: 1),
            //focusNode: focusNode,
            TextField(
              controller: emailTextEditController,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                  labelText: "이메일",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(207, 74, 124, 174),
                  )),
              onTap: () {
                getKeyboard();
              },
              onSubmitted: (query) => {getKeyboard()},
              focusNode: mailFocusNode,
            ),
            const EmptyBox(boxSize: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: TextField(
                    controller: nicknameTextEditController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ),
                        labelText: "닉네임",
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(207, 74, 124, 174),
                        )),
                    onTap: () {
                      getKeyboard();
                    },
                    onSubmitted: (query) => {getKeyboard()},
                    focusNode: nicknameFocusNode,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTap: checkNickname,
                    child: const ButtonMold(
                      btnText: " 중복 확인 ",
                      verticalLength: 10,
                      horizontalLength: 5,
                      buttonColor: true,
                    ),
                  ),
                ),
              ],
            ),
            messageWidget,
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {
                if (isUniqueNickname == "true") {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          pageBuilder:
                              (context, anmation, secondaryAnimation) =>
                                  AdditionalPrivacy(
                                      nickname: nicknameTextEditController.text,
                                      email: emailTextEditController.text,
                                      profileImagePath: imagePath,
                                      profileImageName: imageName)));
                }
              },
              child: const ButtonMold(
                btnText: "다 음 으 로",
                horizontalLength: 25,
                verticalLength: 10,
                buttonColor: true,
              ),
            ),
            const EmptyBox(boxSize: 5),
          ],
        ),
      ),
    );
  }
}
