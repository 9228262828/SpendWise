import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../core/constants/app_constants.dart';

class SettingsService extends ChangeNotifier {
  SettingsService._();

  static final SettingsService _instance = SettingsService._();
  static SettingsService get instance => _instance;

  Box get _box => Hive.box(AppConstants.hiveSettingsBox);

  ThemeMode get themeMode {
    final value = _box.get(AppConstants.settingsThemeKey, defaultValue: 'system');
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    String value;
    switch (mode) {
      case ThemeMode.light:
        value = 'light';
        break;
      case ThemeMode.dark:
        value = 'dark';
        break;
      default:
        value = 'system';
    }
    await _box.put(AppConstants.settingsThemeKey, value);
    notifyListeners();
  }

  String get languageCode =>
      _box.get(AppConstants.settingsLanguageKey, defaultValue: 'en') as String;

  Future<void> setLanguageCode(String code) async {
    await _box.put(AppConstants.settingsLanguageKey, code);
    notifyListeners();
  }

  String get currencyCode =>
      _box.get(AppConstants.settingsCurrencyKey, defaultValue: 'USD') as String;

  Future<void> setCurrencyCode(String code) async {
    await _box.put(AppConstants.settingsCurrencyKey, code);
    notifyListeners();
  }

  bool get notificationsEnabled =>
      _box.get(AppConstants.settingsNotificationsKey, defaultValue: false) as bool;

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _box.put(AppConstants.settingsNotificationsKey, enabled);
    notifyListeners();
  }

  int get reminderHour =>
      _box.get(AppConstants.settingsReminderHourKey, defaultValue: 20) as int;

  int get reminderMinute =>
      _box.get(AppConstants.settingsReminderMinuteKey, defaultValue: 0) as int;

  Future<void> setReminderTime(int hour, int minute) async {
    await _box.put(AppConstants.settingsReminderHourKey, hour);
    await _box.put(AppConstants.settingsReminderMinuteKey, minute);
    notifyListeners();
  }
}
