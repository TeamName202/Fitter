class PrListModel {
  final String max_weight, name, type, pr_id;

  PrListModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pr_id = json['pr_id'],
        max_weight = json['max_weight'],
        type = json['type'];
}
