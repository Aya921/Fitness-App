import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/views/widgets/create_new_pass_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import '../screens/forget_password_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ForgetPassCubit>()])
void main() {
  setUpAll(() {
    if (!getIt.isRegistered<ForgetPassCubit>()) {
      getIt.registerLazySingleton<ForgetPassCubit>(MockForgetPassCubit.new);
    }
  });

  group("test create new pass section", () {
    testWidgets('test create new pass section  struture ...', (
      WidgetTester tester,
    ) async {
      final newPassController = TextEditingController();
      final confirmPassController = TextEditingController();
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(body: CreateNewPassSection(email: '')),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      expect(find.byType(CustomFieldsButton), findsAtLeastNWidgets(1));

      final custumTextFileds = find.byType(CustomTextField);
      final firstCustumTextFields = tester.widget<CustomTextField>(
        custumTextFileds.first,
      );
      expect(firstCustumTextFields.controller.value, newPassController.value);
      expect(firstCustumTextFields.hintText, l10n.password);
      expect(firstCustumTextFields.icon, AssetsManager.lock);

      final context = tester.element(find.byType(CustomFieldsButton));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox && widget.height == context.setHight(15),
        ),
        findsOneWidget,
      );

      final secondCustumTextFields = tester.widget<CustomTextField>(
        custumTextFileds.at(1),
      );
      expect(
        secondCustumTextFields.controller.value,
        confirmPassController.value,
      );
      expect(secondCustumTextFields.hintText, l10n.confirmPass);
      expect(secondCustumTextFields.icon, AssetsManager.lock);

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox && widget.height == context.setHight(35),
        ),
        findsOneWidget,
      );
    });

    testWidgets('test when enter all fields correct ...', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(body: CreateNewPassSection(email: '')),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      expect(find.byType(CustomFieldsButton), findsAtLeastNWidgets(1));

      await tester.enterText(find.byType(CustomTextField).first, "Elevate-2");
      await tester.enterText(find.byType(CustomTextField).at(1), "Elevate-2");

      await tester.pumpAndSettle();
      expect(find.text(l10n.passwordsNotMatch), findsNothing);
      expect(find.text(l10n.fieldRequired), findsNothing);
      expect(find.text(l10n.passwordRequired), findsNothing);
    });
    testWidgets(
      'test when enter all fields wrong then should show two error message ...',
      (WidgetTester tester) async {
        final ValueNotifier<bool> isPasswordCorrect = ValueNotifier<bool>(
          false,
        );
        final ValueNotifier<bool> isConfirmPassCorrect = ValueNotifier<bool>(
          false,
        );
        final isFormValid = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(body: CreateNewPassSection(email: '')),
            ),
          ),
        );

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        expect(find.byType(CustomTextField), findsNWidgets(2));
        expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
        expect(find.byType(CustomFieldsButton), findsAtLeastNWidgets(1));

        await tester.enterText(find.byType(CustomTextField).first, "ee");
        await tester.enterText(find.byType(CustomTextField).at(1), "kj");

        await tester.pumpAndSettle();
        expect(isPasswordCorrect.value, false);
        expect(isConfirmPassCorrect.value, false);
        expect(isFormValid.value, false);
        expect(find.text(l10n.passwordMinLength), findsOneWidget);
        expect(find.text(l10n.passwordsNotMatch), findsOneWidget);
      },
    );

    testWidgets(
      'test when enter correct pass but it the confirm pass doesnot match then it should show one error message ...',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(body: CreateNewPassSection(email: '')),
            ),
          ),
        );

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.enterText(find.byType(CustomTextField).first, "Elevate-2");
        await tester.enterText(find.byType(CustomTextField).at(1), "kj");

        await tester.pumpAndSettle();
        expect(find.text(l10n.passwordsNotMatch), findsOneWidget);
      },
    );
    testWidgets('test when enter nothing in both fields...', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(body: CreateNewPassSection(email: '')),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(find.byType(CustomTextField).first, "eeee");
      await tester.enterText(find.byType(CustomTextField).at(1), "eeee");
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(CustomTextField).first, "");
      await tester.enterText(find.byType(CustomTextField).at(1), "");

      await tester.pumpAndSettle();
      expect(find.text(l10n.passwordRequired), findsOneWidget);
      expect(find.text(l10n.fieldRequired), findsOneWidget);
    });
    testWidgets(
      'test when enter pass field empty and second with text then it should return 2 error message ...',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(body: CreateNewPassSection(email: '')),
            ),
          ),
        );

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.enterText(find.byType(CustomTextField).first, "eeee");
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(CustomTextField).first, "");
        await tester.enterText(find.byType(CustomTextField).at(1), "kj");

        await tester.pumpAndSettle();
        expect(find.text(l10n.passwordRequired), findsOneWidget);
        expect(find.text(l10n.passwordsNotMatch), findsOneWidget);
      },
    );
    testWidgets(
      'test when enter pass field correct and second enter nothing  then it should return 2 error message ',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(body: CreateNewPassSection(email: '')),
            ),
          ),
        );

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.enterText(find.byType(CustomTextField).at(1), "eeee");
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(CustomTextField).first, "Elevate-2");
        await tester.enterText(find.byType(CustomTextField).at(1), "");

        await tester.pumpAndSettle();
        expect(find.text(l10n.fieldRequired), findsOneWidget);
      },
    );
  });
}
