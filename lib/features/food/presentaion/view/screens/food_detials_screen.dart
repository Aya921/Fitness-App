// import 'package:fitness/config/di/di.dart';
// import 'package:fitness/core/responsive/size_helper.dart';
// import 'package:fitness/core/widget/home_background.dart';
// import 'package:fitness/features/food/presentaion/view/widgets/food_recommendation_title.dart';
// import 'package:fitness/features/food/presentaion/view_model/food_cubit.dart';
// import 'package:fitness/features/food/presentaion/view_model/food_intent.dart';
// import 'package:fitness/features/food/presentaion/view_model/food_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import '../../../domain/entities/meals_categories.dart';
// import '../widgets/tab_bar_food.dart';
// class FoodDetialsScreen extends StatelessWidget {
//   const FoodDetialsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: HomeBackground(
//         alpha: 0.12,
//         child: SafeArea(
//           child: BlocProvider(
//             create: (context) =>
//                 getIt<FoodCubit>()
//                   ..doIntent(intent: FoodInitializationIntent()),
//             child:
//             Column(
//               children: [
//                 const FoodRecommendationTitle(),
//                  SizedBox(
//                   height: context.setHight(20),
//                 ),
//
//                 BlocBuilder<FoodCubit, FoodStates>(
//                   builder: (context, state) {
//
//                       return Skeletonizer(
//                         enabled:state.mealsCategories.isLoading ||
//                             state.mealsCategories.isInitial ||
//                             state.mealsCategories.isFailure ,
//                         child: TabBarFood(
//
//                           titles: state.mealsCategories.data??_dummyCategories,
//
//                         ),
//                       );
//
//
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// final _dummyCategories = List.generate(
//   8,
//   (i) => const MealCategoryEntity(
//     strCategory: 'Chest',
//     idCategory: '',
//     strCategoryThumb: '',
//     strCategoryDescription: '',
//   ),
// );
