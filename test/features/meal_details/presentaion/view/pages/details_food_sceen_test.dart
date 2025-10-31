import 'dart:io';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/core/widget/small_image_widgets/small_image.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_entity.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_info.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_media.dart';
import 'package:fitness/features/meal_details/domain/entity/details_food/meal_response.dart';
import 'package:fitness/features/meal_details/presentaion/view/pages/details_food_sceen.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/details_food_recommendation.dart';
import 'package:fitness/features/meal_details/presentaion/view/widgets/details_food/ingredients_section.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_cubit.dart';
import 'package:fitness/features/meal_details/presentaion/view_model/details_food_view_model/details_food_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'details_food_sceen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DetailsFoodCubit>()])
late MockDetailsFoodCubit mockDetailsFoodCubit;
late DetailsFoodCubit detailsFoodCubit;
void main() {
  late MockDetailsFoodCubit mockDetailsFoodCubit;

  setUpAll(() {
    HttpOverrides.global = null;
    mockDetailsFoodCubit = MockDetailsFoodCubit();


    if (!getIt.isRegistered<DetailsFoodCubit>()) {
      getIt.registerLazySingleton<DetailsFoodCubit>(
        () => mockDetailsFoodCubit,
      );
    }
  });

  testWidgets('test DetailsFoodScreen structure when state is success ...', (tester) async {
    final mealResponse = MealResponseEntity(
      meal: [
        MealEntity(
          strMeal: 'Pizza',
          strInstructions: 'Bake it',
          media: MealMedia(
            strMealThumb: 'https://www.themealdb.com/images/media/meals/uvuyxu1503067369.jpg',
            strYoutube: 'https://www.youtube.com/watch?v=N4EdUt0Ou48',
            strImageSource: '',
          ),
          info: MealInfo(
            strTags: ['Italian, FastFood'],
            strMealAlternate: '',
            strCategory: '',
            strArea: '',
            dateModified: '',
            strSource: '',
            strCreativeCommonsConfirmed: '',
          ),
          ingredients: ['Cheese', 'Tomato'],
          measures: ['100g', '50g'],
          idMeal: '',
        ),
      ],
    );

    final successState = DetailsFoodState(
      detailsFoodState: StateStatus<MealResponseEntity>.success(mealResponse),
    );


    when(mockDetailsFoodCubit.state).thenReturn(successState);
    when(mockDetailsFoodCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: BlocProvider<DetailsFoodCubit>.value(
            value: mockDetailsFoodCubit,
            child: const DetailsFoodScreen(mealId: ""),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();



    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(SmallImage), findsAtLeastNWidgets(1));
    expect(find.byType(IngredientsSection), findsOneWidget);
    expect(find.byType(DetailsFoodRecommendation), findsOneWidget);
   
  });

  testWidgets('test DetailsFoodScreen structure when state is failed ...', (tester) async {
  
    const failedState = DetailsFoodState(
      detailsFoodState: StateStatus<MealResponseEntity>.failure
      (ResponseException(message: "error")),
    );


    when(mockDetailsFoodCubit.state).thenReturn(failedState);
    when(mockDetailsFoodCubit.stream).thenAnswer((_) => Stream.value(failedState));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: BlocProvider<DetailsFoodCubit>.value(
            value: mockDetailsFoodCubit,
            child: const DetailsFoodScreen(mealId: ""),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();



    expect(find.text("error"), findsOneWidget);
   
   
  });

  testWidgets('test DetailsFoodScreen structure when state is loading ...', (tester) async {
   
    const loadingState = DetailsFoodState(
      detailsFoodState: StateStatus<MealResponseEntity>.loading(),
    );


    when(mockDetailsFoodCubit.state).thenReturn(loadingState);
    when(mockDetailsFoodCubit.stream).thenAnswer((_) => Stream.value(loadingState));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: BlocProvider<DetailsFoodCubit>.value(
            value: mockDetailsFoodCubit,
            child: const DetailsFoodScreen(mealId: ""),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(Center), findsAtLeast(1));
    expect(find.byType(LoadingCircle), findsAtLeast(1));
   
   
  });
  testWidgets('test DetailsFoodScreen structure when state is initial ...', (tester) async {
   
    const initialState = DetailsFoodState(
      detailsFoodState: StateStatus<MealResponseEntity>.initial(),
    );


    when(mockDetailsFoodCubit.state).thenReturn(initialState);
    when(mockDetailsFoodCubit.stream).thenAnswer((_) => Stream.value(initialState));

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: BlocProvider<DetailsFoodCubit>.value(
            value: mockDetailsFoodCubit,
            child: const DetailsFoodScreen(mealId: ""),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(SizedBox), findsAtLeast(1));

   
   
  });


}
