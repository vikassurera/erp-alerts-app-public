class AppFlags {
  static const String enableKey = "enabled";
  static const String loginKey = "login";
  static const String purchaseKey = "purchase";
  static const String signupKey = "signup";
  static const String messageKye = "message";
  static const String titleKey = "title";

  AppFlags({
    required this.enabled,
    required this.login,
    required this.purchase,
    required this.signup,
    required this.message,
    required this.title,
  });

  final bool enabled;
  final bool login;
  final bool purchase;
  final bool signup;
  final String message;
  final String title;

  factory AppFlags.fromMap(Map<String, dynamic> json) => AppFlags(
        enabled: json[AppFlags.enableKey],
        login: json[AppFlags.loginKey],
        purchase: json[AppFlags.purchaseKey],
        signup: json[AppFlags.signupKey],
        message: json[AppFlags.messageKye],
        title: json[AppFlags.titleKey],
      );
}
