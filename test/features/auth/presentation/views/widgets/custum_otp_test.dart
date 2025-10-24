import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/views/widgets/custum_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ValueNotifier<bool> isOtpCompleted;

  group('test otp sceen', () {
    testWidgets('test custum otp struture ...', (WidgetTester tester) async {
      isOtpCompleted = ValueNotifier<bool>(false);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: CustomOtpField(
                numberOfFields: 4,
                isOtpCompleted: isOtpCompleted, codeValue: ValueNotifier<String>(''),
              ),
            ),
          ),
        ),
      );

    
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Container), findsAtLeastNWidgets(1));
      expect(find.byType(TextField), findsNWidgets(4));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is TextField &&
              widget.textAlign == TextAlign.center &&
              widget.keyboardType == TextInputType.number &&
              widget.inputFormatters!.any(
                (f) => f is FilteringTextInputFormatter,
              ) &&
              widget.style?.color == AppColors.orange &&
              widget.decoration!.counterText == "" &&
              widget.decoration!.enabledBorder!.borderSide.width == 2 &&
              widget.decoration!.focusedBorder!.borderSide.color ==
                  AppColors.orange &&
              widget.decoration!.focusedBorder!.borderSide.width == 2,
        ),
        findsNWidgets(4),
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Row &&
              widget.mainAxisAlignment == MainAxisAlignment.center,
        ),
        findsOneWidget,
      );

      final context = tester.firstElement(find.byType(TextField));
      final expectedFontSize = context.setSp(FontSize.s18);
      final textField = tester.widget<TextField>(find.byType(TextField).first);
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(textField.style?.fontSize, expectedFontSize);
      expect(
        textField.style,
        getMediumStyle(
          color: AppColors.orange,
          fontSize: context.setSp(FontSize.s18),
        ),
      );
      expect(
        container.margin,
        EdgeInsets.symmetric(horizontal: context.setWidth(8)),
      );
     
    });

    testWidgets(
      'test custum otp when write number number to make all fields filled ...',
      (WidgetTester tester) async {
        isOtpCompleted = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomOtpField(
                  codeValue: ValueNotifier<String>(''),
                  
                  numberOfFields: 4,
                  isOtpCompleted: isOtpCompleted,
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).first, '1');
        await tester.enterText(find.byType(TextField).at(1), '2');
        await tester.enterText(find.byType(TextField).at(2), '3');
        await tester.enterText(find.byType(TextField).at(3), '4');
        await tester.pumpAndSettle();

        expect(isOtpCompleted.value, true);
        final textFields = find.byType(TextField);
        final firstFocusNode = tester
            .widget<TextField>(textFields.at(0))
            .focusNode!;
        final secondFocusNode = tester
            .widget<TextField>(textFields.at(1))
            .focusNode!;
        final thirdFocusNode = tester
            .widget<TextField>(textFields.at(2))
            .focusNode!;
        final fourthFocusNode = tester
            .widget<TextField>(textFields.at(3))
            .focusNode!;

        final fieldTexts = <String>[];

        for (var i = 0; i < 4; i++) {
          final textFieldWidget = tester.widget<TextField>(textFields.at(i));
          fieldTexts.add(textFieldWidget.controller?.text ?? '');
        }

        final otp = fieldTexts.join();
        expect(otp, '1234');
        expect(firstFocusNode.hasFocus, false);
        expect(secondFocusNode.hasFocus, false);
        expect(thirdFocusNode.hasFocus, false);
        expect(fourthFocusNode.hasFocus, false);
      },
    );

    testWidgets(
      'test custum otp when write in only one filed and focus will be in second field ...',
      (WidgetTester tester) async {
        isOtpCompleted = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomOtpField(
                  codeValue: ValueNotifier<String>(''),
                  
                  numberOfFields: 4,
                  isOtpCompleted: isOtpCompleted,
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).first, '1');
        await tester.pumpAndSettle();
        expect(isOtpCompleted.value, false);

        final textFields = find.byType(TextField);
        final firstFocusNode = tester
            .widget<TextField>(textFields.at(0))
            .focusNode!;
        final secondFocusNode = tester
            .widget<TextField>(textFields.at(1))
            .focusNode!;
        final thirdFocusNode = tester
            .widget<TextField>(textFields.at(2))
            .focusNode!;
        final fourthFocusNode = tester
            .widget<TextField>(textFields.at(3))
            .focusNode!;

        final fieldTexts = <String>[];

        for (var i = 0; i < 4; i++) {
          final textFieldWidget = tester.widget<TextField>(textFields.at(i));
          fieldTexts.add(textFieldWidget.controller?.text ?? '');
        }

        final otp = fieldTexts.join();
        expect(otp, '1');
        expect(firstFocusNode.hasFocus, false);
        expect(secondFocusNode.hasFocus, true);
        expect(thirdFocusNode.hasFocus, false);
        expect(fourthFocusNode.hasFocus, false);
      },
    );
    testWidgets('test custum otp when write in only two filed ...', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: CustomOtpField(
                codeValue: ValueNotifier<String>('')
 ,               
                numberOfFields: 4,
                isOtpCompleted: isOtpCompleted,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '1');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.pumpAndSettle();
      expect(isOtpCompleted.value, false);

      final textFields = find.byType(TextField);
      final firstFocusNode = tester
          .widget<TextField>(textFields.at(0))
          .focusNode!;
      final secondFocusNode = tester
          .widget<TextField>(textFields.at(1))
          .focusNode!;
      final thirdFocusNode = tester
          .widget<TextField>(textFields.at(2))
          .focusNode!;
      final fourthFocusNode = tester
          .widget<TextField>(textFields.at(3))
          .focusNode!;

      final fieldTexts = <String>[];

      for (var i = 0; i < 4; i++) {
        final textFieldWidget = tester.widget<TextField>(textFields.at(i));
        fieldTexts.add(textFieldWidget.controller?.text ?? '');
      }

      final otp = fieldTexts.join();
      expect(otp, '12');
      expect(firstFocusNode.hasFocus, false);
      expect(secondFocusNode.hasFocus, false);
      expect(thirdFocusNode.hasFocus, true);
      expect(fourthFocusNode.hasFocus, false);
    });

    testWidgets('test custum otp when write in only three fileds ...', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: CustomOtpField(
                codeValue: ValueNotifier<String>('')
 ,               
                numberOfFields: 4,
                isOtpCompleted: isOtpCompleted,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '1');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.enterText(find.byType(TextField).at(2), '3');
      await tester.pumpAndSettle();
      expect(isOtpCompleted.value, false);

      final textFields = find.byType(TextField);
      final firstFocusNode = tester
          .widget<TextField>(textFields.at(0))
          .focusNode!;
      final secondFocusNode = tester
          .widget<TextField>(textFields.at(1))
          .focusNode!;
      final thirdFocusNode = tester
          .widget<TextField>(textFields.at(2))
          .focusNode!;
      final fourthFocusNode = tester
          .widget<TextField>(textFields.at(3))
          .focusNode!;

      final fieldTexts = <String>[];

      for (var i = 0; i < 4; i++) {
        final textFieldWidget = tester.widget<TextField>(textFields.at(i));
        fieldTexts.add(textFieldWidget.controller?.text ?? '');
      }

      final otp = fieldTexts.join();
      expect(otp, '123');
      expect(firstFocusNode.hasFocus, false);
      expect(secondFocusNode.hasFocus, false);
      expect(thirdFocusNode.hasFocus, false);
      expect(fourthFocusNode.hasFocus, true);
    });
    testWidgets(
      'test custum otp when write in 2 digets in one field then the first digeit will be in first field and second in second field ...',
      (WidgetTester tester) async {
        isOtpCompleted = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomOtpField(
                  codeValue: ValueNotifier<String>(''),
                  
                  numberOfFields: 4,
                  isOtpCompleted: isOtpCompleted,
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).first, '12');

        await tester.pumpAndSettle();
        expect(isOtpCompleted.value, false);

        final textFields = find.byType(TextField);
        final firstFocusNode = tester
            .widget<TextField>(textFields.at(0))
            .focusNode!;
        final secondFocusNode = tester
            .widget<TextField>(textFields.at(1))
            .focusNode!;
        final thirdFocusNode = tester
            .widget<TextField>(textFields.at(2))
            .focusNode!;
        final fourthFocusNode = tester
            .widget<TextField>(textFields.at(3))
            .focusNode!;

        expect(
          tester.widget<TextField>(textFields.at(0)).controller!.text,
          '1',
        );
        expect(
          tester.widget<TextField>(textFields.at(1)).controller!.text,
          '2',
        );
        expect(firstFocusNode.hasFocus, false);
        expect(secondFocusNode.hasFocus, false);
        expect(thirdFocusNode.hasFocus, true);
        expect(fourthFocusNode.hasFocus, false);
      },
    );
    testWidgets(
      'test custum otp when write in 2 digets in the second field then the first digeit will be in second field and second in thire field ...',
      (WidgetTester tester) async {
        isOtpCompleted = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomOtpField(
                  codeValue: ValueNotifier<String>(''),
                  
                  numberOfFields: 4,
                  isOtpCompleted: isOtpCompleted,
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).at(1), '12');

        await tester.pumpAndSettle();
        expect(isOtpCompleted.value, false);

        final textFields = find.byType(TextField);
        final firstFocusNode = tester
            .widget<TextField>(textFields.at(0))
            .focusNode!;
        final secondFocusNode = tester
            .widget<TextField>(textFields.at(1))
            .focusNode!;
        final thirdFocusNode = tester
            .widget<TextField>(textFields.at(2))
            .focusNode!;
        final fourthFocusNode = tester
            .widget<TextField>(textFields.at(3))
            .focusNode!;

        expect(
          tester.widget<TextField>(textFields.at(1)).controller!.text,
          '1',
        );
        expect(
          tester.widget<TextField>(textFields.at(2)).controller!.text,
          '2',
        );
        expect(tester.widget<TextField>(textFields.at(0)).controller!.text, '');
        expect(tester.widget<TextField>(textFields.at(3)).controller!.text, '');

        expect(firstFocusNode.hasFocus, false);
        expect(secondFocusNode.hasFocus, false);
        expect(thirdFocusNode.hasFocus, false);
        expect(fourthFocusNode.hasFocus, true);
      },
    );

    testWidgets(
      'test custum otp when write 37  in last field then it will be 3 only ...',
      (WidgetTester tester) async {
        isOtpCompleted = ValueNotifier<bool>(false);
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Scaffold(
                body: CustomOtpField(
                  codeValue: ValueNotifier<String>(''),
                  
                  numberOfFields: 4,
                  isOtpCompleted: isOtpCompleted,
                ),
              ),
            ),
          ),
        );

        await tester.enterText(find.byType(TextField).at(3), '37');

        await tester.pumpAndSettle();
        expect(isOtpCompleted.value, false);

        final textFields = find.byType(TextField);
        final firstFocusNode = tester
            .widget<TextField>(textFields.at(0))
            .focusNode!;
        final secondFocusNode = tester
            .widget<TextField>(textFields.at(1))
            .focusNode!;
        final thirdFocusNode = tester
            .widget<TextField>(textFields.at(2))
            .focusNode!;
        final fourthFocusNode = tester
            .widget<TextField>(textFields.at(3))
            .focusNode!;

        expect(
          tester.widget<TextField>(textFields.at(3)).controller!.text,
          '3',
        );
        expect(firstFocusNode.hasFocus, false);
        expect(secondFocusNode.hasFocus, false);
        expect(thirdFocusNode.hasFocus, false);
        expect(fourthFocusNode.hasFocus, false);
      },
    );

  
  });
}
