import 'package:flutter/foundation.dart';

class Config {
  static const bool isProd = kDebugMode ? false : true;

  static const String razorpayApiKey = '<variable:razorpay-api-key>';
  static const String mixPanelKey = '<variable:mixpanel-key>';
  static String googleClientID = '<variable:google-client-id>';

  static const String testLoginEmail = '<variable:test-login-email>';
  static const String testLoginPass = '<variable:test-login-pass>';

  static const String supportEmail = '<variable:support-email>';
  static const String websiteUrl = '<variable:website-url>';
  static const String websiteDomain = '<variable:website-domain>';

  static const String apiUrl = '<variable:api-url>';
}
