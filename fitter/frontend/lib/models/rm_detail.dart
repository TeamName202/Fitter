class RMDetailModel {
  final int maxWeight;
  final String createDate;

  RMDetailModel.fromJson(Map<String, dynamic> json)
      : maxWeight = json['maxWeight'],
        createDate = json['createDate'];
}
