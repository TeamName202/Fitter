class DailyMonthRecord {
  final DateTime? date;
  final String memo, detail, wodType;

  DailyMonthRecord.fromjson(dynamic json)
      : date = (json['date'] != null) ? DateTime.parse(json['date']) : null,
        memo = json['memo'] ?? "",
        detail = json['detail'] ?? "",
        wodType =
            (json['wodTypeDto'] != null) ? json['wodTypeDto']['type'] : "";
}
