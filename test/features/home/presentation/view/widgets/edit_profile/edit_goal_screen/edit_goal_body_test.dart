import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_goal_screen/edit_goal_body.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late EditProfileCubit cubit;
  late EditProfileState state;
  late UserEntity? user;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();

    cubit = getIt<EditProfileCubit>();
    state = cubit.state;
  });

  testWidgets('test EditGoalBody structure ...', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: EditGoalBody(cubit: cubit, user: null, state: state),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(Column), findsAtLeast(3));
    expect(find.byType(Row), findsAtLeast(1));
    expect(find.byType(SizedBox), findsAtLeast(5));
    expect(find.byType(Padding), findsAtLeast(2));
    expect(find.byType(AnimateText), findsAtLeast(1));
    expect(find.byType(BlurContainer), findsAtLeast(1));
    expect(find.byType(SelectWidgetItem), findsAtLeast(1));
    expect(find.byType(CustomElevatedButton), findsAtLeast(1));
    //expect(find.byType(LoadingCircle), findsAtLeast(1));
    final context = tester.element(find.byType(Row).first);
    final List<String> goals = [
      context.loc.gainWeight,
      context.loc.loseWeight,
      context.loc.getFitter,
      context.loc.gainMoreFlexible,
      context.loc.learnTheBasic,
    ];

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == context.setHight(24),
      ),
      findsAtLeast(1),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.height == context.setHight(8),
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Padding &&
            widget.padding == EdgeInsets.only(left: context.setWidth(24)) &&
            widget.child is AnimateText,
      ),
      findsAtLeast(1),
    );
   

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[0] &&
            widget.isSelected == false,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[1] &&
            widget.isSelected == false,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[2] &&
            widget.isSelected == false,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[3] &&
            widget.isSelected == false,
      ),
      findsAtLeast(1),
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[4] &&
            widget.isSelected == false,
      ),
      findsAtLeast(1),
    );

    Finder selectWidgetItem = find.byType(SelectWidgetItem).first;
    await tester.tap(selectWidgetItem);
    await tester.pumpAndSettle();

    String? currentGoal = state.updatedGoal;

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[0] &&
            widget.isSelected == (currentGoal == goals[0]),
      ),
      findsOneWidget,
    );

    selectWidgetItem = find.byType(SelectWidgetItem).at(1);
    await tester.tap(selectWidgetItem);
    await tester.pumpAndSettle();

    currentGoal = state.updatedGoal;

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[1] &&
            widget.isSelected == (currentGoal == goals[1]),
      ),
      findsOneWidget,
    );
    selectWidgetItem = find.byType(SelectWidgetItem).at(2);
    await tester.tap(selectWidgetItem);
    await tester.pumpAndSettle();

    currentGoal = state.updatedGoal;

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[2] &&
            widget.isSelected == (currentGoal == goals[2]),
      ),
      findsOneWidget,
    );

    selectWidgetItem = find.byType(SelectWidgetItem).at(3);
    await tester.tap(selectWidgetItem);
    await tester.pumpAndSettle();

    currentGoal = state.updatedGoal;

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[3] &&
            widget.isSelected == (currentGoal == goals[3]),
      ),
      findsOneWidget,
    );
    selectWidgetItem = find.byType(SelectWidgetItem).at(4);
    await tester.tap(selectWidgetItem);
    await tester.pumpAndSettle();

    currentGoal = state.updatedGoal;

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SelectWidgetItem &&
            widget.title == goals[4] &&
            widget.isSelected == (currentGoal == goals[4]),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Column &&
            widget.children.length == 7 &&
            widget.children[5] is SizedBox &&
            widget.children[6] is CustomElevatedButton,
      ),
      findsOneWidget,
    );
  });
}
