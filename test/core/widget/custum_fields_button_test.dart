import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test custum field button  ...", () {
    testWidgets(
      'test custum field button when notify.value=false then the color of button will be gray  ...',
      (WidgetTester tester) async {
        final ValueNotifier<bool> valueNotify = ValueNotifier<bool>(false);

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomFieldsButton(
                  isLoading: false,
                  myChild: const Text("click"),
                  valueNotify: valueNotify,
                  onPress: null,
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // expect(find.byType(ValueListenableBuilder), findsAtLeastNWidgets(1));
        expect(find.byType(Row), findsAtLeastNWidgets(1));
        expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
        expect(find.byType(Text), findsAtLeastNWidgets(1));
        expect(find.byType(Expanded), findsAtLeastNWidgets(1));

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is ElevatedButton &&
                widget.style ==
                    const ButtonStyle().copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.gray[70],
                      ),
                    ),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'test custum field button when notify.value=true then the color of button will be orage  ...',
      (WidgetTester tester) async {
        final ValueNotifier<bool> valueNotify = ValueNotifier<bool>(true);

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomFieldsButton(
                  isLoading: false,
                  myChild: const Text("click"),
                  valueNotify: valueNotify,
                  onPress: null,
                ),
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // expect(find.byType(ValueListenableBuilder), findsAtLeastNWidgets(1));
        expect(find.byType(Row), findsAtLeastNWidgets(1));
        expect(find.byType(ElevatedButton), findsAtLeastNWidgets(1));
        expect(find.byType(Text), findsAtLeastNWidgets(1));
        expect(find.byType(Expanded), findsAtLeastNWidgets(1));

        expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is ElevatedButton &&
                widget.style ==
                    const ButtonStyle().copyWith(
                      backgroundColor: const WidgetStatePropertyAll(
                        AppColors.orange,
                      ),
                    ),
          ),
          findsOneWidget,
        );
      },
    );
  });
}
