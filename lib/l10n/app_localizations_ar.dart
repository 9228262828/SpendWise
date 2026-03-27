// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سبند وايز';

  @override
  String get home => 'الرئيسية';

  @override
  String get expenses => 'المصروفات';

  @override
  String get categories => 'الفئات';

  @override
  String get reports => 'التقارير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get addExpense => 'إضافة مصروف';

  @override
  String get editExpense => 'تعديل المصروف';

  @override
  String get deleteExpense => 'حذف المصروف';

  @override
  String get amount => 'المبلغ';

  @override
  String get category => 'الفئة';

  @override
  String get date => 'التاريخ';

  @override
  String get note => 'ملاحظة';

  @override
  String get optional => 'اختياري';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get totalToday => 'اليوم';

  @override
  String get totalThisMonth => 'هذا الشهر';

  @override
  String get recentTransactions => 'آخر المعاملات';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get noExpenses => 'لا توجد مصروفات';

  @override
  String get noExpensesSubtitle => 'اضغط على زر + لإضافة أول مصروف';

  @override
  String get noCategories => 'لا توجد فئات';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get monthly => 'شهري';

  @override
  String get totalExpenses => 'إجمالي المصروفات';

  @override
  String get transactions => 'المعاملات';

  @override
  String get average => 'المتوسط';

  @override
  String get byCategory => 'حسب الفئة';

  @override
  String get trend => 'الاتجاه';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get language => 'اللغة';

  @override
  String get currency => 'العملة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get reminderTime => 'وقت التذكير';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get exportCSV => 'تصدير كـ CSV';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get deleteConfirmTitle => 'حذف المصروف';

  @override
  String get deleteConfirmMessage => 'هل أنت متأكد من حذف هذا المصروف؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get deleteCategoryConfirmMessage => 'هل أنت متأكد من حذف هذه الفئة؟';

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get search => 'البحث في المصروفات...';

  @override
  String get addCategory => 'إضافة فئة';

  @override
  String get categoryName => 'اسم الفئة';

  @override
  String get selectIcon => 'اختر الأيقونة';

  @override
  String get selectColor => 'اختر اللون';

  @override
  String insightHighestSpend(String category) {
    return 'أعلى إنفاق: $category';
  }

  @override
  String insightDailyAverage(String amount) {
    return 'المتوسط اليومي: $amount';
  }

  @override
  String get appearance => 'المظهر';

  @override
  String get general => 'عام';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get notificationsDesc => 'احصل على تذكيرات يومية لتسجيل مصروفاتك';

  @override
  String get exportDesc => 'تصدير بيانات مصروفاتك إلى CSV';

  @override
  String get version => 'الإصدار';

  @override
  String get about => 'حول سبند وايز';

  @override
  String get spendingInsights => 'رؤى الإنفاق';

  @override
  String todaySpend(String amount) {
    return 'أنفقت $amount اليوم';
  }
}
