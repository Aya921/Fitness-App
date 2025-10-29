import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:fitness/features/on_boarding/presentation/widget/page_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'page_builder_test.mocks.dart';

@GenerateMocks([OnBoardingCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnBoardingCubit mockCubit;
  late PageController mockPageController;

  final testImages = [
    AssetsManager.onBoardingOne,
    AssetsManager.onBoardingTwo,
    AssetsManager.onBoardingThree,
  ];

  setUp(() {
    mockCubit = MockOnBoardingCubit();
    mockPageController = PageController();
    getIt.registerFactory<OnBoardingCubit>(() => mockCubit);

    provideDummy<OnBoardingState>(const OnBoardingState());
    when(mockCubit.state).thenReturn(const OnBoardingState());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.fromIterable([const OnBoardingState()]));
    when(mockCubit.controller()).thenReturn(mockPageController);
    when(mockCubit.images).thenReturn(testImages);
  });

  Widget prepareWidget({required List<String> images}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OnBoardingCubit>.value(
        value: mockCubit,
        child: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: PageBuilder(images: images),
          ),
        ),
      ),
    );
  }

  testWidgets('verify PageBuilder structure', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsAtLeast(1));
    expect(find.byType(Expanded), findsNWidgets(2));
    expect(find.byType(PageView), findsOneWidget);
  });

  testWidgets('verify Column has children', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    final column = tester.widget<Column>(find.byType(Column));

    expect(column.children.length, 3);
    expect(column.children[0], isA<SizedBox>());
    expect(column.children[1], isA<Expanded>());
    expect(column.children[2], isA<Expanded>());
  });

  testWidgets('verify first SizedBox has correct height', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(PageBuilder));
    final column = tester.widget<Column>(find.byType(Column));
    final firstSizedBox = column.children[0] as SizedBox;

    expect(firstSizedBox.height, context.setHight(20));
  });

  testWidgets('verify first Expanded has flex 11', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    final expandedWidgets = tester.widgetList<Expanded>(find.byType(Expanded));
    final firstExpanded = expandedWidgets.first;

    expect(firstExpanded.flex, 11);
  });

  testWidgets('verify second Expanded has flex 3', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    final expandedWidgets = tester.widgetList<Expanded>(find.byType(Expanded));
    final secondExpanded = expandedWidgets.last;

    expect(secondExpanded.flex, 3);
  });

  testWidgets('verify PageView has image', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsNWidgets(1));
  });

  testWidgets('verify Image has correct properties', (tester) async {
    await tester.pumpWidget(prepareWidget(images: testImages));
    await tester.pumpAndSettle();

    final image = tester.widget<Image>(find.byType(Image));

    expect(image.fit, BoxFit.cover);
    expect(image.width, double.infinity);
    expect(image.height, double.infinity);
  });
  tearDown(() async {
    mockPageController.dispose();
    await getIt.reset();
  });
}