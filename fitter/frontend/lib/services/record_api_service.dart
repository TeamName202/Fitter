import 'dart:convert';

import 'package:fitter/models/crossfit_ranking_model.dart';
import 'package:fitter/models/pr_category_model.dart';
import 'package:fitter/models/pr_list_model.dart';
import 'package:fitter/models/wod_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NTg3NjY1NywiaWQiOjQwLCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.hGHLJoP5Nj9p-cI2xADluyNEJIlPN1eu1668kwiob9aWO_LZWh9wZ2H1YJPRbgwNZpsecadDtFOCCjKe5UdzBw'
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
          'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY5NTg3NjY1NywiaWQiOjQwLCJlbWFpbCI6ImFhYUBhYWEuY29tIn0.hGHLJoP5Nj9p-cI2xADluyNEJIlPN1eu1668kwiob9aWO_LZWh9wZ2H1YJPRbgwNZpsecadDtFOCCjKe5UdzBw'
    };
    final url = Uri.parse('$baseUrl/named-wod/list/$named');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> namedWods = jsonDecode(response.body);
      for (var namedWod in namedWods) {
        print('namedWod : $namedWod');
        namedWodInstances.add(WodListModel.fromJson(namedWod));
      }
      return namedWodInstances;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }

  // 크로스핏 랭킹 받아오기
  static Future<List<CrossfitRankingModel>> getTodaysToons() async {
    List<CrossfitRankingModel> crossfitrankingInstances = [];
    final url = Uri.parse('$baseUrl/trend/sports');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> crossfitrankings = jsonDecode(response.body);
      for (var crossfitranking in crossfitrankings) {
        print(crossfitranking);
        crossfitrankingInstances
            .add(CrossfitRankingModel.fromJson(crossfitranking));
      }
      return crossfitrankingInstances;
    }
    throw Error(); // 200코드 아니면 에러 반환
  }
}
