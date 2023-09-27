class WODDetailModel {
  final String? createDate;
  final int? count;
  final String? time;

  WODDetailModel.fromJson(Map<String, dynamic> json)
      : createDate = json['createDate'],
        count = json['count'],
        time = json['time'];
}

class TimeModel {
  final int? hour;
  final int? minute;
  final int? nano;
  final int? second;

  TimeModel.fromJson(Map<String, dynamic> json)
      : hour = json['hour'],
        minute = json['minute'],
        nano = json['nano'],
        second = json['second'];
}
