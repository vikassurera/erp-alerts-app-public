import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

// API
import 'package:erpalerts/api/api_client.dart';
import 'package:erpalerts/api/endpoints.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<void> init() async {
    await _apiClient.init();
  }

  Future<void> verify() async {
    final token = await FirebaseMessaging.instance.getToken();

    await _apiClient.post(Endpoints.verify, {
      'fcmToken': token,
    });
  }

  Future<void> continueWithGoogle(
      GoogleSignInAuthentication authentication) async {
    final body = {
      'credential': authentication.idToken,
    };

    await _apiClient.post(Endpoints.continueWithGoogle, body);
  }

  Future<void> logout() async {
    await _apiClient.post(Endpoints.logout, {});
    _apiClient.clear();
  }
}
