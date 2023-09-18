import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;

  DateTime selectedDay = DateTime(
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
                focusedDay: focusedDay,
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
            const Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ButtonMold(
                          btnText: 'EMOM',
                          horizontalLength: 15,
                          verticalLength: 8,
                          buttonColor: true),
                      ButtonMold(
                          btnText: 'EMOM',
                          horizontalLength: 15,
                          verticalLength: 8,
                          buttonColor: true),
                      ButtonMold(
                          btnText: 'EMOM',
                          horizontalLength: 15,
                          verticalLength: 8,
                          buttonColor: true),
                      ButtonMold(
                          btnText: 'EMOM',
                          horizontalLength: 15,
                          verticalLength: 8,
                          buttonColor: true),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Detail',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '30 Front Squats 155 / 105 lb', // placeholder
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Memo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextContainer()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextContainer extends StatefulWidget {
  const TextContainer({
    super.key,
  });

  @override
  State<TextContainer> createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color:
                isSelected ? Colors.blue : Colors.grey), // 선택 여부에 따라 테두리 색상 변경
        borderRadius: BorderRadius.circular(8), // 테두리의 둥근 모서리 설정 (선택사항)
      ),
      width: double.infinity, // 가로 너비를 최대로 설정
      height: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ), // 내부 여백 설정
      child: const TextField(
        decoration: InputDecoration(
          hintText: '오늘 한 와드에 대해 일기를 기록 해보세요.',
          border: InputBorder.none,
        ),
        maxLines: null,
      ),
    );
  }
}
