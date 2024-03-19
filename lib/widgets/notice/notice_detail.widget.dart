import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

// Models
import 'package:erpalerts/models/notice.model.dart';

// Services
import 'package:flutter/services.dart';
import 'package:erpalerts/service/analytics.service.dart';

// Utils
import 'package:erpalerts/utils/snackbar.dart';

// Widgets
import 'package:erpalerts/widgets/buttons/link_button.widget.dart';
import 'package:erpalerts/widgets/buttons/cta_button.widget.dart';

class NoticeDetailWidget extends StatelessWidget {
  const NoticeDetailWidget({super.key, required this.notice});
  final Notice notice;

  Future<File?> downloadPDF(String url, String savePath) async {
    try {
      Dio dio = Dio();

      await dio.download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          print((received / total * 100).toStringAsFixed(0) + "%");
        }
      });

      return File(savePath);
    } catch (e) {
      print('Error downloading PDF: $e');
    }
    return null;
  }

  Future<File?> getAttachmentFile(String pdfUrl, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final savePath = '${dir.path}/notice_attachments';

    // Create folder if not exists
    final folder = Directory(savePath);
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    final String filePath = '$savePath/$fileName';

    final File file = File(filePath);
    if (file.existsSync()) {
      return file;
    }

    return await downloadPDF(pdfUrl, filePath);
  }

  shareAttachmentFile(BuildContext context) async {
    // Share the attachment file if it exists
    final file = await getAttachmentFile(
      notice.serverNoticeUrl!,
      notice.attachmentFileName!,
    );

    if (file == null) {
      showErrorBar(context, 'Something went wrong');
      return;
    }

    XFile xFile = XFile(file.path);

    AnalyticsService().register(Event.APP_SHARE_NOTICE, properties: {
      'noticeId': notice.id,
      'category': notice.category,
      'type': notice.type,
      'share_type': 'file'
    });

    Share.shareXFiles(
      [xFile],
    );

    return;
  }

  shareNotice() async {
    AnalyticsService().register(Event.APP_SHARE_NOTICE, properties: {
      'noticeId': notice.id,
      'category': notice.category,
      'type': notice.type,
      'share_type': 'text'
    });

    Share.share(
      notice.formattedNotice.replaceAll('\\n', '\n'),
    );
  }

  static const platform = const MethodChannel('com.kgplife.erpalerts/calendar');

  Future<void> addEventToCalendar() async {
    try {
      final String title = '${notice.company} | ${notice.category}';
      final String description = notice.formattedNotice.replaceAll('\\n', '\n');

      await platform.invokeMethod('addEventToCalendar', <String, dynamic>{
        'title': title,
        'description': description,
        // 'location': 'Flutter app',
        // 'startDate': startDate.millisecondsSinceEpoch,
        // 'endDate': endDate.millisecondsSinceEpoch,
      });
    } on PlatformException catch (e) {
      print("Failed to add event to calendar: ${e.message}");
    }
  }

  Future<String> getDownloadUrl() async {
    final storageRef = FirebaseStorage.instance.ref();
    final fileUrl = await storageRef
        .child("notice_attachments/${notice.attachmentFileName}")
        .getDownloadURL();
    return fileUrl;
  }

  getDownloadProperties([Map<String, dynamic>? properties]) {
    final Map<String, dynamic> props = {
      'fileName': notice.attachmentFileName,
      'company': notice.company,
      'category': notice.category,
      'type': notice.type,
    };

    if (properties != null) props.addAll(properties);
    return props;
  }

  Future<void> openPdf() async {
    try {
      String url = await getDownloadUrl();
      AnalyticsService()
          .register(Event.APP_DOWNLOAD_PDF_ALTERNATE, properties: {
        url: url,
      });

      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
        webViewConfiguration: const WebViewConfiguration(
          headers: {
            "Content-Type": "application/pdf",
          },
        ),
      );
    } catch (error) {
      // TODO: handle error
      // showErrorBar(context, 'Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(notice.company),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: notice.formattedNotice
                                  .replaceAll('\\n', '\n'),
                            ),
                          );
                          showSuccessBar(context, 'Copied to clipboard');
                        },
                        child: const Icon(
                          Icons.copy,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: shareNotice,
                        child: const Icon(
                          Icons.share,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: addEventToCalendar,
                        child: const Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Column(
                children: [
                  SelectableText(
                    notice.formattedNotice.replaceAll('\\n', '\n'),
                  ),
                  if (notice.noticeBodyUrls.isNotEmpty)
                    const SizedBox(
                      height: 10,
                    ),
                  if (notice.noticeBodyUrls.isNotEmpty)
                    const Text(
                      "Notice Links",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (notice.noticeBodyUrls.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: notice.noticeBodyUrls
                          .map((link) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: LinkButton(
                                  text: link,
                                  url: link,
                                  fontSize: 14,
                                ),
                              ))
                          .toList(),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${DateFormat.yMd().add_jm().format(notice.noticeAt)}",
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (notice.isAttachmentAvailable &&
              notice.attachmentFileName != null &&
              notice.attachmentUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CTA(
                        text: 'View Attachment',
                        onTap: () {
                          try {
                            // final fileServer =
                            //     Get.find<UserController>().fileServerUrl;
                            final url = notice.serverNoticeUrl as String;

                            AnalyticsService().register(
                                Event.APP_DOWNLOAD_PDF_SERVER,
                                properties: {
                                  'url': url,
                                });
                            // print(url);
                            launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalNonBrowserApplication,
                              webViewConfiguration: const WebViewConfiguration(
                                headers: {
                                  "Content-Type": "application/pdf",
                                },
                              ),
                            );
                          } catch (error) {
                            showErrorBar(context, 'Something went wrong');
                          }
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () => shareAttachmentFile(context),
                        child: const Icon(
                          Icons.logout,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
