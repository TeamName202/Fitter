import 'dart:convert';

import 'package:fitter/models/rm_detail.dart';
import 'package:fitter/screens/pr_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChartScreen extends StatefulWidget {
  final String workoutName;
  const ChartScreen({super.key, required this.workoutName});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late Future<List<RMDetailModel>> oneRM;
  @override
  void initState() {
    super.initState();
    setAll();
  }

  bool showChartLabel = false;
  late SharedPreferences prefs;
  late Map<String, dynamic> rawData;
  List<ChartData> chartData = [];

// 백엔드에서 레코드 받아오기
  Future<List<RMDetailModel>> callServer() async {
    prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('Authorization');

    Map<String, String> headers = {
      'Authorization': accessToken.toString(),
    };

    var url = Uri.parse(
        'http://j9d202.p.ssafy.io:8000/api/record/list/${widget.workoutName}');
    var response = await http.get(url, headers: headers);

    List<RMDetailModel> rmLists = [];

    if (response.statusCode == 200) {
      // print('Response data: ${response.body}');
      print("success");
      final List<dynamic> rms = jsonDecode(response.body);
      for (var rm in rms) {
        rmLists.add(RMDetailModel.fromJson(rm));
      }
      return rmLists;
    }
    throw Error();
  }

  void makeListAsync(List<RMDetailModel> data) async {
    setState(() {
      for (int index = 0; index < data.length; index++) {
        chartData.add(ChartData(
          DateTime.parse(data[index].createDate),
          data[index].maxWeight.toDouble(),
        ));
      }
    });
  }

  Future setAll() async {
    setState(() {
      oneRM = callServer();
    });
    List<RMDetailModel> data = await callServer();
    makeListAsync(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: oneRM,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.workoutName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: SfCartesianChart(
                        onChartTouchInteractionDown: (onTapArgs) {
                          setState(() {
                            showChartLabel = !showChartLabel;
                          });
                        },
                        plotAreaBackgroundColor: Colors.blueGrey.shade50,

                        // backgroundColor: Colors.blueGrey.shade50,
                        // 차트 부분만 회색으로 할 지, 아니면 숫자 부분까지 다 회색으로 할 지 고민
                        primaryXAxis: DateTimeAxis(
                          dateFormat:
                              DateFormat('MM / dd'), // 연도하면 차트부분 너무 커짐...
                          labelIntersectAction:
                              AxisLabelIntersectAction.multipleRows,
                          majorGridLines: const MajorGridLines(width: 0),
                          majorTickLines: const MajorTickLines(
                              size: 0), // 레이블과 눈금 사이의 간격을 조절
                          minorGridLines: const MinorGridLines(width: 0),
                          minorTickLines: const MinorTickLines(size: 0),
                          // labelRotation: 305,
                        ),
                        series: <ChartSeries>[
                          StackedLineSeries<ChartData, DateTime>(
                            dataLabelSettings: DataLabelSettings(
                                isVisible: showChartLabel,
                                useSeriesColor: true),
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                          )
                        ]),
                  ),
                  Flexible(
                    flex: 5,
                    child: CustomScrollView(
                      slivers: [
                        // Sliver 위젯들을 여기에 추가
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: detailRMButton(
                                    snapshot.data![index].createDate,
                                    snapshot.data![index].maxWeight.toString()),
                              );
                            },
                            childCount: snapshot.data!.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                      pageBuilder: (context, anmation,
                                              secondaryAnimation) =>
                                          PRInputScreen(
                                              workoutName:
                                                  widget.workoutName)));
                            },
                            child: const Icon(
                              Icons.add_box,
                              color: Color(0xff0080ff),
                              size: 50,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Container detailRMButton(date, weight) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff0080ff),
          borderRadius: BorderRadius.circular(20)),
      width: 500,
      height: 63,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              weight,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final DateTime x;
  final double y;

  ChartData(this.x, this.y);
}
