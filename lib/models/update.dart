import 'package:erpalerts/models/app_update_data.model.dart';

class Update {
  final String id;
  final String title;
  final String description;
  final String? logo;
  final List<AppUpdateDataModel> data;
  final DateTime updateDate;

  Update({
    required this.id,
    required this.title,
    required this.description,
    required this.logo,
    required this.data,
    required this.updateDate,
  });

  factory Update.fromMap(Map<String, dynamic> json) {
    final List<AppUpdateDataModel> data = [];
    json['data'].forEach((item) {
      data.add(AppUpdateDataModel.extractModel(item));
    });

    return Update(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      logo: json["logo"],
      data: data,
      updateDate: DateTime.parse(json["updateDate"]),
    );
  }
}
