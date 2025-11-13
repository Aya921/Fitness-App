import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_elevated_button.dart';
import 'package:fitness/core/widget/loading_circle.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_edit_button.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'profile_edit_button_test.mocks.dart';

@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockCubit;

  const fakeUser = UserEntity(
    personalInfo: PersonalInfoEntity(
      id: '1',
      age: 22,
      gender: 'female',
      photo: '',
      firstName: 'Rana',
      lastName: 'Gebril',
      email: 'rana@test.com',
    ),
    bodyInfo: BodyInfoEntity(weight: 60, height: 165),
    goal: 'Get fit',
    activityLevel: 'Medium',
    createdAt: '',
  );

  const AuthEntity fakeAuthEntity = AuthEntity(
    user: fakeUser,
    message: "success",
  );
  setUp(() {
    mockCubit = MockEditProfileCubit();
    when(
      mockCubit.stream,
    ).thenAnswer((_) => const Stream<EditProfileState>.empty());
    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.firstNameController).thenReturn(TextEditingController());
    when(mockCubit.lastNameController).thenReturn(TextEditingController());
    when(mockCubit.emailController).thenReturn(TextEditingController());
  });

  Widget prepareWidget(EditProfileState state) {
    when(mockCubit.state).thenReturn(state);

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
            value: mockCubit,
            child: const ProfileEditButton(user: fakeUser),
          ),
        ),
      ),
    );
  }

  testWidgets('shows text button when not loading', (tester) async {
    final state = const EditProfileState().copyWith(
      editProfileStatus: const StateStatus.success(fakeAuthEntity),
    );
    await tester.pumpWidget(prepareWidget(state));

    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.byType(LoadingCircle), findsNothing);
  });

  testWidgets('shows loading circle when loading', (tester) async {
    final loadingState = const EditProfileState().copyWith(
      editProfileStatus: const StateStatus.loading(),
    );

    await tester.pumpWidget(prepareWidget(loadingState));

    expect(find.byType(LoadingCircle), findsOneWidget);
  });

  testWidgets('does not call doIntent when hasChanges = false', (tester) async {
    final testState = const EditProfileState().copyWith(hasChanges: false);

    await tester.pumpWidget(prepareWidget(testState));

    final buttonFinder = find.byType(CustomElevatedButton);
    await tester.tap(buttonFinder);
    await tester.pump();

    verifyNever(mockCubit.doIntent(intent: anyNamed('intent')));
  });
}