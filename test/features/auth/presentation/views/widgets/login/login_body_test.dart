import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_body.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/login_form_fields.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/register_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'login_body_test.mocks.dart';

@GenerateMocks([LoginCubit])
void main() {
  late MockLoginCubit mockLoginCubit;

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
            child: LoginBody(cubit: cubit ?? mockLoginCubit),
          ),
        ),
      ),
    );
  }

  group('LoginBody Widget Tests', () {
    testWidgets('verify login body structure and key widgets', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key(WidgetKey.loginBodyScrollKey)),
        findsOneWidget,
      );
      expect(find.byKey(const Key(WidgetKey.logoKey)), findsOneWidget);
      expect(find.byKey(const Key(WidgetKey.loginHeaderKey)), findsOneWidget);
      expect(find.byType(BlurContainer), findsOneWidget);
      expect(
        find.byKey(const Key(WidgetKey.forgetPasswordKey)),
        findsOneWidget,
      );
      expect(find.byType(Logo), findsOneWidget);
      expect(find.byType(LoginFormFields), findsOneWidget);
      expect(find.byType(SocialSection), findsOneWidget);
      expect(find.byType(CustumFieldsButton), findsOneWidget);
      expect(find.byType(RegisterText), findsOneWidget);
    });

    testWidgets('verify login button calls cubit when pressed', (tester) async {
      when(mockLoginCubit.state).thenReturn(const LoginState());

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const Key(WidgetKey.loginButtonKey));
      expect(loginButton, findsOneWidget);

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      verify(mockLoginCubit.doIntent(intent: anyNamed('intent'))).called(1);
    });

    testWidgets('verify forget password is tappable', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final forgetPasswordWidget = find.byKey(
        const Key(WidgetKey.forgetPasswordKey),
      );
      expect(forgetPasswordWidget, findsOneWidget);

      await tester.tap(forgetPasswordWidget);
      await tester.pumpAndSettle();

      expect(forgetPasswordWidget, findsOneWidget);
    });

    testWidgets('verify loading state shows loading indicator', (tester) async {
      when(mockLoginCubit.stream).thenAnswer(
        (_) =>
            Stream.value(const LoginState(loginStatus: StateStatus.loading())),
      );
      when(
        mockLoginCubit.state,
      ).thenReturn(const LoginState(loginStatus: StateStatus.loading()));

      await tester.pumpWidget(prepareWidget());
      await tester.pump();
      await tester.pump();

      expect(find.byType(LoadingCircle), findsOneWidget);
    });

    testWidgets('verify success state shows snackbar', (tester) async {
        const fakeUser= AuthEntity(
         user: UserEntity(
           goal: "",
           activityLevel: ""
         )
        );
      when(mockLoginCubit.stream).thenAnswer(
            (_) => Stream.value(
          const LoginState(
            loginStatus: StateStatus.success(fakeUser),
          ),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SnackBar), findsWidgets);
    });

    testWidgets('verify failure state shows error snackbar', (tester) async {
      when(mockLoginCubit.stream).thenAnswer(
        (_) => Stream.value(
          const LoginState(
            loginStatus: StateStatus.failure(
              ResponseException(message: 'Invalid credentials'),
            ),
          ),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pump();
      await tester.pump();
      await tester.pump(
        const Duration(milliseconds: 100),
      );

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
    //
    testWidgets('verify login button is disabled when form is invalid', (tester) async {
      when(mockLoginCubit.state).thenReturn(
        const LoginState(isPasswordValid: false,isEmailValid: false),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final loginButton = find.byKey(const Key(WidgetKey.loginButtonKey));
      expect(loginButton, findsOneWidget);

      final button = tester.widget<CustumFieldsButton>(loginButton);
      expect(button.valueNotify.value, false);
    });

    testWidgets('verify scrolling works in login body', (tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final scrollable = find.byKey(const Key(WidgetKey.loginBodyScrollKey));
      expect(scrollable, findsOneWidget);

      final scrollableWidget = tester.widget<SingleChildScrollView>(scrollable);
      expect(scrollableWidget.controller, isNull);

      await tester.drag(scrollable, const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(scrollable, findsOneWidget);
    });

  });
}
