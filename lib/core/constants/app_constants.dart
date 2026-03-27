class AppConstants {
  AppConstants._();

  static const String appName = 'SpendWise';
  static const String hiveExpensesBox = 'expenses_box';
  static const String hiveCategoriesBox = 'categories_box';
  static const String hiveSettingsBox = 'settings_box';

  static const String settingsThemeKey = 'theme_mode';
  static const String settingsLanguageKey = 'language_code';
  static const String settingsCurrencyKey = 'currency_code';
  static const String settingsNotificationsKey = 'notifications_enabled';
  static const String settingsReminderHourKey = 'reminder_hour';
  static const String settingsReminderMinuteKey = 'reminder_minute';

  static const int notificationChannelId = 1001;
  static const String notificationChannelName = 'SpendWise Reminders';

  static const List<String> supportedLocales = ['en', 'ar'];
  static const List<String> supportedCurrencies = [
    'USD', 'EUR', 'GBP', 'SAR', 'AED', 'EGP', 'KWD', 'QAR', 'BHD', 'OMR',
  ];

  static const Map<String, String> currencySymbols = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'SAR': '﷼',
    'AED': 'د.إ',
    'EGP': '£',
    'KWD': 'K.D',
    'QAR': 'Q.R',
    'BHD': 'B.D',
    'OMR': 'R.O',
  };
}
