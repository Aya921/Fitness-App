import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/auth/presentation/views/screens/register/register_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/screens/compelete_register/register_screen.dart';

abstract class Routes{
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting){
    final url=Uri.parse(setting.name??"");
    switch(url.path){
      case AppRoutes.completeRegisterScreen:
        return    MaterialPageRoute(builder: (context)=>
        const CompeleteRegisterScreen()
        );
      case AppRoutes.registerScreen:
        return    MaterialPageRoute(builder: (context)=>
        const RegisterScreen(

        )
        );
      default:
        return MaterialPageRoute(builder:
            (_)=>const Scaffold(
          body:  Center(

          ),
        ));
    }
  }
}