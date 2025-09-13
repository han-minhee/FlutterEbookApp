import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._privateConstructor();

  factory LocalStorage() {
    return _instance;
  }

  SharedPreferences? _prefs;

  LocalStorage._privateConstructor();

  static Future<void> warmUp() async {
    await _instance._init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences? getSharedPreferences() {
    return _prefs;
  }
}
