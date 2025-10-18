import 'package:fitness/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

abstract class Routes{
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting){
    final url=Uri.parse(setting.name??"");
    switch(url.path){
      case AppRoutes.registerScreen:
      default:
        return MaterialPageRoute(builder: (_)=>Scaffold(
          body: Center(

          ),
        ));
    }
  }
}