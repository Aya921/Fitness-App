import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_button_test.mocks.dart';

@GenerateMocks([RegisterCubit,NavigatorObserver])
void main(){
TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockCubit;
  late MockNavigatorObserver mockNavigatorObserver;
  setUp((){
    mockCubit =MockRegisterCubit();
     mockNavigatorObserver = MockNavigatorObserver();
    getIt.registerFactory<RegisterCubit>(() => mockCubit);
    provideDummy<RegisterState>(const RegisterState());
     when(mockCubit.state).thenReturn(const RegisterState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));

  });

    Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<RegisterCubit>.value(
        value: mockCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: RegisterScreenButton()),
        ),
      ),
    );
  }

  

  testWidgets('verify RegisterScreenButton structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(CustomElevatedButton), findsOneWidget);
    
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.register), findsOneWidget);
  });

  testWidgets('button is disabled when isTyping is false', (tester) async {
    when(mockCubit.state).thenReturn(const RegisterState(isTyping: false));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const RegisterState(isTyping: false)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<CustomElevatedButton>(
      find.byType(CustomElevatedButton),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('button is enabled when isTyping is true', (tester) async {
    when(mockCubit.state).thenReturn(const RegisterState(isTyping: true));
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([const RegisterState(isTyping: true)]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final button = tester.widget<CustomElevatedButton>(
      find.byType(CustomElevatedButton),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('tapping button triggers ValidateBasicInfoIntent', (tester) async {
    when(mockCubit.state).thenReturn(
      const RegisterState(isTyping: true, isBasicInfoValid: false),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(isTyping: true, isBasicInfoValid: false),
      ]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pump();

    verify(mockCubit.doIntent(intent: const ValidateBasicInfoIntent()))
        .called(1);
  });
  
   testWidgets('does not navigate when isBasicInfoValid is false',
      (tester) async {
    when(mockCubit.state).thenReturn(
      const RegisterState(isTyping: true, isBasicInfoValid: false),
    );
    when(mockCubit.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const RegisterState(isTyping: true, isBasicInfoValid: false),
      ]),
    );

    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pump();

    verifyNever(mockNavigatorObserver.didPush(any, any));
    expect(find.byType(RegisterScreenButton), findsOneWidget);
  });
  tearDown(getIt.reset);
}