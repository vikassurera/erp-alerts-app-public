import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Widgets
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';

class AppCloseScreen extends StatefulWidget {
  const AppCloseScreen({super.key});

  @override
  State<AppCloseScreen> createState() => _AppCloseScreenState();
}

class _AppCloseScreenState extends State<AppCloseScreen> {
  final appConfigController = Get.find<UserController>().appCloseInfo;

  @override
  void initState() {
    AnalyticsService().register(Event.APP_CLOSED_SCREEN);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                subtitle: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      appConfigController?.title ?? 'App Closed',
                      style: const TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      appConfigController?.desc.replaceAll('\\n', '\n') ??
                          'This app has been closed till further notice.',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const ContactSection(),
        ],
      ),
    );
  }
}
