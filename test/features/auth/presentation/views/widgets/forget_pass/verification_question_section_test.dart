import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/view_model/forget_pass_cubit/forget_pass_cubit.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass/verification_question_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../../screens/forget_password_screen_test.mocks.dart';
@GenerateNiceMocks([MockSpec<ForgetPassCubit>()])
void main() {

   setUpAll(() {
     if (!getIt.isRegistered<ForgetPassCubit>()) {
      getIt.registerLazySingleton<ForgetPassCubit>(MockForgetPassCubit.new);
    }
  });
  testWidgets('test verification question  section  struture ...', (
    
    WidgetTester tester,
  ) async {
    final ForgetPassCubit forgetPassCubit=getIt.get<ForgetPassCubit>();
    await tester.pumpWidget(
       MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: VerifcationQuestionSection(email: '', forgetPassBloc: forgetPassCubit,)),
        ),
      ),
    );

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    expect(find.byType(Padding), findsAtLeastNWidgets(1));
    expect(find.byType(Column), findsAtLeastNWidgets(1));
    expect(find.byType(Text), findsAtLeastNWidgets(3));
    expect(find.byType(Row), findsAtLeastNWidgets(1));
    expect(find.byType(GestureDetector), findsAtLeastNWidgets(1));
    expect(find.byType(MouseRegion), findsAtLeastNWidgets(1));
    expect(find.byType(SizedBox), findsAtLeastNWidgets(1));

    final context = tester.element(find.byType(Column));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == l10n.didnotReciveCode &&
            widget.style ==
                getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s16),
                ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == l10n.resendCode &&
            widget.style ==
                getBoldStyle(
                  color: AppColors.gray[70]!,
                  fontSize: context.setSp(FontSize.s16),
                ).copyWith(
                  decorationColor: AppColors.orange,
                  decorationThickness: 2,
                ),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == context.setWidth(10),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.style == getRegularStyle(color: AppColors.white),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.center &&
            widget.children.length == 3 &&
            widget.children[0] is GestureDetector &&
            widget.children[1] is SizedBox &&
            widget.children[2] is Text,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 2 &&
            widget.children[0] is Text &&
            widget.children[1] is Row,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.only(top: context.setHight(15)),
      ),
      findsOneWidget,
    );
  });

  testWidgets('test timer countdown and resend enabled after 30 seconds and text color of resend code be orange with underline', (
    WidgetTester tester,
  ) async {
    final ForgetPassCubit forgetPassCubit=getIt.get<ForgetPassCubit>();
    await tester.pumpWidget(
       MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: VerifcationQuestionSection(email: '',forgetPassBloc: forgetPassCubit,)),
        ),
      ),
    );

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    final context = tester.element(find.byType(Column));

    expect(find.text('00:30'), findsOneWidget);
    expect(find.text('00:29'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('00:29'), findsOneWidget);

    await tester.pump(const Duration(seconds: 29));



    await tester.pump(const Duration(seconds: 2));

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text &&
            widget.data == l10n.resendCode &&
            widget.style ==
                getBoldStyle(
                  color: AppColors.orange,
                  fontSize: context.setSp(FontSize.s16),
                ).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                  decorationThickness: 2,
                ),
      ),
      findsOneWidget,
    );
  });
}
