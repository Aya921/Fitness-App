import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/levels.dart';
import 'package:fitness/core/helper/string_to_activity_level.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_activity_level_screen/edit_activity_level_body.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late EditProfileCubit cubit;
  late EditProfileState state;
  late UserEntity user;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();

    cubit = getIt<EditProfileCubit>();
    state = cubit.state;

    user = const UserEntity(activityLevel: 'level1');
  });

  testWidgets('test EditActivityLevelBody structure', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: EditActivityLevelBody(cubit: cubit, user: user, state: state),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(Column), findsAtLeast(3));
    expect(find.byType(Row), findsAtLeast(1));
    expect(find.byType(SizedBox), findsAtLeast(5));
    expect(find.byType(Padding), findsAtLeast(1));
    expect(find.byType(AnimateText), findsAtLeast(1));
    expect(find.byType(BlurContainer), findsAtLeast(1));
    expect(find.byType(SelectWidgetItem), findsAtLeast(1));
    expect(find.byType(CustomElevatedButton), findsAtLeast(1));
    expect(find.byType(SingleChildScrollView), findsAtLeast(1));


     






  });

  testWidgets('select level1', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: EditActivityLevelBody(cubit: cubit, user: user, state: state),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final item = find.byType(SelectWidgetItem).at(0);
    await tester.tap(item);
    await tester.pumpAndSettle();

    final currentLevel = state.updatedLevel ?? activityLevelFromString(user.activityLevel);
    expect(currentLevel, ActivityLevel.level1);

  
  });

  testWidgets('select level2', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: EditActivityLevelBody(cubit: cubit, user: user, state: state),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final item = find.byType(SelectWidgetItem).at(1);
    await tester.tap(item);
    await tester.pumpAndSettle();

    final currentLevel = state.updatedLevel ?? activityLevelFromString(user.activityLevel);
    expect(currentLevel, ActivityLevel.level1);





   
  });


}
