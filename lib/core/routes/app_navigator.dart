import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/auth/presentation/views/screens/register/register_screen.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/complete_register_screen.dart';

class AppNavigator {
  //iOS-style navigation (Cupertino)
  static void pushCupertino(BuildContext context, String routeName, {Object? arguments}) {
    final Widget targetWidget = _getTargetWidget(routeName);

    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: routeName, arguments: arguments),
        fullscreenDialog: false,
        builder: (_) => targetWidget,
      ),
    );
  }

  //Custom slide transition (cross-platform)
  static void pushSlide(BuildContext context, String routeName, {Object? arguments}) {
    final Widget targetWidget = _getTargetWidget(routeName);

    Navigator.of(context).push(
      PageRouteBuilder(
        settings: RouteSettings(name: routeName, arguments: arguments),
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => targetWidget,
        transitionsBuilder: (_, animation, __, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  static Widget _getTargetWidget(String routeName) {
    switch (routeName) {
      case AppRoutes.registerScreen:
        return const RegisterScreen();
      case AppRoutes.completeRegisterScreen:
        return const CompeleteRegisterScreen();
      default:
        return const Scaffold(
          body: Center(
            child: Text('Route not found'),
          ),
        );
    }
  }
}
