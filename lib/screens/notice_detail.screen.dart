import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Models
import 'package:erpalerts/models/notice.model.dart';

// Controllers
import 'package:erpalerts/controllers/notice.controller.dart';

// Widgets
import 'package:erpalerts/widgets/notice/notice_detail.widget.dart';

class NoticeDetailScreen extends StatefulWidget {
  final int index;
  const NoticeDetailScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  final controller = Get.find<NoticeController>();
  late Notice _currentNotice;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentNotice = controller.notices[widget.index];
      _pageController = PageController(initialPage: widget.index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_currentNotice.type} | ${_currentNotice.category}'),
        centerTitle: true,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            _currentNotice = controller.notices[newPage];
          });
        },
        physics: const BouncingScrollPhysics(),
        itemCount: controller.notices.length,
        itemBuilder: ((context, index) {
          final notice = controller.notices[index];
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: NoticeDetailWidget(
              notice: notice,
            ),
          );
        }),
      ),
    );
  }
}
