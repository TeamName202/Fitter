class MyWodRankingModel {
  final String ranking, box, count;

  MyWodRankingModel.fromJson(Map<String, dynamic> json)
      : box = json['userDto']['boxDto']['boxName'],
        ranking = json['ranking'],
        count = json['count'];
  // wodtype = json['wodDto']['wodType']['type'];
}
