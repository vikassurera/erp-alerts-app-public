import 'package:flutter/material.dart';

// Models
import 'package:erpalerts/models/notice.model.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';
import 'package:erpalerts/service/notice.service.dart';

// Widgets
import 'package:erpalerts/widgets/notice/notice_detail.widget.dart';

class NoticeAlertScreen extends StatefulWidget {
  const NoticeAlertScreen({super.key, required this.noticeId});
  final String noticeId;

  @override
  State<NoticeAlertScreen> createState() => _NoticeAlertScreenState();
}

class _NoticeAlertScreenState extends State<NoticeAlertScreen> {
  final NoticeService _noticeService = NoticeService();
  bool _loading = true;
  String? _error;
  Notice? _notice;

  void fetchNotice() async {
    try {
      _notice = await _noticeService.fetchNotice(widget.noticeId);
    } catch (error) {
      print(error);
      _error = 'Unable to fetch notice';
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    AnalyticsService().register(Event.APP_NOTICE_ALERT_OPEN);
    fetchNotice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_notice != null
            ? '${_notice?.type} | ${_notice?.category}'
            : 'Notice Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _notice == null
                ? Center(
                    child: Text(
                      _error ?? 'Something went wrong',
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: 50,
                    ),
                    child: NoticeDetailWidget(notice: _notice!),
                  ),
      ),
    );
  }
}
