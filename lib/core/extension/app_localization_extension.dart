import '../l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
extension AppLocalizationExtenstion on BuildContext {
  AppLocalizations get loc =>
      AppLocalizations.of(this)!;  // this mean the object after on(Build Context)
}