import 'package:erpalerts/models/app_config/app_update.model.dart';
import 'package:erpalerts/models/app_config/plan_config.model.dart';
import 'package:erpalerts/models/app_config/allowed_emails.model.dart';
import 'package:erpalerts/models/app_config/app_flags.model.dart';
import 'package:erpalerts/models/app_config/file_server.model.dart';

class AppConfig {
  static const String fileServerKey = "file_server";
  static const String filtersKey = "filters";
  static const String allowedDomainsKey = "allowed_domains";
  static const String planKey = "plan";
  static const String appUpdateKey = "app_update";
  static const String flagsKey = "flags";

  AppConfig({
    required this.fileServer,
    required this.allowedDomains,
    required this.plan,
    required this.appUpdate,
    required this.flags,
  });

  final FileServer fileServer;
  final List<AllowedEmails> allowedDomains;
  final PlanConfig plan;
  final AppUpdateConfig appUpdate;
  final AppFlags flags;

  factory AppConfig.fromMap(Map<String, dynamic> json) {
    // loop through allowedDomains Map and create a list of AllowedEmails
    final allowedDomainsMap =
        json[AppConfig.allowedDomainsKey] as Map<String, dynamic>;
    final List<AllowedEmails> allowedDomains = [];
    allowedDomainsMap.forEach((key, value) {
      allowedDomains.add(AllowedEmails(field: key, isAllowed: value));
    });

    final plan = PlanConfig.fromMap(json[AppConfig.planKey]);
    final appUpdate = AppUpdateConfig.fromMap(json[AppConfig.appUpdateKey]);
    final fileServer = FileServer.fromMap(json[AppConfig.fileServerKey]);
    final flags = AppFlags.fromMap(json[AppConfig.flagsKey]);

    return AppConfig(
      fileServer: fileServer,
      allowedDomains: allowedDomains,
      plan: plan,
      appUpdate: appUpdate,
      flags: flags,
    );
  }
}
