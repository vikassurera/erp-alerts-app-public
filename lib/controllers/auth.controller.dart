import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Config
import 'package:erpalerts/config/prod.config.dart';

// Services
import 'package:erpalerts/service/auth.service.dart';
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/notice.controller.dart';
import 'package:erpalerts/controllers/updates.controller.dart';
import 'package:erpalerts/controllers/user.controller.dart';

class AuthController extends GetxController {
  final _authService = AuthService();

  final _loggedIn = false.obs;
  final _loading = true.obs;
  final _loggingIn = false.obs;

  bool get loggedIn => _loggedIn.value;
  bool get loading => _loading.value;
  bool get loggingIn => _loggingIn.value;

  void verifyUserLogin() async {
    _setLoading(true);

    try {
      await _authService.init();
      await _authService.verify();

      _loggedIn.value = true;

      // Mix Panel
      await AnalyticsService().initMixpanel();
    } catch (error) {
      print(error);
    } finally {
      _setLoading(false);
    }
  }

  void continueWithGoogle() async {
    _loggingIn.value = true;

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
        clientId: Config.googleClientID,
      );

      final result = await _googleSignIn.signIn();
      if (result == null) {
        throw Exception('Google Sign In Failed');
      }
      final userData = await result.authentication;
      await _authService.continueWithGoogle(userData);

      await _authService.verify();

      _googleSignIn.disconnect();
      _loggedIn.value = true;

      // Mix Panel
      await AnalyticsService().initMixpanel();
    } catch (error) {
      print(error);
    } finally {
      _loggingIn.value = false;
    }
  }

  void reset() {
    _loggedIn.value = false;
    _loading.value = false;
    _loggingIn.value = false;

    // Reset all controllers
    Get.find<UserController>().reset();
    Get.find<NoticeController>().reset();
    Get.find<UpdatesController>().reset();
  }

  void _setLoading(bool value) {
    _loading.value = value;
  }

  void logout() async {
    AnalyticsService().reset();
    _setLoading(true);

    try {
      // await GoogleSignIn().disconnect();
      await _authService.logout();

      // remove the device token
      Get.find<UserController>().reset();

      // clear the shared preferences
      (await SharedPreferences.getInstance()).clear();

      _loggedIn.value = false;
    } catch (error) {
      print(error);
    } finally {
      _setLoading(false);
    }
  }
}
