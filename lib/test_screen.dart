import 'package:fitness/config/di/di.dart';
import 'package:fitness/features/foods/presentaion/view/screens/food_detials_screen.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/foods/domain/entities/meals_categories.dart';
import 'features/foods/presentaion/view_model/food_states.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
        getIt<FoodCubit>()..doIntent(intent: FoodInitializationIntent()),
        child: BlocBuilder<FoodCubit, FoodStates>(
          builder: (context, state) {
            if (state.mealsCategories.isSuccess) {
              return ListView.builder(
                itemCount: state.mealsCategories.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {



                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<FoodCubit>(),
                            child: FoodDetialsScreen(index: index),
                          ),
                        ),
                      );
                    },
                    child:
                    ListTile(
                      title: Text(
                        state.mealsCategories.data![index].strCategory ,
                      ),
                    ),
                  );
                },
              );
            }

            if (state.mealsCategories.isLoading ||
                state.mealsCategories.isInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(child: Text("No Data Available"));
          },
        ),
      ),
    );
  }
}




final _dummyCategories = List.generate(
  8,
  (i) => const MealCategoryEntity(
    strCategory: 'Chest',
    idCategory: '',
    strCategoryThumb: '',
    strCategoryDescription: '',
  ),
);
