class WodListModel {
  final String name;
  final int id;
  final String type;

  WodListModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        type = json['wodType']['type'];
}
