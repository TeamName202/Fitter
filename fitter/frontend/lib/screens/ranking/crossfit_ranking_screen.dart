import 'package:fitter/models/crossfit_ranking_model.dart';
import 'package:fitter/services/record_api_service.dart';
import 'package:flutter/material.dart';

class CrossfitRankingScreen extends StatelessWidget {
  CrossfitRankingScreen({super.key});

  final Future<List<CrossfitRankingModel>> sportskeywords =
      RecordApiService.getTodaysCrossfitRanking();

  final Future<List<CrossfitRankingModel>> crossfitrank =
      RecordApiService.getTodaysCrossRanking();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "오늘의 크로스핏 인지도는?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: sportskeywords,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: makePrList(snapshot));
                  }
                  return Container();
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 30,
                child: Icon(Icons.more_vert_rounded),
              ),
            ),
            FutureBuilder(
                future: crossfitrank,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(child: makeCrPrList(snapshot));
                  }
                  return Container();
                }),
          ],
        ));
  }

  ListView makePrList(AsyncSnapshot<List<CrossfitRankingModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical, // 세로로 스크롤
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        // 패딩 주는거
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        // print(index);
        var crossfitranking = snapshot.data![index];
        print(crossfitranking);
        return Container(
            height: 55,
            color: const Color(0XFFEEF1F4),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 50,
                    child: Text(
                      crossfitranking.rank.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),

                  // const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                        width: 10,
                        child: Text(
                          crossfitranking.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17),
                        )),
                  ),
                  // const Expanded(
                  const SizedBox(width: 70),
                ],
              ),
            ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  ListView makeCrPrList(AsyncSnapshot<List<CrossfitRankingModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.vertical, // 세로로 스크롤
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        // 패딩 주는거
        vertical: 10,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        // print(index);
        var crossfitranking = snapshot.data![index];
        print(crossfitranking.name);
        return Container(
            height: 60,
            color: const Color.fromARGB(255, 143, 183, 223),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 50,
                    child: Text(
                      crossfitranking.rank.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 8, 37, 115),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                  ),

                  // const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                        width: 10,
                        child: Text(
                          crossfitranking.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 8, 37, 115),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        )),
                  ),
                  // const Expanded(
                  const SizedBox(width: 70),
                ],
              ),
            ));
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
