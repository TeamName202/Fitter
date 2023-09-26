import 'dart:convert';

import 'package:fitter/models/month_daily_record.dart';
import 'package:fitter/models/user_profile.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://j9d202.p.ssafy.io:8000";

  Future<List> fetchEventsForMonth(DateTime day) async {
    const api = "api/calendar/test";
    final firstDayOfMonth =
        DateTime(day.year, day.month).toIso8601String().substring(0, 7);
    final uri = Uri.parse("$baseUrl/$api")
        .replace(queryParameters: {'date': firstDayOfMonth});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // print("responseBody: ${response.body}");
      final monthRecord = jsonDecode(utf8.decode(response.bodyBytes));
      // print(monthRecord);
      List<dynamic> recordsList =
          monthRecord.map((item) => DailyMonthRecord.fromjson(item)).toList();
      // print('monthRecord: ${monthRecord.runtimeType}');
      return recordsList;
    } else {
      throw Error();
    }
  }

  Future<void> sendPostRequest({
    required String selectedDay,
    required Map type,
    required String detail,
    required String memo,
  }) async {
    const String api = "api/calendar/test/write";
    final uri = Uri.parse("$baseUrl/$api");
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'date': selectedDay,
          'wodTypeDto': type,
          'detail': detail,
          'memo': memo,
        }));
    if (response.statusCode == 200) {
      // 서버가 성공적으로 응답하면.
      print('Data sent successfully : ${response.body}');
    } else {
      // 서버가 실패로 응답하면.
      print('Failed to send data : ${response.statusCode}');
    }
  }
}
