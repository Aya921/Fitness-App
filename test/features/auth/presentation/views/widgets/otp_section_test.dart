import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/features/auth/presentation/views/widgets/custum_otp.dart';
import 'package:fitness/features/auth/presentation/views/widgets/otp_section.dart';
import 'package:fitness/features/auth/presentation/views/widgets/verification_question_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
 

  testWidgets('otp section test  structure', (WidgetTester tester) async {
    await tester.pumpWidget(
       MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: OtpSection()),
        ),
      ),
    );

    expect(find.byType(Column), findsAtLeastNWidgets(1));
    expect(find.byType(CustomOtpField), findsAtLeastNWidgets(1));
    expect(find.byType(SizedBox), findsAtLeastNWidgets(1));
    expect(find.byType(CustumFieldsButton), findsAtLeastNWidgets(1));
    expect(find.byType(VerifcationQuestionSection), findsAtLeastNWidgets(1));

    final context = tester.element(find.byType(CustomOtpField));
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CustomOtpField && widget.numberOfFields ==4,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox &&widget.height==context.setHight(30),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is CustumFieldsButton &&widget.text==context.loc.confirm
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Column &&widget.children.length==4&&widget.children[0] is CustomOtpField&&
        widget.children[1] is SizedBox&&
        widget.children[2] is CustumFieldsButton&&
        widget.children[3] is VerifcationQuestionSection
      ),
      findsOneWidget,
    );
   
  });
}
