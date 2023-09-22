// import 'dart:convert';

// import 'package:fitter/models/pr_list_model.dart';
// import 'package:http/http.dart' as http;

// class ApiService {
//   static const String baseUrl = "http://j9d202.p.ssafy.io:8000/api";

//   static Future<List<PrListModel>> getPrList(String prCategory) async {
//     List<PrListModel> prListInstances = [];
//     final url = Uri.parse("$baseUrl/record/list/rank/test");
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final PrLists = jsonDecode(response.body); // string 타입을 json으로 바꿔줌.
//       for (var PrList in PrLists) {
//         print("list[workoutDto] : ");
//         print(PrList["workoutDto"]);
//         if (PrList["workoutDto"]["workoutTypeDto"]["type"] == prCategory) {
//           prListInstances.add(PrListModel.fromJson(PrList));
//         }
//       }
//       print(prListInstances);
//       return prListInstances;
//     }
//     throw Error();
//   }
// }
