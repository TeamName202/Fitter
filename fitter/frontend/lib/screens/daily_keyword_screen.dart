import 'dart:convert';
import 'dart:math';
import 'package:fitter/models/news_model.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class DailyKeyword extends StatefulWidget {
  const DailyKeyword({super.key});

  @override
  State<DailyKeyword> createState() => _DailyKeywordState();
}

class _DailyKeywordState extends State<DailyKeyword> {
  late SharedPreferences prefs;
  List<String> keywords = [];
  List<NewsModel> newsList = [];
  bool isLoading = true;
  bool setNews = false;
  bool isNewsLoading = true;
  int keywordIndex = 0;

  @override
  void initState() {
    super.initState();
    setAll();
  }

  Future callServer() async {
    prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('Authorization');

    Map<String, String> headers = {
      'Authorization': accessToken.toString(),
    };

    var url = Uri.parse('http://j9d202.p.ssafy.io:8000/api/trend/health');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      final List<dynamic> rawKeywords =
          jsonDecode(utf8.decode(response.bodyBytes));
      return rawKeywords;
    }
    throw Error();
  }

  List<String> makeList(rawKeywords) {
    List<String> kewords = [];
    for (var rawKeyword in rawKeywords) {
      kewords.add(rawKeyword['name'].toString());
      isLoading = false;
    }
    return kewords;
  }

  Future makeNews(keyword) async {
    Map<String, String> queryParams = {
      'keyword': keyword.toString(),
    };
    var url = Uri.http(
        'j9d202.p.ssafy.io:8000', '/api/trend/health/search', queryParams);

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // print('Response data: ${response.body}');
      final List<dynamic> rawNews = jsonDecode(utf8.decode(response.bodyBytes));
      List<NewsModel> rawnewsList = [];
      for (var raw in rawNews) {
        rawnewsList.add(NewsModel.fromJson(raw));
        isNewsLoading = false;
      }
      print(rawnewsList);
      setState(() {
        newsList = rawnewsList;
      });
    }
  }

  Future setAll() async {
    List<dynamic> data = await callServer();
    setState(() {
      keywords = makeList(data);
    });
  }

  void tapKeyword(keyword, index) {
    makeNews(keyword);
    setState(() {
      setNews = true;
      keywordIndex = index;
    });
  }

  goNews(newLink) async {
    print(newLink);
    await launchUrlString(newLink);
  }

  @override
  Widget build(BuildContext context) {
    final List<Rect> buttonRects = [];

    // 오늘의 키워드 위치 계산
    Offset getRandomPosition(double maxWidth, double maxHeight,
        double buttonWidth, double buttonHeight) {
      final random = Random();
      double left, top;
      bool isIntersecting;
      do {
        isIntersecting = false;
        left = random.nextDouble() * (maxWidth - buttonWidth);
        top = random.nextDouble() * (maxHeight - buttonHeight);

        // 현재 버튼과 이전 버튼들 간의 충돌 검사
        for (var rect in buttonRects) {
          if (rect
              .overlaps(Rect.fromLTWH(left, top, buttonWidth, buttonHeight))) {
            isIntersecting = true;
            break;
          }
        }
      } while (isIntersecting);
      buttonRects.add(Rect.fromLTWH(left, top, buttonWidth, buttonHeight));
      return Offset(left, top);
    }

    // 뉴스 카드 캐러샐 만들기
    List<Widget> valuesWidget = [];
    // for (var i = 0; i < 5; i++) {
    //   var pointer = keywordIndex * i + 1;
    //   for(){

    //   }
    valuesWidget.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.lightBlue[100 * (keywordIndex + 1)],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                isLoading
                    ? 'is Loading ...'
                    : keywords[keywordIndex].toString(),
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("확인!!");
                  goNews(
                      isNewsLoading ? "크로스핏" : newsList[keywordIndex].newsLink);
                },
                child: ButtonMold(
                    btnText: isNewsLoading
                        ? "is Loading ..."
                        : newsList[keywordIndex].newsTitle,
                    horizontalLength: 40,
                    verticalLength: 20,
                    buttonColor: false),
              )
            ],
          ),
        )));
    // }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Flexible(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : LayoutBuilder(
                          builder: (context, constraints) {
                            double maxWidth = constraints.maxWidth;
                            double maxHeight = constraints.maxHeight;

                            return Stack(
                              children: List.generate(
                                5,
                                (i) {
                                  double buttonWidth = 80;
                                  double buttonHeight = 40;

                                  Offset position = getRandomPosition(maxWidth,
                                      maxHeight, buttonWidth, buttonHeight);

                                  return Positioned(
                                    left: position.dx,
                                    top: position.dy,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        tapKeyword(keywords[i], i);
                                      },
                                      child: Text(
                                        keywords[i],
                                        style: const TextStyle(
                                            color: Color(0xff0080ff)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                )),
            if (setNews)
              Flexible(
                flex: 4,
                child: Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10, end: 10, top: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.0), // 왼쪽 위 모서리를 둥글게
                      topRight: Radius.circular(14.0), // 오른쪽 위 모서리를 둥글게
                    ),
                    color: Color.fromARGB(255, 113, 172, 255),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            isLoading
                                ? 'is Loading ...'
                                : keywords[keywordIndex].toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: newsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  goNews(isNewsLoading
                                      ? "크로스핏"
                                      : newsList[index].newsLink);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ButtonMold(
                                    btnText: isNewsLoading
                                        ? "is Loading ..."
                                        : newsList[index].newsTitle,
                                    horizontalLength: 40,
                                    verticalLength: 20,
                                    buttonColor: false,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
