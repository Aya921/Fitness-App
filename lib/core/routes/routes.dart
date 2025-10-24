import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/views/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/views/screens/compelete_register/complete_register_screen.dart';

abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterCubit>(
            create: (context) => getIt.get<RegisterCubit>()..doIntent(intent: const RegisterInitializationIntent()),
            child: const RegisterScreen(),
          ),
        );
      case AppRoutes.completeRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => const CompeleteRegisterScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center()),
        );
    }
  }
}
