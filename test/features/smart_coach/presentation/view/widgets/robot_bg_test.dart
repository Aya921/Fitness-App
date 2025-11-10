import 'package:animate_do/animate_do.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/robot_bg.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter/material.dart';

import 'user_profile_section_test.mocks.dart';
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
          body: RobotLogo()),

      ),

    );
  }
testWidgets("test structure in robot logo", (WidgetTester tester)async{
  await tester.pumpWidget(createWidgetUnderTest());
  await tester.pumpAndSettle();
  await tester.pump(const Duration(milliseconds: 900));


  expect(find.byType(FadeInUp), findsOneWidget);

  expect(find.byType(Image), findsOneWidget);

  final Image imageWidget = tester.widget(find.byType(Image));
  expect(imageWidget.image is AssetImage, true);
  final AssetImage assetImage = imageWidget.image as AssetImage;
 expect(assetImage.assetName, AssetsManager.astron);
});
}