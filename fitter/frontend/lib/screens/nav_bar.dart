import 'package:fitter/screens/daily/daily_calendar.dart';

import 'package:fitter/screens/daily_keyword_screen.dart';
import 'package:fitter/screens/generator/generator.dart';
import 'package:fitter/screens/mypage/mypage.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

void main() => runApp(const NavBarWidget());

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

bool colorChange = true;

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 2;

  static final List<Text> _widgetTitle = <Text>[
    const Text(
      "랭킹",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    const Text(
      "기록",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    const Text(
      "데일리",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    const Text(
      "오늘의 키워드",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    const Text(
      "와드 생성기",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Calendar(),
    Calendar(),
    Calendar(),
    DailyKeyword(),
    WodGenerator(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      colorChange = !colorChange;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _widgetTitle.elementAt(_selectedIndex),
        elevation: 0,
        foregroundColor: const Color(0xFF0080FF),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const MyPage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_events_outlined),
            label: 'Ranking',
            backgroundColor:
                colorChange ? const Color(0xff0080ff) : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.data_thresholding_sharp),
            label: 'Record',
            backgroundColor:
                colorChange ? const Color(0xff0080ff) : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
            backgroundColor:
                colorChange ? const Color(0xff0080ff) : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.numbers),
            label: 'Issue',
            backgroundColor:
                colorChange ? const Color(0xff0080ff) : Colors.white,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center_outlined),
            label: 'Wod Generator',
            backgroundColor:
                colorChange ? const Color(0xff0080ff) : Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorChange ? Colors.white : const Color(0xff0080ff),
        unselectedItemColor: colorChange ? Colors.white54 : Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}
