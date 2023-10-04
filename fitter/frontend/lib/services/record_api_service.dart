import 'dart:convert';

import 'package:fitter/models/crossfit_ranking_model.dart';
import 'package:fitter/models/my_wod_ranking_model.dart';
import 'package:fitter/models/pr_category_model.dart';
import 'package:fitter/models/pr_list_model.dart';
import 'package:fitter/models/wod_list_model.dart';
import 'package:fitter/models/wod_ranking_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RecordApiService {
  static const String baseUrl = "http://j9d202.p.ssafy.io:8000/api";

  // 운동 대분류 받아오기
  static Future<List<String>> getPrCategory() async {
    List<String> prCategoryInstances = [];

    final url = Uri.parse('$baseUrl/record/category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> prCategorys = jsonDecode(response.body);
      for (var prCategory in prCategorys) {
        // print(prCategory);
        if (prCategory["type"] != "None") {
          if (prCategory["type"] != "N/A") {
            prCategoryInstances.add(prCategory["type"]);
          }
        }
        print(prCategoryInstances);
      }
      return prCategoryInstances;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }

  // 개인 pr 최고기록 리스트 받아오기
  static Future<List<PrListModel>> getPrRecordList(String prCategory) async {
    List<PrListModel> prListInstances = [];
    final prefs = await SharedPreferences.getInstance();
    // final headers = {
    //   'Authorization': prefs.getString('Authorization').toString(),
    // };
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU1NjcwOSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.oHBW06jowIoDwXwUDs1n3gWtWIyIk5iOncB5lSJMb3SuQIAIHq3VZgqVaT200cnmdYY8hwE-2Zu3elcyL5XuTQ'
    };
    final url = Uri.parse("$baseUrl/record/list/rank");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final PrLists = jsonDecode(response.body); // string 타입을 json으로 바꿔줌.
      print('prCategory : $prCategory');
      for (var PrList in PrLists) {
        print("list[workoutDto] : ");
        print(PrList["max_weight"]);
        if (PrList["type"] == prCategory) {
          // print("prListInstances : $prListInstances");
          // null 값 처리
          if (PrList["max_weight"] == null) {
            PrList["max_weight"] = ' ';
          } else {
            PrList["max_weight"] = PrList["max_weight"].toString();
          }

          if (PrList["pr_id"] == null) {
            PrList["pr_id"] = ' ';
          } else {
            PrList["pr_id"] = PrList["pr_id"].toString();
          }
          print(PrList);
          prListInstances.add(PrListModel.fromJson(PrList));
          print("prListInstances : $prListInstances");
        }
      }
      // print("prListInstances :");
      return prListInstances;
    }
    throw Error();
  }

  // 네임드 와드 pr 가져오기
  static Future<List<WodListModel>> getNamedWods(String named) async {
    List<WodListModel> namedWodInstances = [];
    final prefs = await SharedPreferences.getInstance();
    // final headers = {
    //   'Authorization': prefs.getString('Authorization').toString(),
    // };
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU1NjcwOSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.oHBW06jowIoDwXwUDs1n3gWtWIyIk5iOncB5lSJMb3SuQIAIHq3VZgqVaT200cnmdYY8hwE-2Zu3elcyL5XuTQ'
    };
    final url = Uri.parse('$baseUrl/named-wod/list/$named');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> namedWods = jsonDecode(response.body);
      for (var namedWod in namedWods) {
        print('namedWod : $namedWod');
        namedWodInstances.add(WodListModel.fromJson(namedWod));
      }
      // print(namedWodInstances[0].type);
      return namedWodInstances;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }

  // 크로스핏 인지도 랭킹 받아오기
  static Future<List<CrossfitRankingModel>> getTodaysCrossfitRanking() async {
    List<CrossfitRankingModel> crossfitrankingInstances = [];
    final url = Uri.parse('$baseUrl/trend/sports');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> crossfitrankings =
          jsonDecode(utf8.decode(response.bodyBytes));
      int index = 1;
      for (var crossfitranking in crossfitrankings) {
        print(crossfitranking);
        crossfitrankingInstances.add(CrossfitRankingModel.fromJson({
          ...crossfitranking,
          'index': index,
        }));
        index++;
      }
      print(crossfitrankingInstances);
      return crossfitrankingInstances;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }

  // 크로스핏만 랭킹 받아오기
  static Future<List<CrossfitRankingModel>> getTodaysCrossRanking() async {
    List<CrossfitRankingModel> crossfitrank = [];
    final url = Uri.parse('$baseUrl/trend/sports');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> crossfitrankings =
          jsonDecode(utf8.decode(response.bodyBytes));
      int index = 1;
      for (var crossfitranking in crossfitrankings) {
        if (crossfitranking["name"] == '크로스핏') {
          crossfitrank.add(CrossfitRankingModel.fromJson({
            ...crossfitranking,
            'index': index,
          }));
        }

        index++;
      }
      print(crossfitrank);
      return crossfitrank;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }

  // 와드 카테고리 리스트 받아오기
  static Future<List<String>> getWodCategoryLists() async {
    List<String> wodCategoryInstances = [];
    final url = Uri.parse('$baseUrl/named-wod/list');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final wodCategorys = jsonDecode(response.body);
      for (var wodCategory in wodCategorys) {
        print(wodCategory);
        wodCategoryInstances.add(wodCategory["name"]);
      }

      print(wodCategoryInstances);
      return wodCategoryInstances;
    }

    throw Error();
  } // 200코드 아니면 에러 반환

  // 와드 전체 랭킹 받아오기
  static Future<List<WodRankingModel>> getWodRanking(String wodName) async {
    List<WodRankingModel> wodRankingInstances = [];
    final prefs = await SharedPreferences.getInstance();
    // final headers = {
    //   'Authorization': prefs.getString('Authorization').toString(),
    // };
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU1NjcwOSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.oHBW06jowIoDwXwUDs1n3gWtWIyIk5iOncB5lSJMb3SuQIAIHq3VZgqVaT200cnmdYY8hwE-2Zu3elcyL5XuTQ'
    };
    final url = Uri.parse("$baseUrl/rank/$wodName");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final WodRankings = jsonDecode(response.body); // string 타입을 json으로 바꿔줌.
      print('wodName : $wodName');
      for (var WodRaking in WodRankings) {
        if (WodRaking['content']['wodType']['type'] == 'For Time') {
          WodRaking['content']['count'] = WodRaking['content']['time']['hour'] +
              ':' +
              WodRaking['content']['time']['minute'] +
              ':' +
              WodRaking['content']['time']['second'];
        } else {
          WodRaking['content']['count'] =
              WodRaking['content']['count'].toString();
        }
        print('wodRaking : $WodRaking');
        wodRankingInstances.add(WodRankingModel.fromJson(WodRaking));
        print("wodRankingInstances : $wodRankingInstances");
      }

      return wodRankingInstances;
    }
    throw Error();
  }

  // 내 와드 랭킹 받아오기
  static Future<List<MyWodRankingModel>> getMyWodRanking(String wodName) async {
    List<MyWodRankingModel> myWodRankingInstances = [];
    final prefs = await SharedPreferences.getInstance();
    // final headers = {
    //   'Authorization': prefs.getString('Authorization').toString(),
    // };
    final headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NjU1NjcwOSwiaWQiOjY1LCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.oHBW06jowIoDwXwUDs1n3gWtWIyIk5iOncB5lSJMb3SuQIAIHq3VZgqVaT200cnmdYY8hwE-2Zu3elcyL5XuTQ'
    };
    final url = Uri.parse("$baseUrl/rank/my-rank/$wodName");
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final MyWodRankings = jsonDecode(response.body); // string 타입을 json으로 바꿔줌.
      print('wodName : $wodName');
      for (var MyWodRanking in MyWodRankings) {
        if (MyWodRanking['content']['wodType']['type'] == 'For Time') {
          MyWodRanking['content']['count'] = MyWodRanking['content']['time']
                  ['hour'] +
              ':' +
              MyWodRanking['content']['time']['minute'] +
              ':' +
              MyWodRanking['content']['time']['second'];
        } else {
          MyWodRanking['content']['count'] =
              MyWodRanking['content']['count'].toString();
        }
        print('wodRaking : $MyWodRanking');
        myWodRankingInstances.add(MyWodRankingModel.fromJson(MyWodRanking));
        print("wodRankingInstances : $myWodRankingInstances");
      }

      return myWodRankingInstances;
    }
    throw Error();
  }
}
