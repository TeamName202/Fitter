class CrossfitRankingModel {
  final int rank; // 인덱스 변수 추가
  final String name;

  CrossfitRankingModel({required this.rank, required this.name}); // 생성자 수정

  factory CrossfitRankingModel.fromJson(Map<String, dynamic> json) {
    return CrossfitRankingModel(
      rank: json['index'] as int, // JSON 데이터에서 'index' 필드를 읽어와 인덱스 변수에 저장
      name: json['name'] as String,
    );
  }
}
