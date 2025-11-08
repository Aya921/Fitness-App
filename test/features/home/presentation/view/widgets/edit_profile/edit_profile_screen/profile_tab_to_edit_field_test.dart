import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_tab_to_edit_field.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_tab_to_edit_field_test.mocks.dart';

@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockEditProfileCubit;

  setUp(() {
    mockEditProfileCubit = MockEditProfileCubit();

    when(mockEditProfileCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockEditProfileCubit.state).thenReturn(const EditProfileState());
    when(mockEditProfileCubit.formKey).thenReturn(GlobalKey<FormState>());
  });

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: BlocProvider<EditProfileCubit>.value(
            value: mockEditProfileCubit,
            child: const ProfileTabToEditField(
              title: 'Goal',
              value: 'Lose Weight',
              routeToNavigate: '/editGoal',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('verify structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key(WidgetKey.tabToEditNavigator)), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.tabToEditNTextRich)), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(CustomTextFormField), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.textContaining('Goal'), findsOneWidget);
    expect(find.text('Lose Weight'), findsOneWidget);
  });
}
