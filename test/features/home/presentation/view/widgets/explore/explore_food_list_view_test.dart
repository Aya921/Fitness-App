import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/foods/domain/entities/meals_categories.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_cubit.dart';
import 'package:fitness/features/foods/presentaion/view_model/food_states.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_food_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'explore_food_list_view_test.mocks.dart';

@GenerateMocks([FoodCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockFoodCubit mockFoodCubit;

  setUp(() {
    mockFoodCubit = MockFoodCubit();

    when(mockFoodCubit.state).thenReturn(
      const FoodStates(
        mealsCategories: StateStatus.success([
          MealCategoryEntity(
            idCategory: '1',
            strCategory: 'Beef',
            strCategoryThumb: 'https://example.com/beef.jpg',
            strCategoryDescription: 'Protein source',
          ),
          MealCategoryEntity(
            idCategory: '2',
            strCategory: 'Chicken',
            strCategoryThumb: 'https://example.com/chicken.jpg',
            strCategoryDescription: 'Lean meat',
          ),
        ]),
      ),
    );

    when(mockFoodCubit.stream).thenAnswer(
      (_) => Stream.value(
        const FoodStates(
          mealsCategories: StateStatus.success([
            MealCategoryEntity(
              idCategory: '1',
              strCategory: 'Beef',
              strCategoryThumb: 'https://example.com/beef.jpg',
              strCategoryDescription: 'Protein source',
            ),
          ]),
        ),
      ),
    );
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<FoodCubit>.value(
        value: mockFoodCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: ExploreFoodListView(),
          ),
        ),
      ),
    );
  }

  testWidgets('verify structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    // Texts
    expect(find.text(l10n.recommendationForYouText), findsOneWidget);
    expect(find.text(l10n.seeAllHomeText), findsOneWidget);

    // Layout
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ExploreFoodListItem), findsNWidgets(1));

    final listView = tester.widget<ListView>(find.byType(ListView));
    expect(listView.scrollDirection, Axis.horizontal);
  });



  testWidgets('verify correct number of items when data is loaded',
      (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(ExploreFoodListItem), findsNWidgets(1));
    expect(find.text('Beef'), findsOneWidget);
  });

  testWidgets('apply proper text and style for title', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final titleFinder = find.text(l10n.recommendationForYouText);
    final titleWidget = tester.widget<Text>(titleFinder);

    expect(titleWidget.style!.color, AppColors.white);
    expect(titleWidget.style!.fontSize, FontSize.s16);
    expect(titleWidget.style!.fontFamily, 'BalooThambi2');
  });

  testWidgets('apply correct underline style for "See All" text',
      (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final seeAllFinder = find.text(l10n.seeAllHomeText);
    final seeAllWidget = tester.widget<Text>(seeAllFinder);

    expect(seeAllWidget.style!.decoration, TextDecoration.underline);
    expect(seeAllWidget.style!.color, AppColors.orange);
  });
}
