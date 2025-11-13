import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/validator/validator.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_profile_screen/profile_text_fields.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_text_fields_test.mocks.dart';

@GenerateMocks([EditProfileCubit])
void main() {
  late MockEditProfileCubit mockCubit;

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
            child: Form(
              key: mockCubit.formKey,
              child: ProfileTextFields(cubit: mockCubit),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('verify profile text fields structure and properties', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final firstNameField = find.byKey(const Key(WidgetKey.firstNameFormField));
    final lastNameField = find.byKey(const Key(WidgetKey.lastNameFormField));
    final emailField = find.byKey(const Key(WidgetKey.emailFormField));

    expect(firstNameField, findsOneWidget);
    expect(lastNameField, findsOneWidget);
    expect(emailField, findsOneWidget);

    expect(
      find.descendant(of: firstNameField, matching: find.byType(TextFormField)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: lastNameField, matching: find.byType(TextFormField)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: emailField, matching: find.byType(TextFormField)),
      findsOneWidget,
    );

    expect(
      find.descendant(of: firstNameField, matching: find.byType(SvgPicture)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: lastNameField, matching: find.byType(SvgPicture)),
      findsOneWidget,
    );
    expect(
      find.descendant(of: emailField, matching: find.byType(SvgPicture)),
      findsOneWidget,
    );

    final column = find.byType(Column);
    expect(column, findsOneWidget);

    final columnWidget = tester.widget<Column>(column);
    expect(columnWidget.children.length, 5);

    expect(find.byType(CustomTextFormField), findsNWidgets(3));

    final firstNameWidget = tester.widget<CustomTextFormField>(firstNameField);
    final lastNameWidget = tester.widget<CustomTextFormField>(lastNameField);
    final emailWidget = tester.widget<CustomTextFormField>(emailField);

    expect(firstNameWidget.validator != null, true);
    expect(lastNameWidget.validator != null, true);
    expect(emailWidget.validator != null, true);
  });

  testWidgets('verify typing in profile text fields updates controller', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key(WidgetKey.firstNameFormField)),
      'Rana',
    );
    await tester.enterText(
      find.byKey(const Key(WidgetKey.lastNameFormField)),
      'Gebril',
    );
    await tester.enterText(
      find.byKey(const Key(WidgetKey.emailFormField)),
      'rana@test.com',
    );

    expect(mockCubit.firstNameController.text, 'Rana');
    expect(mockCubit.lastNameController.text, 'Gebril');
    expect(mockCubit.emailController.text, 'rana@test.com');
  });

  testWidgets('verify validators on profile text fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final formKey = mockCubit.formKey;

    await tester.pumpWidget(prepareWidget());

    await tester.pumpAndSettle();

    // FirstName validator
    await tester.enterText(
      find.byKey(const Key(WidgetKey.firstNameFormField)),
      '',
    );
    expect(formKey.currentState?.validate(), isFalse);

    final firstName = tester.element(
      find.byKey(const Key(WidgetKey.firstNameFormField)),
    );
    expect(Validator.validateUsername(firstName, ''), isNotNull);
    expect(Validator.validateUsername(firstName, 'Rana'), isNull);

    //LastName validator
    await tester.enterText(
      find.byKey(const Key(WidgetKey.lastNameFormField)),
      '',
    );
    expect(formKey.currentState?.validate(), isFalse);

    final lastName = tester.element(
      find.byKey(const Key(WidgetKey.lastNameFormField)),
    );
    expect(Validator.validateUsername(lastName, ''), isNotNull);
    expect(Validator.validateUsername(lastName, 'Rana'), isNull);

    //  Email validator
    await tester.enterText(
      find.byKey(const Key(WidgetKey.emailFormField)),
      'invalidemail',
    );
    expect(formKey.currentState?.validate(), isFalse);

    final emailValid = Validator.validateEmail(
      tester.element(find.byKey(const Key(WidgetKey.emailFormField))),
      'rana@gmail.com',
    );
    expect(emailValid, isNull);
  });
}