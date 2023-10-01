class RMDetailModel {
  final int maxWeight, id;
  final String createDate;

  RMDetailModel.fromJson(Map<String, dynamic> json)
      : maxWeight = json['maxWeight'],
        createDate = json['createDate'],
        id = json['id'];
}
