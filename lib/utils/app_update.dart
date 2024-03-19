import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Models
import 'package:erpalerts/models/feature_flag.model.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Utils
import 'package:erpalerts/utils/snackbar.dart';

// Widgets
import 'package:erpalerts/Widgets/buttons/cta_button.widget.dart';

void checkAppUpdate(BuildContext context) async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    // wait for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    final AppUpdateAvailable? update =
        Get.find<UserController>().appUpdateAvailable;

    if (update == null) return;

    bool newVersionAvailable = false;

    List<int> newVersion =
        update.version.split('.').map((value) => int.parse(value)).toList();
    List<int> currentVersion =
        version.split('.').map((value) => int.parse(value)).toList();

    if (newVersion[0] > currentVersion[0]) {
      // Major Update
      newVersionAvailable = true;
    } else if (newVersion[0] == currentVersion[0] &&
        newVersion[1] > currentVersion[1]) {
      // Minor Update
      newVersionAvailable = true;
    } else if (newVersion[0] == currentVersion[0] &&
        newVersion[1] == currentVersion[1] &&
        newVersion[2] > currentVersion[2]) {
      // Patch Update
      newVersionAvailable = true;
    } else {
      // No Update
    }

    if (newVersionAvailable) {
      final screenHeight = MediaQuery.of(context).size.height;

      showModalBottomSheet<bool>(
        context: context,
        isDismissible: false,
        isScrollControlled: false,
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: screenHeight > 300 ? 300 : screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text('New Update Available',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  Text('Version: ${update.version}',
                      style: const TextStyle(fontSize: 16)),
                  Text(update.message, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  CTA(
                      text: 'Update Now',
                      onTap: () async {
                        try {
                          AnalyticsService().register(Event.APP_UPDATE_CLICK);
                          launchUrl(
                            Uri.parse(update.url),
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          showErrorBar(context, 'Something went wrong');
                        }
                      }),
                  // const SizedBox(height: 20),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   child: const Text('Close'),
                  // ),
                ],
              ),
            ),
          );
        },
      ).then((_) {});
    }
  } catch (e) {
    print(e);
  }
}
