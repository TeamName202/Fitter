class WodRankingModel {
  // 랭킹 추가되어야 됨.
  // final String box, hour, minute, second, wodname, wodtype;
  final String box, count, wodname, wodtype, nickname, profile;
  // final int count;

  WodRankingModel.fromJson(Map<String, dynamic> json)
      : box = json['content']['user']['boxDto']['boxName'],
        nickname = json['content']['user']['nickname'],
        profile = json['content']['user']['profileImgDto']['filePath'],
        // hour = json['content']['time']['hour'],
        // minute = json['content']['time']['minute'],
        // second = json['content']['time']['second'],
        count = json['count'],
        wodname = json['content']['wod']['name'],
        // count = json['content']['count'],
        wodtype = json['content']['wodType']['type'];
}
