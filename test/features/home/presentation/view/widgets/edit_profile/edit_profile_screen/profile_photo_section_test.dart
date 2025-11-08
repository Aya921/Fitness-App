import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_photo_section.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_photo_section_test.mocks.dart';

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

  setUp(() {
    mockCubit = MockEditProfileCubit();
    when(
      mockCubit.stream,
    ).thenAnswer((_) => const Stream<EditProfileState>.empty());
    when(mockCubit.state).thenReturn(const EditProfileState());

    when(mockCubit.formKey).thenReturn(GlobalKey<FormState>());
    when(mockCubit.firstNameController).thenReturn(TextEditingController());
    when(mockCubit.lastNameController).thenReturn(TextEditingController());
    when(mockCubit.emailController).thenReturn(TextEditingController());
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
            value: mockCubit,
            child: ProfilePhotoSection(cubit: mockCubit, user: fakeUser),
          ),
        ),
      ),
    );
  }

  testWidgets('verify photo section structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key(WidgetKey.photoSectionStack)), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.shadowBehindPhoto)), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.transparentLayer)), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(
      find.byType(BlocBuilder<EditProfileCubit, EditProfileState>),
      findsOneWidget,
    );
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.editIconContainer)), findsOneWidget);
    expect(find.byKey(const Key(WidgetKey.editIcon)), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).boxShadow != null,
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color?.opacity == 120 / 255,
      ),
      findsOneWidget,
    );
  });
}
