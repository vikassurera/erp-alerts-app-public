class AppUpdateConfig {
  static const String versionKey = "version";
  static const String linkKey = "link";
  static const String enforceKey = "enforce";
  static const String messageKey = "message";

  AppUpdateConfig({
    required this.version,
    required this.link,
    required this.enforce,
    required this.message,
  });

  final String version;
  final String link;
  final bool enforce;
  final String message;

  factory AppUpdateConfig.fromMap(Map<String, dynamic> json) => AppUpdateConfig(
        version: json[AppUpdateConfig.versionKey],
        link: json[AppUpdateConfig.linkKey],
        enforce: json[AppUpdateConfig.enforceKey],
        message: json[AppUpdateConfig.messageKey],
      );
}
