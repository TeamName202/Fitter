class CrossfitRankingModel {
  final String name;

  CrossfitRankingModel.fromJson(Map<String, dynamic> json)
      : name = json['name'];
}
