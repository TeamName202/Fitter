class WodListModel {
  final String name;
  final int id;

  WodListModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'];
}
