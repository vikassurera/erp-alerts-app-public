import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Config
import 'package:erpalerts/config/prod.config.dart';

enum Event {
  APP_OPEN,

  // Screens
  APP_LOGIN_SCREEN,
  APP_UPDATE_SCREEN,
  APP_USER_INFO_SCREEN,
  APP_DEVELOPER_INFO_SCREEN,
  APP_CLOSED_SCREEN,

  APP_WELCOME_SCREEN,
  APP_PURCHASE_PLAN_SCREEN,
  APP_NOTICE_SCREEN,
  APP_PLAN_EXPIRED_SCREEN,

  APP_NOTICE_DETAIL_SCREEN,
  APP_NOTICE_ALERT_OPEN,
  APP_ERROR_SCREEN,

  // Notice Detail
  APP_DOWNLOAD_PDF_SERVER,
  APP_DOWNLOAD_PDF_ALTERNATE,
  APP_DOWNLOAD_PDF_ERP,
  APP_SHARE_NOTICE,

  // FILTER
  APP_FILTER_DRAWER_OPEN,

  // Purchase
  APP_VIEW_PRICING,
  APP_BUY_PLAN_WIDGET,
  APP_BUY_NOW_CLICK,

  APP_PAYMENT_SUCCESS,
  APP_PAYMENT_FAILED,
  APP_PAYMENT_OTHER,

  // App Update
  APP_UPDATE_CLICK;

  @override
  String toString() => this.name;
}

class AnalyticsService {
  Mixpanel? mixpanel;

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init(
      Config.mixPanelKey,
      optOutTrackingDefault: false,
      trackAutomaticEvents: true,
    );
  }

  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal() {
    // initialization logic
  }

  _sendTrack(Event event, {Map<String, dynamic>? properties}) {
    if (mixpanel == null) return;

    final controller = Get.find<UserController>();

    Map<String, dynamic> props = {
      'Email': controller.email,
      'DisplayName': controller.displayName,
    };

    // merge properties into props
    if (properties != null) {
      props.addAll(properties);
    }

    mixpanel?.track(event.toString(), properties: props);
  }

  void register(Event event, {Map<String, dynamic>? properties}) {
    _sendTrack(event, properties: properties);
  }

  void reset() {
    mixpanel?.reset();
  }

  void identify(String id) {
    mixpanel?.identify(id);
  }

  void setUserProperties(Map<String, dynamic> properties) {
    // loop and set properties
    properties.forEach((key, value) {
      mixpanel?.getPeople().set(key, value);
    });
  }
}
