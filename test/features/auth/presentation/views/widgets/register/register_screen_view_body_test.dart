import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_already_have_an_account.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_button.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_form.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_or_row.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_social_row.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_screen_view_body_test.mocks.dart';

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
          child: Scaffold(body: RegisterScreenViewBody()),
        ),
      ),
    );
  }

  testWidgets('verify RegisterScreenViewBody structure', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();
    //final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.byType(Stack), findsNWidgets(2));
    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(BackdropFilter), findsNWidgets(2));
    expect(find.byType(Column), findsNWidgets(5));
    expect(find.byType(SingleChildScrollView), findsNWidgets(1));
    expect(find.byType(Logo), findsOneWidget);
    expect(find.byType(BlurContainer), findsOneWidget);
    expect(find.byType(RegisterScreenForm), findsOneWidget);
    expect(find.byType(RegisterScreenOrRow), findsOneWidget);
    expect(find.byType(RegisterScreenForm), findsOneWidget);
    expect(find.byType(RegisterScreenSocialRow), findsOneWidget);
    expect(find.byType(RegisterScreenButton), findsOneWidget);
    expect(find.byType(RegisterScreenAlreadyHaveAnAccount), findsOneWidget);
    final context = tester.element(find.byType(SingleChildScrollView));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == context.setHight(24),
      ),
      findsAtLeast(3),
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == context.setHight(8) 
      ),
      findsNWidgets(2),
    );
     expect(
      find.byWidgetPredicate(
        (widget) => widget is Padding && widget.padding ==  EdgeInsets.all(context.setMinSize(16)),
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Column &&
        widget.children.length == 2&& 
        widget.children.isNotEmpty &&
        widget.children[0] is Logo &&
        widget.children[1] is Column,
      ),
      findsAtLeast(1),
    );
    expect(
  find.byWidgetPredicate(
    (widget) =>
        widget is Column &&
        widget.crossAxisAlignment == CrossAxisAlignment.start &&
        widget.children.length == 2 &&
        widget.children[0] is Padding &&
        widget.children[1] is BlurContainer,
  ),
  findsAtLeast(1),
);
expect(
  find.byWidgetPredicate(
    (widget) =>
        widget is Column &&
        widget.children.isNotEmpty &&
        widget.children.first is RegisterScreenForm &&
        widget.children.any((c) => c is RegisterScreenButton) &&
        widget.children.any((c) => c is RegisterScreenAlreadyHaveAnAccount),
  ),
  findsAtLeast(1),
);
  });
  tearDown(getIt.reset);
}
