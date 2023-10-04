import 'dart:convert';
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:dio/dio.dart';
import 'package:fitter/models/month_daily_record.dart';
import 'package:fitter/models/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://j9d202.p.ssafy.io:8000";
  late SharedPreferences prefs;

  static Future<UserProfile> changeProfileImg(
      pickedImage, Future<UserProfile> userProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Authorization').toString();

    var formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(
          pickedImage!.path,
          filename: pickedImage.name,
        ),
      },
    );

    print(pickedImage);

    final dio = Dio();

    final response = await dio.post(
      '$baseUrl/api/user/profile',
      data: formData,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );

    print(response);

    final response2 = await http.get(
      Uri.parse("$baseUrl/api/user/user-info"),
      headers: {
        "Authorization": token,
      },
    );

    final userInfo = jsonDecode(utf8.decode(response2.bodyBytes));
    final image = Image.network(
      "$baseUrl/api/user/profile-img",
      headers: {
        "Authorization": token,
      },
      fit: BoxFit.cover,
    );

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

  static void updateProfile(String nickname, String? boxId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Authorization').toString();

    await http.put(
      Uri.parse("$baseUrl/api/user/nickname"),
      body: {"nickname": nickname},
      headers: {
        "Authorization": token,
      },
    );

    if (boxId != null) {
      print(boxId);
      await http.put(
        Uri.parse("$baseUrl/api/user/box/$boxId"),
        headers: {
          "Authorization": token,
        },
      );
    }
  }

  static void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('Authorization');
  }

  static Future<bool> deleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Authorization').toString();

    final url = Uri.parse("$baseUrl/api/user/profile");
    final response = await http.delete(
      url,
      headers: {
        "Authorization": token,
      },
    );
    return true;
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
    final prefs = await SharedPreferences.getInstance();
    late final headers = {
      'Authorization': prefs.getString('Authorization').toString(),
      // "Authorization":
      //     "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU3MTA3NSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.3DMwdvZYL7GSpBh3a5g2hESTJn8mYky0U-D7qrjHZ9zQL6Ojjn6qlqIyW4e5mlfPZKtC51xiWr59NRLV00j5HA",
    };
    const api = "api/calendar";
    final firstDayOfMonth =
        DateTime(day.year, day.month).toIso8601String().substring(0, 7);
    final uri = Uri.parse("$baseUrl/$api")
        .replace(queryParameters: {'date': firstDayOfMonth});
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final monthRecord = jsonDecode(utf8.decode(response.bodyBytes));
      List<dynamic> recordsList =
          monthRecord.map((item) => DailyMonthRecord.fromjson(item)).toList();
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
    final prefs = await SharedPreferences.getInstance();
    late final headers = {
      'Authorization': prefs.getString('Authorization').toString(),
      // "Authorization":
      //     "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU3MTA3NSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.3DMwdvZYL7GSpBh3a5g2hESTJn8mYky0U-D7qrjHZ9zQL6Ojjn6qlqIyW4e5mlfPZKtC51xiWr59NRLV00j5HA",
      'Content-Type': 'application/json',
    };
    const String api = "api/calendar/write";
    final uri = Uri.parse("$baseUrl/$api");
    final response = await http.post(uri,
        headers: headers,
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
