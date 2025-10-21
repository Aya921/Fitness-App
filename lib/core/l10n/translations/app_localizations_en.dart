// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get noRouteFound => 'No Route Found';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailNotValid => 'This email is not valid';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordUppercase =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordNumber => 'Password must contain at least one number';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get usernameNotValid => 'Enter a valid username';

  @override
  String get fullnameRequired => 'Full name is required';

  @override
  String get fullnameMinLength =>
      'Full name must be at least 3 characters long';

  @override
  String get phoneRequired => 'Phone number is required';

  @override
  String get phoneNumbersOnly => 'Enter numbers only';

  @override
  String get phoneLength => 'Value must be 11 digits after country code';

  @override
  String get numberRequired => 'This field is required';

  @override
  String get numberOnly => 'Enter numbers only';
}
