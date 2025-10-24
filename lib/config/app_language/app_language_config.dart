import 'package:injectable/injectable.dart';

import '../../core/constants/app_widgets_key.dart';
import '../../core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
@singleton

class AppLanguageConfig extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  AppLanguageConfig({required this.sharedPreferences});
  String selectedLocal = Constants.enLocal;

  bool isEn() => selectedLocal == Constants.enLocal;
  @preResolve
  Future<void> setSelectedLocal()async {
    final  currentLocal = sharedPreferences.getString(
      WidgetKey.sharedPrefrenceKeyLanguage,
    );
    selectedLocal = currentLocal??Constants.enLocal;
  }

  @preResolve

  Future<void> changeLocal(String currentLocal) async {
    if (selectedLocal == currentLocal) return;

    selectedLocal = currentLocal;
    sharedPreferences.setString(
      WidgetKey.sharedPrefrenceKeyLanguage,
      selectedLocal,
    );
    notifyListeners();
  }
}