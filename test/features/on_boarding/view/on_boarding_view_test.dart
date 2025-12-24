import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/features/on_boarding/presentation/views/on_boarding_view_body.dart';
import 'package:fitness/features/on_boarding/view/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'on_boarding_view_test.mocks.dart';
@GenerateMocks([OnBoardingCubit])
void main(){
TestWidgetsFlutterBinding.ensureInitialized();
  late MockOnBoardingCubit mockCubit;
  setUp((){
    mockCubit = MockOnBoardingCubit();
    getIt.registerFactory<OnBoardingCubit>(() => mockCubit);
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
          child: OnBoardingView(),
        ),
      ),
    );
  }
   testWidgets('verify RegisterScreen Structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();
    expect(find.byType(OnBoardingViewBody), findsOneWidget);
  });
  tearDown(getIt.reset);
}