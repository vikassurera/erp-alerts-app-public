class Endpoints {
  // Auth
  static const String refreshToken = '/user/auth/refresh';
  static const String verify = '/user/auth/verify';
  static const String logout = '/user/auth/logout';
  static const String continueWithGoogle = '/user/auth/continue';

  // User
  static const String me = '/user/me';
  static const String updateNotificationSettings = '/user/notification';

  // Plan
  static const String myPlan = '/user/plan/myplan';
  static const String createPlan = '/user/plan/';
  static const String fetchPlans = '/user/plan/';
  static String getPlanRoute(String id) => '/user/plan/${id}';

  // Feature Flags
  static const String featureFlags = '/user/flags';

  // Pricing
  static const String getPricings = '/user/pricing';
  static String getPricingRoute(String id) => '/user/pricing/${id}';

  // Email
  static const String verifyInstiEmail = '/user/email';

  // Notice
  static const String getNotices = '/user/notice';
  static String getNotice(String id) => '/user/notice/$id';

  // App Updates
  static const String getUpdates = '/user/update/';
}
