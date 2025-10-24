// main file 
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'config/app_language/app_language_config.dart';
import 'config/di/di.dart';
import 'package:device_preview/device_preview.dart';

import 'core/theme/app_theme.dart';


void main() async {
  ///ensure engine is Oky
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt.allReady(); 
  final appLanguageConfig = getIt.get<AppLanguageConfig>();
  await appLanguageConfig.setSelectedLocal();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ChangeNotifierProvider.value(
        value: appLanguageConfig, // Use the instance here
        child: const FitnessApp(),
      ),
    ),
  );
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appLanguageConfig = Provider.of<AppLanguageConfig>(context);
    return SizeProvider(
        baseSize: const Size(375, 812),
        height: context.screenHight,
        width: context.screenWidth,
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale(appLanguageConfig.selectedLocal),
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.onGenerate,
          navigatorKey: Routes.navigatorKey,
        
        ));
  }
}