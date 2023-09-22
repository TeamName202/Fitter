class PrListModel {
  final String createDate;
  final int id, maxWeight;
  final dynamic workoutDto;

  PrListModel.fromJson(Map<String, dynamic> json)
      : createDate = json['createDate'],
        id = json['id'],
        maxWeight = json['maxWeight'],
        workoutDto = json['workoutDto'];
}
