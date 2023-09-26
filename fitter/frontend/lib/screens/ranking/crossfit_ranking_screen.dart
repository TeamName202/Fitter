// import 'package:fitter/models/crossfit_ranking_model.dart';
// import 'package:fitter/services/record_api_service.dart';
// import 'package:flutter/material.dart';

// class CrossfitRankingScreen extends StatelessWidget {
//   const CrossfitRankingScreen({super.key});

//   // final Future<List<CrossfitRankingModel>> sportskeywords = RecordApiService().



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 150,
//           ),
//           const Text("오늘의 크로스핏 인지도는?"),
//           FutureBuilder(
//             future: sportskeywords, builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Column(
//             children: [
//               const SizedBox(
//                 height: 200,
//               ),
//               Expanded(child: makeList(snapshot)),
//             ],
//           );
//         }
//       }),
//         ],
//       )
      
//     );
//   }

//   ListView makeList(AsyncSnapshot<List<CrossfitRankingModel>> snapshot) {
//     return ListView.separated(
//       scrollDirection: Axis.vertical, // 세로로 스크롤
//       itemCount: snapshot.data!.length,
//       padding: const EdgeInsets.symmetric(
//         // 패딩 주는거
//         vertical: 10,
//         horizontal: 20,
//       ),
//       itemBuilder: (context, index) {
//         // print(index);
//         var crossfitranking = snapshot.data![index];
//         // 바로 박스로 띄우는거 ㄱㄱ
//         )
// return null;
//       },
//       separatorBuilder: (context, index) => const SizedBox(
//         width: 40,
//       ),
//     );
//   }
//   }