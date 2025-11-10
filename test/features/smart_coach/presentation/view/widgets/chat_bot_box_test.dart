
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/chat_bot_box.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';

@GenerateNiceMocks([MockSpec<SmartCoachCubit>()])
void main() {

  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
            body: ChatBotBox()),

      ),

    );
  }
  testWidgets("test structure in ChatBotBox", (WidgetTester tester)async{
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();


    expect(find.text('How Can I Assist You\n Today?'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    expect(find.byType(ElevatedButton), findsOneWidget);

expect(find.byType(ElevatedButton), findsOneWidget);

  });
}