import 'dart:convert';
import 'dart:io';

import 'package:fitter/models/month_daily_record.dart';
import 'package:fitter/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://j9d202.p.ssafy.io:8000";

  static void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('Authorization');
  }

  static void deleteProfile(Future<UserProfile> userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Authorization').toString();

    final url = Uri.parse("$baseUrl/api/user/profile");
    final response = await http.delete(
      url,
      headers: {
        "Authorization": token,
      },
    );
    userProfile.then(
      (value) => value.image = Image.network(
        "$baseUrl/api/user/profile-img",
        headers: {
          "Authorization": token,
        },
        fit: BoxFit.cover,
      ),
    );
  }

  static Future<UserProfile> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Authorization').toString();
    final url = Uri.parse("$baseUrl/api/user/user-info");
    final response = await http.get(
      url,
      headers: {
        "Authorization": token,
      },
    );
    final userInfo = jsonDecode(utf8.decode(response.bodyBytes));
    final image = Image.network(
      "$baseUrl/api/user/profile-img",
      headers: {
        "Authorization": token,
      },
      fit: BoxFit.cover,
    );
    // const jsonString =
    // '{"ageRange": "20대", "boxDto": { "boxName": "체육관" }, "email": "choiyc1446@gmail.com", "gender": true, "nickname": "최영창" }';

    // final userInfo = jsonDecode(jsonString);

    // final image = Image.network(
    //   "https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png",
    //   fit: BoxFit.cover,
    // );

    final userprofile = UserProfile(
      box: userInfo["boxDto"]["boxName"],
      ageGroup: userInfo["ageRange"],
      email: userInfo["email"],
      gender: userInfo["gender"],
      nickname: userInfo["nickname"],
      image: image,
    );
    return userprofile;
  }

  static Future<String> resign() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const api = "$baseUrl/api/user";
    final url = Uri.parse(api);
    final response = await http.delete(
      url,
      headers: {
        "Authorization": prefs.getString('Authorization').toString(),
      },
    );
    return response.body;
  }

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
