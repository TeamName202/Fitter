class WodRankingModel {
  // 랭킹 추가되어야 됨.
  final int rank;
  final String box, count, nickname, profile;

  WodRankingModel({
    required this.rank,
    required this.box,
    required this.count,
    required this.nickname,
    required this.profile,
  });

  factory WodRankingModel.fromJson(Map<String, dynamic> json) {
    return WodRankingModel(
      box: json['user']['boxDto']['boxName'] as String,
      nickname: json['user']['nickname'] as String,
      profile: json['user']['profileImgDto']['filePath'] as String,
      count: json['count'] as String,
      rank: json['index'] as int, // JSON 데이터에서 'index' 필드를 읽어와 인덱스 변수에 저장
    );
  }
}
