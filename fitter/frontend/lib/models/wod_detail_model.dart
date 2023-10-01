class WODDetailModel {
  final String createDate;
  final int? count;
  final String? time;
  final int id;

  WODDetailModel.fromJson(Map<String, dynamic> json)
      : createDate = json['createDate'],
        count = json['count'],
        time = json['time'],
        id = json['id'];
}
