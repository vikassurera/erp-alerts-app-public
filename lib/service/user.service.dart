// API
import 'package:erpalerts/api/api_client.dart';
import 'package:erpalerts/api/endpoints.dart';

// Import Models
import 'package:erpalerts/models/user.model.dart';
import 'package:erpalerts/models/feature_flag.model.dart';

const TAG = '[UserService]';

class UserService {
  final ApiClient _apiClient = ApiClient();

  // Fetch User Data
  Future<User> getData() async {
    final response = await _apiClient.get(Endpoints.me);
    final data = response.data["data"];
    return User.fromJson(data);
  }

  // Update Notification Settings
  Future<User> updateNotificationSettings({
    bool? enablePlacementNotification,
    bool? enableInternshipNotification,
  }) async {
    final response =
        await _apiClient.put(Endpoints.updateNotificationSettings, {
      "enablePlacementNotification": enablePlacementNotification,
      "enableInternshipNotification": enableInternshipNotification,
    });

    final data = response.data["data"];
    return User.fromJson(data);
  }

  // MARK: Email
  Future<void> verifyInstiEmail(String instiEmail) async {
    await _apiClient.post(Endpoints.verifyInstiEmail, {
      "instiEmail": instiEmail,
    });
  }

  // MARK: - Feature Flags
  Future<FeatureFlag> getFeatureFlags() async {
    final response = await _apiClient.get(Endpoints.featureFlags);
    final data = response.data["flag"];

    return FeatureFlag.fromMap(data);
  }
}
