import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/user_profile_section.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';

import 'user_profile_section_test.mocks.dart';
@GenerateNiceMocks([MockSpec<SmartCoachCubit>()])
void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
late MockSmartCoachCubit cubit;


  setUp((){
cubit=MockSmartCoachCubit();
  });
  Widget createWidgetUnderTest(String userName) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
body: BlocProvider(create: (context)=>cubit,
child: UserProfileSection(firstName: userName),
),
        ),

      ),

    );
  }
  testWidgets("test structure in profile section",
          (WidgetTester tester)
  async{
    const  firstName="mariam";
    await tester.pumpWidget(createWidgetUnderTest(firstName));
    await tester.pumpAndSettle();
   expect(find.textContaining(firstName), findsOneWidget);
    expect(find.textContaining('I Am Your Smart Coach'), findsOneWidget);


  });
}