import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  static SharedData? _instance;
  final SharedPreferences _prefs;

  SharedData._(this._prefs);

  ///Initial shared preferences
  static Future<void> init() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = SharedData._(prefs);
    }
  }

  static SharedData get instance {
    if (_instance == null) {
      throw Exception(
          'SharedData not initialized. Call SharedData.init() first.');
    }
    return _instance!;
  }

  ///set bool value

  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  ///get bool value
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
