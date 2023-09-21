import 'dart:convert';

import 'package:fitter/models/month_daily_record.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://j9d202.p.ssafy.io:8000";

  void getDailyRecords() async {
    const String api = "api/calendar/test";
    // List<DailyMonthRecord> dailyRecords = [];
    final uri = Uri.parse("$baseUrl/$api")
        .replace(queryParameters: {'date': '2023-09'});
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> sendPostRequest(
      {required String selectedDay,
      required Map type,
      required String detail,
      required String memo}) async {
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
