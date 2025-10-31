// main file
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/routes/routes.dart';
import 'package:fitness/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_language/app_language_config.dart';
import 'config/di/di.dart';
import 'package:device_preview/device_preview.dart';
import 'core/theme/app_theme.dart';
import 'core/user/user_session_handler.dart';
void main() async {
  ///ensure engine is Oky
//  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await getIt.allReady();
  final appLanguageConfig = getIt.get<AppLanguageConfig>();
  await appLanguageConfig.setSelectedLocal();

  final userSession = getIt<UserSessionHandler>();
  final isLoggedIn = await userSession.checkIfUserLoggedIn();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ChangeNotifierProvider.value(
        value: appLanguageConfig, // Use the instance here
        child:  FitnessApp(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}
class FitnessApp extends StatelessWidget {
  final bool isLoggedIn;
  const FitnessApp({required this.isLoggedIn, super.key});
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
        home: const TestScreen(),
       //  initialRoute: AppRoutes.food,
       // initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.onBoarding,
        navigatorKey: Routes.navigatorKey,
      ),
    );
  }
}