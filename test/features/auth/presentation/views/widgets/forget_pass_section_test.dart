import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass_section.dart';
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
  group("test forget pass section", () {
    testWidgets('test forget pass section  struture ...', (
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
            child: Scaffold(body: ForgetPassSection()),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      expect(find.byType(CustomTextField), findsNWidgets(1));
      expect(find.byType(Column), findsNWidgets(1));
      expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
      expect(find.byType(CustomFieldsButton), findsAtLeastNWidgets(1));

      final firstCustumTextFields = tester.widget<CustomTextField>(
        find.byType(CustomTextField),
      );
      expect(firstCustumTextFields.hintText, l10n.email);
      expect(firstCustumTextFields.icon, AssetsManeger.mail);

      final context = tester.element(find.byType(CustomFieldsButton));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SizedBox && widget.height == context.setHight(20),
        ),
        findsOneWidget,
      );
    });

    testWidgets('test when enter field correct ...', (
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
            child: Scaffold(body: ForgetPassSection()),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.enterText(
        find.byType(CustomTextField).first,
        "aya2@gmail.com",
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.emailRequired), findsNothing);
      expect(find.text(l10n.emailNotValid), findsNothing);
    });
    testWidgets(
      'test when enter email field wrong then it should appear a error message ...',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(body: ForgetPassSection()),
            ),
          ),
        );

        final l10n = await AppLocalizations.delegate.load(const Locale('en'));

        await tester.enterText(find.byType(CustomTextField).first, "ee");

        await tester.pumpAndSettle();

        expect(find.text(l10n.emailNotValid), findsOneWidget);
      },
    );

    testWidgets('test when enter empty value  ...', (
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
            child: Scaffold(body: ForgetPassSection()),
          ),
        ),
      );

      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      await tester.enterText(find.byType(CustomTextField).first, "eeee");
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(CustomTextField).first, "");

      await tester.pumpAndSettle();
      expect(find.text(l10n.emailRequired), findsOneWidget);
    });
  });
}
