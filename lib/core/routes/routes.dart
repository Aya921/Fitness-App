import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/home/presentation/view/screens/home_tab.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context)=>
            const HomeTab());
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
