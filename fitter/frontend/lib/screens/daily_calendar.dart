import 'package:fitter/screens/daily_record.dart';
import 'package:fitter/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
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
                headerStyle: HeaderStyle(
                  titleTextStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMMM(locale).format(date),
                  leftChevronIcon: const Icon(Icons.arrow_left_sharp),
                  rightChevronIcon: const Icon(Icons.arrow_right_sharp),
                ),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat format) {
                  setState(() {
                    this.format = format;
                  });
                }),
            const SizedBox(
              height: 10,
            ),
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
