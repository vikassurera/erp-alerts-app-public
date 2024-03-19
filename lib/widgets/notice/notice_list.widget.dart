import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erpalerts/screens/notice_detail.screen.dart';
import 'package:erpalerts/controllers/notice.controller.dart';
import 'package:erpalerts/service/analytics.service.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({Key? key}) : super(key: key);

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  final controller = Get.find<NoticeController>();

  @override
  void initState() {
    controller.fetchAll();
    AnalyticsService().register(Event.APP_NOTICE_SCREEN);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: <Widget>[
            RefreshIndicator(
              onRefresh: controller.refreshAll,
              child: ListView.builder(
                  itemCount: controller.notices.length,
                  itemBuilder: (ctx, index) {
                    final item = controller.notices[index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          AnalyticsService().register(
                              Event.APP_NOTICE_DETAIL_SCREEN,
                              properties: {
                                "company": item.company,
                                "type": item.type,
                                "category": item.category,
                                "noticeAt": item.noticeAt.toString(),
                              });
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => NoticeDetailScreen(
                                index: index,
                              ),
                            ),
                          );
                        },
                        title: Text(item.company),
                        subtitle: Text(
                            "${item.type} | ${item.category} | ${DateFormat.yMd().add_jm().format(item.noticeAt)}"),
                      ),
                    );
                  }),
            ),
            if (controller.notices.isEmpty)
              const Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "No notices found",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            controller.loading.isTrue || controller.refreshing.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ],
        ));
  }
}
