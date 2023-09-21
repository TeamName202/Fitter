class DailyMonthRecord {
  final String date, memo;

  DailyMonthRecord.fromjson(Map<String, dynamic> json)
      : date = json['date'],
        memo = json['memo'];
}
