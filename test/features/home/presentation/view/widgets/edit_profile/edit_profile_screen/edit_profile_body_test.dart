import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/user/user_manager.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/edit_profile_body.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_edit_button.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_photo_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_tab_to_edit_field.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_text_fields.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:fitness/core/constants/app_widgets_key.dart';

import 'edit_profile_body_test.mocks.dart';

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

    when(mockEditProfileCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(
      mockEditProfileCubit.firstNameController,
    ).thenReturn(TextEditingController());
    when(
      mockEditProfileCubit.lastNameController,
    ).thenReturn(TextEditingController());
    when(
      mockEditProfileCubit.emailController,
    ).thenReturn(TextEditingController());

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
        home: Scaffold(
          body: BlocProvider<EditProfileCubit>.value(
            value: mockEditProfileCubit,
            child: const EditProfileBody(),
          ),
        ),
      ),
    );
  }

  testWidgets('verify structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.editProfileBodyColumn)), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
    expect(
      find.byType(BlocConsumer<EditProfileCubit, EditProfileState>),
      findsOneWidget,
    );
    expect(find.byType(CustomPopIcon), findsOneWidget);
    expect(find.byType(ProfilePhotoSection), findsOneWidget);
    expect(find.byType(ProfileTextFields), findsOneWidget);
    expect(find.byType(ProfileTabToEditField), findsNWidgets(3));
    expect(find.byType(ProfileEditButton), findsOneWidget);
  });



}
