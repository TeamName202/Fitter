import 'package:fitter/screens/record/pr_record_screen.dart';
import 'package:fitter/screens/record/wod_record_screen.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>
    with SingleTickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Record'),
    Tab(text: 'WOD'),
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
      appBar: AppBar(
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
        children: const [
          PrRecordScreen(),
          WodRecordScreen(),
        ],
      ),
    );
  }
}
