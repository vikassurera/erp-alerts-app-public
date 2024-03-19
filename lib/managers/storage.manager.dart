import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const REFRESH_TOKEN = 'REFRESH_TOKEN';
  static const TOKEN = 'TOKEN';

  static final StorageManager _instance = StorageManager._internal();
  late SharedPreferences _preferences;

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // MARK: Methods for storing and getting data
  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }
}
