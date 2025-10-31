import 'package:fitness/config/di/di.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_intent.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     
      providers: [
        BlocProvider(create: (context) => getIt.get<ExploreCubit>()..doIntent(intent:GetHomeData()),),
          BlocProvider(create: (context) => getIt.get<FoodCubit>()..doIntent(intent:FoodInitializationIntent()),)
      ],
      child: const Scaffold(body: ExploreScreenViewBody()),
    );
  }
}
