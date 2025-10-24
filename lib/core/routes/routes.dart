import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/auth/presentation/views/screens/create_password_screen.dart';
import 'package:fitness/features/auth/presentation/views/screens/otp_screen.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case AppRoutes.otpScreen:
      final email=setting.arguments as String;
        return MaterialPageRoute(
          
          builder: (context) {
            return  OtpScreen(userEmail:email ,);
          },
        );
      case AppRoutes.resetPass:
      final email=setting.arguments as String;
        return MaterialPageRoute(
          
          builder: (context) {
            return  CreatePasswordScreen(email: email,);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(child: Text(context.loc.noRouteFound)),
            );
          },
        );
    }
  }
}
