import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_form_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockCubit;

  setUp(() {
    mockCubit = MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockCubit);
    provideDummy<RegisterState>(const RegisterState());
    when(mockCubit.state).thenReturn(const RegisterState());
    when(mockCubit.stream)
        .thenAnswer((_) => Stream.fromIterable([const RegisterState()]));
    when(mockCubit.registerFormKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.firstNameController).thenReturn(TextEditingController());
    when(mockCubit.lastNameController).thenReturn(TextEditingController());
    when(mockCubit.emailController).thenReturn(TextEditingController());
    when(mockCubit.passwordController).thenReturn(TextEditingController());
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<RegisterCubit>.value(
        value: mockCubit..doIntent(intent: const RegisterFormIntent()),
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: RegisterScreenForm()),
        ),
      ),
    );
  }

  testWidgets('verify form structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsNWidgets(4));

    expect(find.byKey(const Key('firstNameRegisterForm')), findsOneWidget);
    expect(find.byKey(const Key('LastNameRegisterForm')), findsOneWidget);
    expect(find.byKey(const Key('emailNameRegisterForm')), findsOneWidget);
    expect(find.byKey(const Key('passwordRegisterForm')), findsOneWidget);
  });

  testWidgets('validate empty form shows errors', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    final formWidget = formKey.currentState;

    expect(formWidget, isNotNull);
    formKey.currentState!.validate();

    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.textContaining(l10n.emailRequired), findsAtLeast(1));
    expect(find.textContaining(l10n.passwordRequired), findsAtLeast(1));
    expect(find.textContaining(l10n.usernameRequired), findsAtLeast(1));
    expect(find.textContaining(l10n.usernameRequired), findsAtLeast(1));
  });
testWidgets('invalid email shows error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final emailField = find.byKey(const Key('emailNameRegisterForm'));

    await tester.enterText(emailField, 'invalid-email');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text(l10n.emailNotValid), findsOneWidget);
  });


  testWidgets('password with no uppercase shows uppercase error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final passwordField = find.byKey(const Key('passwordRegisterForm'));

    await tester.enterText(passwordField, 'password123');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text(l10n.passwordUppercase), findsOneWidget);
  });

  testWidgets('password too short shows min length error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final passwordField = find.byKey(const Key('passwordRegisterForm'));

    await tester.enterText(passwordField, 'Ab1');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text(l10n.passwordMinLength), findsOneWidget);
  });

  testWidgets('password with no number shows number error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final passwordField = find.byKey(const Key('passwordRegisterForm'));

    await tester.enterText(passwordField, 'Password');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text(l10n.passwordNumber), findsOneWidget);
  });

  testWidgets('invalid username shows username not valid error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final firstNameField = find.byKey(const Key('firstNameRegisterForm'));

    await tester.enterText(firstNameField, '@@!');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    expect(find.text(l10n.usernameNotValid), findsOneWidget);
  });
  testWidgets('fill valid data to remove error fields', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('firstNameRegisterForm')), 'Omar');
    await tester.enterText(find.byKey(const Key('LastNameRegisterForm')), 'Elsadany');
    await tester.enterText(find.byKey(const Key('emailNameRegisterForm')), 'test@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordRegisterForm')), '12345@Omar');
    await tester.pumpAndSettle();

    final formKey = mockCubit.registerFormKey;
    final isValid = formKey.currentState!.validate();
    expect(isValid, isTrue);
  });

  testWidgets('toggle password visibility triggers intent', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final passwordField = find.byKey(const Key('passwordRegisterForm'));
    final iconButton = find.descendant(
      of: passwordField,
      matching: find.byType(IconButton),
    );

    await tester.tap(iconButton);
    await tester.pump();

    verify(mockCubit.doIntent(intent: const ToggleObscurePasswordIntent()))
        .called(1);
  });

  tearDown(getIt.reset);
}
