import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/notice.controller.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

class NoticeFilterDrawer extends StatefulWidget {
  const NoticeFilterDrawer({Key? key}) : super(key: key);

  @override
  State<NoticeFilterDrawer> createState() => _NoticeFilterDrawerState();
}

class _NoticeFilterDrawerState extends State<NoticeFilterDrawer> {
  final controller = Get.find<NoticeController>();

  @override
  void initState() {
    AnalyticsService().register(Event.APP_FILTER_DRAWER_OPEN);
    controller.initFilters();
    super.initState();
  }

  void applyFilter() {
    controller.applyFilter();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          children: [
            const Text('Filter By', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ToggleButtons(
              direction: Axis.vertical,
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 40,
              ),
              onPressed: (index) {
                controller.updateFilter(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: controller.filters
                  .map((e) => e.key == controller.selectedFilter?.key)
                  .toList(growable: false),
              children: controller.filters
                  .map((e) => Text(e.value))
                  .toList(growable: false),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              direction: Axis.vertical,
              constraints: const BoxConstraints(
                minWidth: double.infinity,
                minHeight: 40,
              ),
              onPressed: (index) {
                controller.updateType(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.blue[700],
              selectedColor: Colors.white,
              fillColor: Colors.blue[200],
              color: Colors.blue[400],
              isSelected: controller.typeFilter
                  .map((e) => e.key == controller.selectedType.key)
                  .toList(growable: false),
              children: controller.typeFilter
                  .map((e) => Text(e.value))
                  .toList(growable: false),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: applyFilter,
              child: controller.loading.isTrue
                  ? const CircularProgressIndicator()
                  : const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
