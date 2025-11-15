import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_form_fields_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockLoginCubit;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  setUpAll(() {
    provideDummy<LoginState>(const LoginState());
  });

  setUp(() {
    mockLoginCubit = MockLoginCubit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    when(mockLoginCubit.stream)
        .thenAnswer((_) => const Stream<LoginState>.empty());
    when(mockLoginCubit.state).thenReturn(const LoginState());
    when(mockLoginCubit.emailController).thenReturn(emailController);
    when(mockLoginCubit.passwordController).thenReturn(passwordController);
  });

  tearDown(() {
    emailController.dispose();
    passwordController.dispose();
  });

  Widget prepareWidget({LoginCubit? cubit}) {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: BlocProvider<LoginCubit>(
            create: (_) => cubit ?? mockLoginCubit,
            child: LoginFormFields(cubit: cubit ?? mockLoginCubit),
          ),
        ),
      ),
    );
  }

  group('LoginFormFields Widget Tests', () {
    testWidgets('verify form fields structure', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('verify email field is present correctly',
            (tester) async {
          await tester.pumpWidget(prepareWidget());
          await tester.pumpAndSettle();

          final emailField = find.byWidgetPredicate(
                (widget) =>
            widget is CustomTextField && widget.icon == AssetsManeger.mail,
          );

          expect(emailField, findsOneWidget);

          final emailWidget = tester.widget<CustomTextField>(emailField);
          expect(emailWidget.controller, equals(emailController));
          expect(emailWidget.isPassword, false);
        });

    testWidgets('verify password field is present and configured correctly',
            (tester) async {
          await tester.pumpWidget(prepareWidget());
          await tester.pumpAndSettle();

          final passwordField = find.byWidgetPredicate(
                (widget) =>
            widget is CustomTextField && widget.icon == AssetsManeger.lock,
          );

          expect(passwordField, findsOneWidget);

          final passwordWidget = tester.widget<CustomTextField>(passwordField);
          expect(passwordWidget.controller, equals(passwordController));
          expect(passwordWidget.isPassword, true);
        });

    testWidgets('verify email field calls cubit on text change',
            (tester) async {
          await tester.pumpWidget(prepareWidget());
          await tester.pumpAndSettle();

          // Find email field
          final emailField = find.byWidgetPredicate(
                (widget) =>
            widget is CustomTextField && widget.icon == AssetsManeger.mail,
          );

          // Enter text in email field
          await tester.enterText(emailField, 'test@example.com');
          await tester.pumpAndSettle();

          // Verify cubit's doIntent was called with UpdateEmailIntent
          verify(mockLoginCubit.doIntent(intent: anyNamed('intent'))).called(1);
        });

    testWidgets('verify password field calls cubit on text change',
            (tester) async {
          await tester.pumpWidget(prepareWidget());
          await tester.pumpAndSettle();

          // Find password field
          final passwordField = find.byWidgetPredicate(
                (widget) =>
            widget is CustomTextField && widget.icon == AssetsManeger.lock,
          );

          // Enter text in password field
          await tester.enterText(passwordField, 'Password123!');
          await tester.pumpAndSettle();

          // Verify cubit's doIntent was called with UpdatePasswordIntent
          verify(mockLoginCubit.doIntent(intent: anyNamed('intent'))).called(1);
        });

    testWidgets('verify email validation is triggered', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final emailField = find.byWidgetPredicate(
            (widget) =>
        widget is CustomTextField && widget.icon == AssetsManeger.mail,
      );

      final emailWidget = tester.widget<CustomTextField>(emailField);

      // Test validator with invalid email
      final invalidResult = emailWidget.validator!('invalid-email');
      expect(invalidResult, isNotNull); // Should return error message

      // Test validator with valid email
      final validResult = emailWidget.validator!('test@example.com');
      expect(validResult, isNull); // Should return null for valid email
    });

    testWidgets('verify password validation is triggered', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final passwordField = find.byWidgetPredicate(
            (widget) =>
        widget is CustomTextField && widget.icon == AssetsManeger.lock,
      );

      final passwordWidget = tester.widget<CustomTextField>(passwordField);

      // Test validator with invalid password
      final invalidResult = passwordWidget.validator!('123');
      expect(invalidResult, isNotNull); // Should return error message

      // Test validator with valid password
      final validResult = passwordWidget.validator!('Password123!');
      expect(validResult, isNull); // Should return null for valid password
    });

    testWidgets('verify fields are correctly ordered', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final textFields = tester.widgetList<CustomTextField>(
        find.byType(CustomTextField),
      );

      final fieldsList = textFields.toList();

      // Verify email field is first
      expect(fieldsList[0].icon, equals(AssetsManeger.mail));

      // Verify password field is second
      expect(fieldsList[1].icon, equals(AssetsManeger.lock));
    });

    testWidgets('verify controllers are connected to fields', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final emailField = find.byWidgetPredicate(
            (widget) =>
        widget is CustomTextField && widget.icon == AssetsManeger.mail,
      );

      // Enter text in email field
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();

      // Verify controller has the text
      expect(emailController.text, equals('test@example.com'));

      // Find password field
      final passwordField = find.byWidgetPredicate(
            (widget) =>
        widget is CustomTextField && widget.icon == AssetsManeger.lock,
      );

      // Enter text in password field
      await tester.enterText(passwordField, 'Password123!');
      await tester.pumpAndSettle();

      // Verify controller has the text
      expect(passwordController.text, equals('Password123!'));
    });

  });
}