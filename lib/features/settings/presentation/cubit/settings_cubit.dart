import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../services/settings_service.dart';
import '../../../../services/notification_service.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.themeMode,
    required this.languageCode,
    required this.currencyCode,
    required this.notificationsEnabled,
    required this.reminderHour,
    required this.reminderMinute,
  });

  final ThemeMode themeMode;
  final String languageCode;
  final String currencyCode;
  final bool notificationsEnabled;
  final int reminderHour;
  final int reminderMinute;

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    String? currencyCode,
    bool? notificationsEnabled,
    int? reminderHour,
    int? reminderMinute,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      currencyCode: currencyCode ?? this.currencyCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      reminderHour: reminderHour ?? this.reminderHour,
      reminderMinute: reminderMinute ?? this.reminderMinute,
    );
  }

  @override
  List<Object?> get props => [themeMode, languageCode, currencyCode, notificationsEnabled, reminderHour, reminderMinute];
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(
          themeMode: SettingsService.instance.themeMode,
          languageCode: SettingsService.instance.languageCode,
          currencyCode: SettingsService.instance.currencyCode,
          notificationsEnabled: SettingsService.instance.notificationsEnabled,
          reminderHour: SettingsService.instance.reminderHour,
          reminderMinute: SettingsService.instance.reminderMinute,
        ));

  Future<void> setThemeMode(ThemeMode mode) async {
    await SettingsService.instance.setThemeMode(mode);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setLanguageCode(String code) async {
    await SettingsService.instance.setLanguageCode(code);
    emit(state.copyWith(languageCode: code));
  }

  Future<void> setCurrencyCode(String code) async {
    await SettingsService.instance.setCurrencyCode(code);
    emit(state.copyWith(currencyCode: code));
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (enabled) {
      final granted = await NotificationService.instance.requestPermissions();
      if (!granted) return;
      await NotificationService.instance.scheduleDailyReminder(
        TimeOfDay(hour: state.reminderHour, minute: state.reminderMinute),
      );
    } else {
      await NotificationService.instance.cancelReminder();
    }
    await SettingsService.instance.setNotificationsEnabled(enabled);
    emit(state.copyWith(notificationsEnabled: enabled));
  }

  Future<void> setReminderTime(int hour, int minute) async {
    await SettingsService.instance.setReminderTime(hour, minute);
    if (state.notificationsEnabled) {
      await NotificationService.instance.scheduleDailyReminder(TimeOfDay(hour: hour, minute: minute));
    }
    emit(state.copyWith(reminderHour: hour, reminderMinute: minute));
  }
}
