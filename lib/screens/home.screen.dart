import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Services
import 'package:erpalerts/service/local_notification.service.dart';
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Utils
import 'package:erpalerts/utils/app_update.dart';

// Screens
import 'package:erpalerts/screens/primary/primary.screen.dart';
import 'package:erpalerts/screens/developer.screen.dart';

// Widgets
import 'package:erpalerts/widgets/notice/notice_filter_drawer.widget.dart';
import 'package:erpalerts/widgets/loading.widget.dart';
import 'package:erpalerts/widgets/updates/updates_list.widget.dart';
import 'package:erpalerts/widgets/user/user_info.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = _widgetOptions = [
    const PrimaryScreen(), // 0
    UserInfo(), // 1
    const UpdateList(), // 2
    const DeveloperScreen(), // 3
  ];

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    // Check for App Updates (if any)
    checkAppUpdate(context);

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          // Add logic
        }
      },
    );

    // This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          // Add logic
        }
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final properties = {
      'loggedIn': true,
    };

    if (index == 3) {
      AnalyticsService()
          .register(Event.APP_DEVELOPER_INFO_SCREEN, properties: properties);
    } else if (index == 2) {
      AnalyticsService()
          .register(Event.APP_UPDATE_SCREEN, properties: properties);
    } else if (index == 1) {
      AnalyticsService()
          .register(Event.APP_USER_INFO_SCREEN, properties: properties);
    }
  }

  String getHeaderText() {
    if (_selectedIndex == 0) return "ERP Alerts";
    if (_selectedIndex == 1) return "User";
    if (_selectedIndex == 2) return "Updates";
    if (_selectedIndex == 3) return "Developer";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getHeaderText()),
          ],
        ),
        centerTitle: true,
      ),
      drawer: userController.showDrawer ? const NoticeFilterDrawer() : null,
      body: _widgetOptions.isEmpty
          ? const Loading()
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: 'Updates',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
