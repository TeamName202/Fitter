class NewsModel {
  final String newsTitle, newsLink;

  NewsModel.fromJson(Map<String, dynamic> json)
      : newsTitle = json['title'],
        newsLink = json['link'];
}
