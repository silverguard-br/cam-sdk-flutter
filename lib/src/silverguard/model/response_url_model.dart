class ResponseUrlModel {
  final UrlDataModel data;

  const ResponseUrlModel({required this.data});

  factory ResponseUrlModel.fromJson(Map<String, dynamic> json) =>
      ResponseUrlModel(data: UrlDataModel.fromJson(json['data']));
}

class UrlDataModel {
  final String url;

  const UrlDataModel({required this.url});

  factory UrlDataModel.fromJson(Map<String, dynamic> json) =>
      UrlDataModel(url: json['url']);
}
