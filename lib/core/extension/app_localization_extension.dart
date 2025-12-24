import 'package:fitness/core/enum/levels.dart';

import '../l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
extension AppLocalizationExtenstion on BuildContext {
  AppLocalizations get loc =>
      AppLocalizations.of(this)!;  // this mean the object after on(Build Context)
}

extension ActivityLevelLocalization on ActivityLevel {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case ActivityLevel.level1:
        return context.loc.rookie;
      case ActivityLevel.level2:
        return context.loc.beginner;
      case ActivityLevel.level3:
        return context.loc.intermediate;
      case ActivityLevel.level4:
        return context.loc.advance;
      case ActivityLevel.level5:
        return context.loc.trueBeast;
    }
  }
}