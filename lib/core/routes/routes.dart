import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:flutter/material.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      // case AppRoutes.completeRegisterScreen:
      //   return    MaterialPageRoute(builder: (context)=>
      //   const CompeleteRegisterScreen()
      //   );
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
