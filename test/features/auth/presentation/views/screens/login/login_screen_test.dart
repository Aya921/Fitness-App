import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:fitness/features/auth/presentation/views/screens/login/login_screen.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockLoginCubit;
  final getItInstance = GetIt.instance;

  setUpAll(() {
    provideDummy<LoginState>(const LoginState());
  });

  setUp(() {
    mockLoginCubit = MockLoginCubit();

    when(
      mockLoginCubit.stream,
    ).thenAnswer((_) => const Stream<LoginState>.empty());
    when(mockLoginCubit.state).thenReturn(const LoginState());

    when(mockLoginCubit.emailController).thenReturn(TextEditingController());
    when(mockLoginCubit.passwordController).thenReturn(TextEditingController());

    getItInstance.registerFactory<LoginCubit>(() => mockLoginCubit);
  });

  tearDown(getItInstance.reset);

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<LoginCubit>(
          create: (_) => mockLoginCubit,
          child: const LoginScreen(),
        ),
      ),
    );
  }

  testWidgets('verify login structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(LoginBody), findsOneWidget);
  });
}