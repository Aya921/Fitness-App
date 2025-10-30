import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/register/register_screen.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockCubit;
  setUp(() {
    mockCubit = MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockCubit);
    provideDummy<RegisterState>(const RegisterState());
    when(mockCubit.state).thenReturn(const RegisterState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));
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
          child: RegisterScreen(),
        ),
      ),
    );
  }

  testWidgets('verify RegisterScreen Structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();
    expect(find.byType(RegisterScreenViewBody), findsOneWidget);
  });
  tearDown(getIt.reset);
}
