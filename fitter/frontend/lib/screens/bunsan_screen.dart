import 'package:fitter/screens/daily_keyword_screen.dart';
import 'package:fitter/screens/ranking/crossfit_ranking_screen.dart';
import 'package:fitter/screens/record/pr_record_screen.dart';
import 'package:fitter/screens/record/wod_record_screen.dart';
import 'package:flutter/material.dart';

class BunsanScreen extends StatefulWidget {
  const BunsanScreen({super.key});

  @override
  State<BunsanScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<BunsanScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: '오늘의 크로스핏 순위'),
    Tab(text: '오늘의 건강 뉴스'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: myTabs.length,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          labelColor: Colors.blue, // 선택된 탭의 텍스트 색상
          unselectedLabelColor: Colors.grey, // 선택되지 않은 탭의 텍스트 색상
          labelStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900), // 선택된 탭의 텍스트 스타일
          unselectedLabelStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w900), // 선택되지 않은 탭의 텍스트 스타일
          indicator: const BoxDecoration(
            // 선택된 탭 아래의 인디케이터 스타일
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.blue, width: 2.0)),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CrossfitRankingScreen(),
          const DailyKeyword(),
        ],
      ),
    );
  }
}
