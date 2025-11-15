import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/features/home/presentation/view/widgets/change_pass/change_pass_section.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'change_pass_section.mocks.dart';


@GenerateMocks([ChangePassCubit])
void main() {
  late MockChangePassCubit mockChangePassCubit;
  final getItInstance = GetIt.instance;

  setUpAll(() {
    provideDummy<ChangePassState>(const ChangePassState());
  });

  setUp(() {
    mockChangePassCubit = MockChangePassCubit();

    when(mockChangePassCubit.stream)
        .thenAnswer((_) => const Stream<ChangePassState>.empty());
    when(mockChangePassCubit.state).thenReturn(const ChangePassState());

    getItInstance.registerFactory<ChangePassCubit>(() => mockChangePassCubit);
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
        home: Scaffold(
          body: BlocProvider<ChangePassCubit>(
            create: (_) => mockChangePassCubit,
            child: const ChangePassSection(),
          ),
        ),
      ),
    );
  }

  testWidgets('verify change password section structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(CustomTextField), findsNWidgets(3));
    expect(find.byType(Column), findsNWidgets(1));
    expect(find.byType(CustomFieldsButton), findsNWidgets(1));
  });

  testWidgets('verify form validation works correctly', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final oldPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Old Password',
    );
    final newPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Password',
    );
    final confirmPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Confirm Password',
    );

    await tester.enterText(oldPasswordField, 'OldPass123@');
    await tester.enterText(newPasswordField, 'NewPass123@');
    await tester.enterText(confirmPasswordField, 'NewPass123@');
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
  });

  testWidgets('verify password mismatch shows error', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final newPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Password',
    );
    final confirmPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Confirm Password',
    );

    await tester.enterText(newPasswordField, 'NewPass123!');
    await tester.enterText(confirmPasswordField, 'DifferentPass123!');
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets('verify cubit is called on form submission', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final oldPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Old Password',
    );
    final newPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Password',
    );
    final confirmPasswordField = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.hintText == 'Confirm Password',
    );

    await tester.enterText(oldPasswordField, 'OldPass123!');
    await tester.enterText(newPasswordField, 'NewPass123!');
    await tester.enterText(confirmPasswordField, 'NewPass123!');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    verify(mockChangePassCubit.doIntent(any)).called(1);
  });

}