class MyWodRankingModel {
  // 랭킹 추가 되어야 됨.
  // final String box, hour, minute, second, wodname, wodtype;
  final String box, count, wodname, wodtype;
  // final int count;

  MyWodRankingModel.fromJson(Map<String, dynamic> json)
      : box = json['content']['user']['boxDto']['boxName'],
        // hour = json['content']['time']['hour'],
        // minute = json['content']['time']['minute'],
        // second = json['content']['time']['second'],
        count = json['count'],
        wodname = json['content']['wod']['name'],
        // count = json['content']['count'],
        wodtype = json['content']['wodType']['type'];
}
