import 'package:erpalerts/models/notice_filter.model.dart';

class AppUpdateAvailable {
  final bool isAvailable;
  final String message;
  final String url;
  final bool isForceUpdate;
  final String version;

  AppUpdateAvailable({
    required this.isAvailable,
    required this.message,
    required this.url,
    required this.isForceUpdate,
    required this.version,
  });

  factory AppUpdateAvailable.fromJson(Map<String, dynamic> json) {
    return AppUpdateAvailable(
      isAvailable: json['isAvailable'] ?? false,
      message: json['message'] ?? '',
      url: json['url'] ?? '',
      isForceUpdate: json['isForceUpdate'] ?? false,
      version: json['version'] ?? '',
    );
  }
}

class AppCloseInfo {
  final bool isClosed;
  final String title;
  final String desc;

  AppCloseInfo({
    required this.isClosed,
    required this.title,
    required this.desc,
  });

  factory AppCloseInfo.fromJson(Map<String, dynamic> json) {
    return AppCloseInfo(
      isClosed: json['isClosed'] ?? false,
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}

class FeatureFlag {
  final String id;
  final List<String> allowedEmailDomains;
  final bool enablePayment;
  final bool enableFreeTrial;
  final bool enableLogin;
  final bool enableSignup;
  final bool enableAds;
  final String fileServerUrl;
  final Map<String, String> filters;
  final int updatedAt;
  final int createdAt;
  final AppUpdateAvailable appUpdateAvailable;
  final AppCloseInfo appCloseInfo;

  FeatureFlag({
    required this.id,
    required this.allowedEmailDomains,
    required this.enablePayment,
    required this.enableFreeTrial,
    required this.enableLogin,
    required this.enableSignup,
    required this.enableAds,
    required this.fileServerUrl,
    required this.filters,
    required this.updatedAt,
    required this.createdAt,
    required this.appUpdateAvailable,
    required this.appCloseInfo,
  });

  List<NoticeFilter> get noticeFilters {
    final filters = <NoticeFilter>[];
    this.filters.forEach((key, value) {
      filters.add(NoticeFilter(key: key, value: value));
    });
    return filters;
  }

  factory FeatureFlag.fromMap(Map<String, dynamic> json) {
    final filters = <String, String>{};
    json['filters'].forEach((key, value) {
      filters[key] = value;
    });

    return FeatureFlag(
      id: json["id"],
      allowedEmailDomains:
          List<String>.from(json["allowedEmailDomains"].map((x) => x)),
      enablePayment: json["enablePayment"],
      enableFreeTrial: json["enableFreeTrial"],
      enableLogin: json["enableLogin"],
      enableSignup: json["enableSignup"],
      enableAds: json["enableAds"],
      fileServerUrl: json["fileServerUrl"],
      filters: filters,
      updatedAt: json["updatedAt"],
      createdAt: json["createdAt"],
      appCloseInfo:
          AppCloseInfo.fromJson(json['appCloseInfo'] ?? <String, dynamic>{}),
      appUpdateAvailable: AppUpdateAvailable.fromJson(
          json['appUpdateAvailable'] ?? <String, dynamic>{}),
    );
  }
}
