import 'dart:io';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/foods/presentaion/view/screens/food_detials_screen.dart';
import 'package:fitness/features/foods/presentaion/view/widgets/food_detials_body.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

import 'food_detials_screen_test.mocks.dart';
class _FakeHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _FakeHttpClient();
  }
}

class _FakeHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
@GenerateNiceMocks([MockSpec<FoodCubit>()])

void main() {
  late MockFoodCubit mockFoodCubit;



  setUpAll(() {

mockFoodCubit=MockFoodCubit();
    // Mock لأي Network Images
    HttpOverrides.global = _FakeHttpOverrides();
  });

  tearDown(() {
    if (getIt.isRegistered<FoodCubit>()) {
      getIt.unregister<FoodCubit>();
    }
  });
  Widget prepareWidget({required int index}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FoodCubit>.value(
        value: mockFoodCubit,
        child: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: FoodDetialsScreen(index: index),
        ),
      ),
    );
  }


  final fakeSuccessResponse = [
    const MealCategoryEntity(
      idCategory: "1",
      strCategory: "Beef",
      strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
      strCategoryDescription:
      "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]",
    ),
    const MealCategoryEntity(
      idCategory: "2",
      strCategory: "Chicken",
      strCategoryThumb:
      "https://www.themealdb.com/images/category/chicken.png",
      strCategoryDescription:
      "Chicken is a type of domesticated fowl, a subspecies of the red junglefowl. It is one of the most common and widespread domestic animals, with a total population of more than 19 billion as of 2011.[1] Humans commonly keep chickens as a source of food (consuming both their meat and eggs) and, more rarely, as pets.",
    ),
  ];
  final successState = FoodStates(
    mealsCategories: StateStatus.success(fakeSuccessResponse ),
  );
  testWidgets(
      'renders correctly and contains FoodDetialsBody with correct index',
          (WidgetTester tester) async {
        const int testIndex = 1;
        when(mockFoodCubit.state).thenReturn(successState);
        when(mockFoodCubit.stream).thenAnswer((_) => Stream.value(successState));

        await tester.pumpWidget(prepareWidget(index: testIndex));
        await tester.pump();

        expect(find.byType(Scaffold), findsOneWidget);

        expect(find.byType(HomeBackground), findsOneWidget);

        expect(find.byType(SafeArea), findsOneWidget);

        expect(find.byType(FoodDetialsBody), findsOneWidget);

        final bodyWidget = tester.widget<FoodDetialsBody>(
          find.byType(FoodDetialsBody),
        );
        expect(bodyWidget.index, testIndex);
      });
}
