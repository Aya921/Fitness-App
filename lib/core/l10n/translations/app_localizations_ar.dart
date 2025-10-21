// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get noRouteFound => 'لا توجد صفحه';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailNotValid => 'البريد الإلكتروني غير صالح';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور على الأقل 6 أحرف';

  @override
  String get passwordUppercase =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordNumber =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get usernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get usernameNotValid => 'الرجاء إدخال اسم مستخدم صالح';

  @override
  String get fullnameRequired => 'الاسم الكامل مطلوب';

  @override
  String get fullnameMinLength =>
      'يجب أن يكون الاسم الكامل مكونًا من 3 أحرف على الأقل';

  @override
  String get phoneRequired => 'رقم الهاتف مطلوب';

  @override
  String get phoneNumbersOnly => 'يُسمح بالأرقام فقط';

  @override
  String get phoneLength => 'يجب أن يكون الرقم 11 رقمًا بعد كود الدولة';

  @override
  String get numberRequired => 'هذا الحقل مطلوب';

  @override
  String get numberOnly => 'يُسمح بالأرقام فقط';
}
