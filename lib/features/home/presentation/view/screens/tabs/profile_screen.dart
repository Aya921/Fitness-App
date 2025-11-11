import 'package:fitness/config/di/di.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt.get<ProfileCubit>()..doIntent(GetLoggedUserIntent()),
        child: const ProfileScreenViewBody(),
      ),
    );
  }
}
