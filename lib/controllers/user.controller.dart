import 'package:get/get.dart';

// Config
import 'package:erpalerts/config/prod.config.dart';

// Models
import 'package:erpalerts/models/feature_flag.model.dart';
import 'package:erpalerts/models/plan.model.dart';
import 'package:erpalerts/models/user.model.dart';
import 'package:erpalerts/models/notice_filter.model.dart';

// Services
import 'package:erpalerts/service/user.service.dart';
import 'package:erpalerts/service/analytics.service.dart';
import 'package:erpalerts/service/plan.service.dart';

enum MAIN_SCREEN_ACCESS {
  ERROR,
  NOTICE,
  PURCHASE_PLAN,
  HAVE_TO_VERIFY_EMAIL,
  PLAN_EXPIRED,
  APP_CLOSED,
}

const TAG = '[UserController]';

class UserController extends GetxController {
  final UserService _userService = UserService();
  final PlanService _planService = PlanService();

  User? _user;
  Plan? _plan;
  FeatureFlag? _featureFlag;

  final _loading = false.obs;
  bool get isLoading => _loading.value;

  // Show drawer
  bool get showDrawer => mainScreenAccess == MAIN_SCREEN_ACCESS.NOTICE;

  // MAIN SCREEN ACCESS
  MAIN_SCREEN_ACCESS get mainScreenAccess {
    if (appCloseInfo?.isClosed == true) {
      return MAIN_SCREEN_ACCESS.APP_CLOSED;
    }
    // Email not verified and not plan active
    if (_user != null && _user!.instiEmailVerified != true) {
      return MAIN_SCREEN_ACCESS.HAVE_TO_VERIFY_EMAIL;
    }
    // Email verified and no plan active
    if (_user != null &&
        _user!.instiEmailVerified &&
        _user!.instiEmail != null &&
        ((_user!.planId == null && _plan == null) ||
            (_user!.planId != null &&
                _plan != null &&
                _plan!.isExpired == null))) {
      return MAIN_SCREEN_ACCESS.PURCHASE_PLAN;
    }
    // Email verified and plan active (not expired)
    if (_user != null &&
        _user!.instiEmailVerified &&
        _user!.planId != null &&
        _plan != null &&
        _plan!.isExpired != null &&
        _plan!.isExpired == false) {
      return MAIN_SCREEN_ACCESS.NOTICE;
    }

    // Email verified and plan not active (expired)
    if (_user != null &&
        _user!.instiEmailVerified &&
        _user!.planId != null &&
        _plan != null &&
        _plan!.isExpired != null &&
        _plan!.isExpired == true) {
      return MAIN_SCREEN_ACCESS.PLAN_EXPIRED;
    }

    return MAIN_SCREEN_ACCESS.ERROR;
  }

  // PLAN GETTERS
  Plan? get plan => _plan;

  // FEATURE FLAG GETTERS
  List<String> get allowedDomains => _featureFlag?.allowedEmailDomains ?? [];
  List<NoticeFilter> get filters => _featureFlag?.noticeFilters ?? [];
  String get fileServerUrl => _featureFlag?.fileServerUrl ?? Config.apiUrl;
  AppUpdateAvailable? get appUpdateAvailable =>
      _featureFlag?.appUpdateAvailable;
  AppCloseInfo? get appCloseInfo => _featureFlag?.appCloseInfo;

  // USER GETTERS
  String get displayName => _user?.displayName ?? "User";
  String? get avatarUrl => _user?.avatarUrl;
  bool get isInstiEmailVerified => _user?.instiEmailVerified ?? false;
  bool get isInstiEmailSubmitted => _user?.instiEmail != null;
  String? get instiEmail => _user?.instiEmail;
  String? get email => _user?.email;
  String get userId => _user?.id ?? '';

  Future<void> reset() async {
    _user = null;
    _plan = null;
    _featureFlag = null;
    _loading.value = false;
  }

  Future<void> setupUser() async {
    try {
      _loading.value = true;
      _user = await _userService.getData();
      _plan = await _planService.getMyPlan();
      _featureFlag = await _userService.getFeatureFlags();

      _enablePlacementAlerts.value = _user?.enablePlacementAlerts ?? true;
      _enableInternshipAlerts.value = _user?.enableInternshipAlerts ?? true;

      AnalyticsService().identify(_user!.email);
    } catch (e) {
      print(e);
    } finally {
      _loading.value = false;
    }
  }

  // Notification Settings
  final RxBool _enablePlacementAlerts = (true).obs;
  final RxBool _enableInternshipAlerts = (true).obs;

  final RxBool _updatingSetting = false.obs;

  bool get enablePlacementAlerts => _enablePlacementAlerts.value;
  bool get enableInternshipAlerts => _enableInternshipAlerts.value;
  bool get isUpdatingSetting => _updatingSetting.value;

  set enablePlacementAlerts(bool value) {
    _enablePlacementAlerts.value = value;
    _updateNotificationSettings(null, _enablePlacementAlerts.value);
  }

  set enableInternshipAlerts(bool value) {
    _enableInternshipAlerts.value = value;
    _updateNotificationSettings(_enableInternshipAlerts.value, null);
  }

  Future<void> _updateNotificationSettings(
      bool? intern, bool? placement) async {
    try {
      _updatingSetting.value = true;

      _user = await _userService.updateNotificationSettings(
        enableInternshipNotification: intern,
        enablePlacementNotification: placement,
      );

      if (_user != null) {
        _enablePlacementAlerts.value = _user?.enablePlacementAlerts ?? true;
        _enableInternshipAlerts.value = _user?.enableInternshipAlerts ?? true;
      }
    } catch (e) {
      print(e);
    } finally {
      _updatingSetting.value = false;
    }
  }
}
