import 'package:fitter/screens/daily/daily_record.dart';
import 'package:fitter/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month; // 달력 형식 (달 별로 보여주기)

  // type 관련하여 사용할 변수

  DateTime selectedDay = DateTime(
    // 캘린더에서 선택될 날에 대한 변수, 초깃값은 현재
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  dynamic events = []; // 초기값 빈 맵으로 변경

  @override
  void initState() {
    super.initState();
    fetchEventsForMonth(focusedDay)
        .then((_) => calendarEventLoader(focusedDay));
    // 초기 로딩 시 현재 달의 이벤트 불러오기
  }

  Future<void> fetchEventsForMonth(DateTime day) async {
    final fetchedEvents = await ApiService().fetchEventsForMonth(day);
    setState(() {
      events = [];
      events.addAll(fetchedEvents);
    });
  }

  List<dynamic> calendarEventLoader(DateTime date) {
    // 일치하는 요소들을 저장할 빈 리스트 생성
    List<dynamic> matchingEvents = [];

    // events 리스트 순회하며 date와 일치하는 요소 찾기
    for (var event in events) {
      final evedate = event.date.toString().substring(0, 10);
      final compdate = date.toString().substring(0, 10);
      if (evedate == compdate) {
        matchingEvents.add(event);
      }
    }
    // print('event : $matchingEvents');
    return matchingEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TableCalendar(
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, dynamic event) {
                    if (event.isNotEmpty) {
                      return Container(
                        width: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0080FF).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      );
                    }
                    return null;
                  },
                ),
                focusedDay: focusedDay, // 주목할 날짜
                firstDay: DateTime(1800),
                lastDay: DateTime(3000),
                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신합니다.
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
                  return isSameDay(selectedDay, day);
                },
                headerStyle: const HeaderStyle(
                  headerPadding: EdgeInsets.only(bottom: 10),
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 25),
                  leftChevronIcon: Icon(Icons.arrow_left_sharp),
                  rightChevronIcon: Icon(Icons.arrow_right_sharp),
                ),
                calendarFormat: format,
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    markersMaxCount: 4, // 마커 개수 제한
                    defaultTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    weekendTextStyle: const TextStyle(color: Colors.red),
                    // outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                      // color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF136AF3)),
                    ),
                    todayTextStyle: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF136AF3),
                      shape: BoxShape.circle,
                    )),
                onFormatChanged: (CalendarFormat format) {
                  setState(
                    () {
                      this.format = format;
                    },
                  );
                },
                eventLoader: (date) => calendarEventLoader(
                    date), // 여기서 리턴되는 리스트 안의 요소만큼 mark가 표시됨.
                onPageChanged: (page) {
                  focusedDay = page;
                  fetchEventsForMonth(page);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView(
              shrinkWrap: true,
              children: calendarEventLoader(selectedDay)
                  .map((e) => ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF136AF3), width: 2),
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                // 해당 부분 디자인 수정하면 된다.
                                Text(
                                  e.wodType,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(e.memo),
                                      Text(e.detail),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DailyExerciseRecord(selectedDay: selectedDay),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
