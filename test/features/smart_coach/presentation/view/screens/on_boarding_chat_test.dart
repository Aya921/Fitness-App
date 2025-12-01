import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';

import 'package:fitness/features/smart_coach/presentation/view/screens/on_boarding_chat.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/chat_bot_box.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/robot_bg.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/user_profile_section.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

import '../widgets/user_profile_section_test.mocks.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSmartCoachCubit cubit;


  setUp((){
    cubit=MockSmartCoachCubit();
    if (!getIt.isRegistered<SmartCoachCubit>()) {
      getIt.registerLazySingleton<SmartCoachCubit>(MockSmartCoachCubit.new);
    }
  });
  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
      child: Scaffold(
        body: BlocProvider(create: (context)=>cubit..loadUserData(),
        child: const OnBoardingChat(),
        )
      )
      ),
    );
  }
  tearDown(() {
    if (getIt.isRegistered<SmartCoachCubit>()) {
      getIt.unregister<SmartCoachCubit>();
    }
  });
  testWidgets('should handle error state gracefully', (WidgetTester tester) async {
    // Arrange
    when(cubit.state).thenReturn(const SmartCoachChatState(errorMessage: 'Some error'));
    when(cubit.loadUserData()).thenAnswer((_) async {});
    when(cubit.name).thenReturn('Mariam');

    // Act
    await tester.binding.setSurfaceSize(const Size(400, 900));
    await tester.pumpWidget(
      TickerMode(enabled: true, child: createWidgetUnderTest()),
    );
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 900));

    // Assert
    // The widget should still render without crashing
    expect(find.byType(UserProfileSection), findsOneWidget);
    expect(find.byType(RobotLogo), findsOneWidget);
    expect(find.byType(ChatBotBox), findsOneWidget);
  });
}