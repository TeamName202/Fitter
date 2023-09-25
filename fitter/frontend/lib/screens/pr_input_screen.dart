import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/empty_box.dart';
import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PRInputScreen extends StatefulWidget {
  final String workoutName;
  const PRInputScreen({super.key, required this.workoutName});

  @override
  State<PRInputScreen> createState() => _PRInputScreenState();
}

class _PRInputScreenState extends State<PRInputScreen> {
  final recordController = TextEditingController();
  var selectedDate = DateTime.now();
  late SharedPreferences prefs;

  Future writePR() async {
    prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/record/create');

    final headers = {
      'Authorization': prefs.getString('Authorization').toString(),
      'Content-Type': 'application/json'
    };
    final body = jsonEncode(
      {
        "createDate": DateFormat('yyyy-MM-dd').format(selectedDate),
        "maxWeight": recordController.text,
        "workoutName": widget.workoutName,
      },
    );

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      setState(() {
        print('요청 성공: ${response.body}');
      });
    } else {
      // 요청이 실패한 경우
      setState(() {
        print('요청 실패: ${response.statusCode}');
      });
    }
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      title: ' ',
      dateOrder: DatePickerDateOrder.ymd,
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.blue,
      ),
      buttonText: '',
      buttonTextStyle: const TextStyle(color: Colors.white),
      buttonSingleColor: const Color(0xff0080ff),
      onChange: (index) {
        print(index);
      },
      onSubmit: (index) {
        setState(() {
          selectedDate = index;
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.5,
        title: Text(
          "${widget.workoutName} RECORD",
          style: const TextStyle(fontSize: 25),
        ),
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const EmptyBox(boxSize: 1),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  border: const Border(
                      bottom: BorderSide(color: Color(0xff0080ff), width: 3)),
                  color: Colors.blueGrey.shade50),
              child: GestureDetector(
                onTap: () {
                  _openDatePicker(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("날짜 선택"),
                    Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            const EmptyBox(boxSize: 1),
            TextField(
              controller: recordController,
              decoration: InputDecoration(
                labelText: 'RECORD',
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff0080ff),
                    width: 7,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff0080ff),
                    width: 7,
                  ),
                ),
                filled: true,
                fillColor: Colors.blueGrey.shade50,
              ),
            ),
            const EmptyBox(boxSize: 1),
            GestureDetector(
              onTap: () {
                writePR();
              },
              child: const ButtonMold(
                  btnText: "등 록 하 기",
                  horizontalLength: 25,
                  verticalLength: 10,
                  buttonColor: true),
            ),
            const EmptyBox(boxSize: 10),
          ],
        ),
      ),
    );
  }
}
