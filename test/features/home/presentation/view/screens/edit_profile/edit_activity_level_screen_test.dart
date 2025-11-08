import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/edit_profile/edit_activity_level_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_activity_level_screen/edit_activity_level_body.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_activity_level_screen_test.mocks.dart';


@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockEditProfileCubit;
  final getItInstance = GetIt.instance;

  const fakeUser = UserEntity(
    personalInfo: PersonalInfoEntity(
      id: "1",
      age: 21,
      gender: "female",
      photo: "",
      firstName: 'Rana',
      lastName: 'Gebril',
      email: 'rana@test.com',
    ),
    bodyInfo: BodyInfoEntity(weight: 60, height: 160),
    goal: "Get fitter",
    activityLevel: "",
    createdAt: "",
  );

  setUp(() {
    mockEditProfileCubit = MockEditProfileCubit();

    UserManager().setUser(fakeUser);

    when(
      mockEditProfileCubit.stream,
    ).thenAnswer((_) => const Stream<EditProfileState>.empty());

    when(mockEditProfileCubit.state).thenReturn(const EditProfileState());

    getItInstance.registerFactory<EditProfileCubit>(() => mockEditProfileCubit);
  });

  tearDown(getItInstance.reset);

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: BlocProvider<EditProfileCubit>.value(
          value: mockEditProfileCubit,
          child:  const EditActivityLevelScreen(),
        ),
      ),
    );
  }

  testWidgets('verify EditActivityLevelScreen structure', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(
      find.byType(BlocConsumer<EditProfileCubit, EditProfileState>),
      findsOneWidget,
    );
    expect(find.byType(EditActivityLevelBody), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  });

}
