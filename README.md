# SpendWise – Expense Tracker

A production-ready Flutter expense tracking app with clean architecture, BLoC state management, and a polished Material 3 UI.

## Features

- **Dashboard** – Monthly totals, daily spending, recent transactions, smart insights
- **Add/Edit Expenses** – Amount, category, date, note with swipe-to-delete
- **Categories** – Full CRUD with custom icons & colors (9 defaults included)
- **Reports** – Weekly bar chart, 6-month line chart, pie chart breakdown
- **Settings** – Dark/Light/System theme, multi-currency (USD/EUR/GBP/SAR/AED/etc.), EN/AR language, daily reminders
- **Export** – CSV export via share sheet
- **Offline-first** – All data stored locally with Hive

## Architecture

```
lib/
├── core/                  # Shared constants, theme, utilities, widgets
├── features/
│   ├── expenses/          # Add, view, search, delete expenses
│   ├── categories/        # Category CRUD
│   └── reports/           # Charts and analytics
├── services/              # Hive, DI, Notifications, Export, Settings
├── l10n/                  # EN + AR localization
└── main.dart
```

Clean Architecture: **Domain → Data → Presentation** per feature  
State: **Flutter BLoC / Cubit**  
Storage: **Hive** (local NoSQL)  
DI: **GetIt**  
Navigation: **GoRouter**  
Charts: **fl_chart**

## Setup

```bash
# 1. Install dependencies
flutter pub get

# 2. Run on device/emulator
flutter run

# 3. Build release AAB (Android)
# First create android/key.properties with your signing config, then:
flutter build appbundle --release
```

## Google Play Requirements

- `minSdkVersion 21` (Android 5.0+)
- `targetSdk` follows Flutter's default (latest stable)
- `applicationId: com.spendwise.app`
- Permissions: POST_NOTIFICATIONS (optional, requested at runtime only when user enables reminders)
- No internet permission required (fully offline)

## Release Signing

Create `android/key.properties`:
```
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-your-keystore>
```

Then build:
```bash
flutter build appbundle --release
```
