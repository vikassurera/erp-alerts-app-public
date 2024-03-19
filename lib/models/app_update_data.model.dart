abstract class AppUpdateDataModel {
  late String type;

  static extractModel(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'link':
        return AppUpdateDataLinkModel.fromMap(json);
      case 'image':
        return AppUpdateDataImageModel.fromMap(json);
      default:
        return AppUpdateDataTextModel.fromMap(json);
    }
  }
}

class AppUpdateDataLinkModel extends AppUpdateDataModel {
  String text;
  String url;

  AppUpdateDataLinkModel({
    required this.text,
    required this.url,
  }) {
    type = 'link';
  }

  factory AppUpdateDataLinkModel.fromMap(Map<String, dynamic> json) =>
      AppUpdateDataLinkModel(
        text: json["text"],
        url: json["url"],
      );
}

class AppUpdateDataImageModel extends AppUpdateDataModel {
  String url;
  int height;

  AppUpdateDataImageModel({
    required this.url,
    required this.height,
  }) {
    type = 'image';
  }

  factory AppUpdateDataImageModel.fromMap(Map<String, dynamic> json) =>
      AppUpdateDataImageModel(
        url: json["url"],
        height: json["height"],
      );
}

class AppUpdateDataTextModel extends AppUpdateDataModel {
  String text;

  AppUpdateDataTextModel({
    required this.text,
  }) {
    type = 'text';
  }

  factory AppUpdateDataTextModel.fromMap(Map<String, dynamic> json) =>
      AppUpdateDataTextModel(
        text: json["text"],
      );
}
