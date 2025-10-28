import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_state.dart';
import 'package:fitness/features/on_boarding/presentation/views/on_boarding_view_body.dart';
import 'package:fitness/features/on_boarding/presentation/widget/on_boarding_bottom_section.dart';
import 'package:fitness/features/on_boarding/presentation/widget/page_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_boarding_view_body_test.mocks.dart';
@GenerateMocks([OnBoardingCubit])
void main(){
TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnBoardingCubit mockCubit;
   late PageController pageController;
  setUp((){
    mockCubit = MockOnBoardingCubit();
    pageController = PageController();
    getIt.registerFactory<OnBoardingCubit>(() => mockCubit);
     provideDummy<OnBoardingState>(const OnBoardingState());
    when(mockCubit.state).thenReturn(const OnBoardingState());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.fromIterable([const OnBoardingState()]));
         when(mockCubit.controller()).thenReturn(pageController);
     when(mockCubit.images).thenReturn([
      AssetsManager.onBoardingOne,
      AssetsManager.onBoardingTwo,
      AssetsManager.onBoardingThree,
    ]);
    when(mockCubit.titles).thenReturn([
      Constants.titleOnBoarding,
      Constants.titleTwoBoarding,
      Constants.titleThreeBoarding,
    ]);
  });

   Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<OnBoardingCubit>.value(
        value: mockCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: OnBoardingViewBody(),
        ),
      ),
    );
  }

  testWidgets('verify OnBoardingViewBody structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(Stack), findsNWidgets(2));
    expect(find.byType(SizedBox), findsAtLeast(1));
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(PageBuilder), findsOneWidget);
    expect(find.byType(Positioned), findsOneWidget);
    expect(find.byType(OnBoardingBottomSection), findsOneWidget);
  });

  testWidgets('verify background image is displayed', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    final images = tester.widgetList<Image>(find.byType(Image));
    final backgroundImage = images.first;
    final assetImage = backgroundImage.image as AssetImage;

    expect(assetImage.assetName, AssetsManager.onBoardingBackGround);
    expect(backgroundImage.fit, BoxFit.cover);
  });
    tearDown(() async {
    await getIt.reset();
  });
}