import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../presentation/cubit/on_boarding_cubit.dart';
import '../presentation/views/on_boarding_view_body.dart';
class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: const OnBoardingViewBody(),
    );
  }
}
