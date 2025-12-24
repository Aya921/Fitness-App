import 'dart:async';

import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/error/response_exception.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/choose_activity.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_age.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_gender.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/page_view_complete_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'page_view_complete_register_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockCubit;
  setUp((){
    mockCubit =MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockCubit);
    provideDummy<RegisterState>(const RegisterState());
     when(mockCubit.state).thenReturn(const RegisterState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));

  });
Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<RegisterCubit>.value(
        value: mockCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: PageViewCompeleteRegister()),
        ),
      ),
    );
  }

   testWidgets('verify PageViewCompeleteRegister structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(Logo), findsOneWidget);
    expect(find.byType(CustomLoadingCircleProgressIndictor), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.byType(Expanded), findsAtLeast(1));
  });


  testWidgets('verify initial page shows SelectGender tab', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(SelectGender), findsOneWidget);
  });

  testWidgets('verify CustomPopIcon is hidden on first page', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(CustomPopIcon), findsNothing);
    expect(find.byType(SizedBox), findsAtLeast(1));
  });

   testWidgets('verify tapping next button on first page navigates to second page',
      (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.byType(SelectGender), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
   await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pump(const Duration(milliseconds: 900));
    expect(find.byType(SelectAge), findsOneWidget);
  });
  
  testWidgets('verify success state shows success message and navigates to login',
    (tester) async {
  final stateController = StreamController<RegisterState>.broadcast();
  
  when(mockCubit.state).thenReturn(const RegisterState());
  when(mockCubit.stream).thenAnswer((_) => stateController.stream);

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => BlocProvider<RegisterCubit>.value(
              value: mockCubit,
              child: const SizeProvider(
                baseSize: Size(375, 812),
                height: 812,
                width: 375,
                child: Scaffold(body: PageViewCompeleteRegister()),
              ),
            ),
        '/login': (context) => const Scaffold(
              body: Center(child: Text('Login Screen')),
            ),
      },
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 900));

  for (int i = 0; i < 5; i++) {
    await tester.ensureVisible(find.byKey(const Key("page_view_button")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("page_view_button")));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 900));
  }

  expect(find.byType(ChooseActivity), findsOneWidget);

  const userEntity = UserEntity(
    goal: "Gain Weight",
    activityLevel: "level1",
    bodyInfo: BodyInfoEntity(
      height: 22,
      weight: 33,
    ),
    personalInfo: PersonalInfoEntity(
      age: 23,
      email: "test@gmail.com",
      firstName: "omar",
      lastName: "elsadany",
      gender: "male",
      id: "1",
      photo: "default.png",
    ),
  );

  await tester.ensureVisible(find.byKey(const Key("page_view_button")));
  await tester.pump();

  await tester.tap(find.byKey(const Key("page_view_button")));
  await tester.pump();

  verify(mockCubit.doIntent(intent: const RegisterFormIntent())).called(1);

  when(mockCubit.state).thenReturn(
    const RegisterState(
      registerStatus: StateStatus.success(userEntity),
    ),
  );
  stateController.add(
    const RegisterState(
      registerStatus: StateStatus.success(userEntity),
    ),
  );

  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));

  expect(find.text('Registered Successfully!'), findsOneWidget);

  await tester.pump(const Duration(seconds: 1));

  expect(find.text('Login Screen'), findsOneWidget);
  expect(find.byType(PageViewCompeleteRegister), findsNothing);

  await stateController.close();
});

testWidgets('verify failure state shows error message',
    (tester) async {
  final stateController = StreamController<RegisterState>.broadcast();
  
  when(mockCubit.state).thenReturn(const RegisterState());
  when(mockCubit.stream).thenAnswer((_) => stateController.stream);

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => BlocProvider<RegisterCubit>.value(
              value: mockCubit,
              child: const SizeProvider(
                baseSize: Size(375, 812),
                height: 812,
                width: 375,
                child: Scaffold(body: PageViewCompeleteRegister()),
              ),
            ),
        '/login': (context) => const Scaffold(
              body: Center(child: Text('Login Screen')),
            ),
      },
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 900));

  for (int i = 0; i < 5; i++) {
    await tester.ensureVisible(find.byKey(const Key("page_view_button")));
    await tester.pump();
    await tester.tap(find.byKey(const Key("page_view_button")));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 900));
  }

  expect(find.byType(ChooseActivity), findsOneWidget);


  await tester.ensureVisible(find.byKey(const Key("page_view_button")));
  await tester.pump();

  await tester.tap(find.byKey(const Key("page_view_button")));
  await tester.pump();

  verify(mockCubit.doIntent(intent: const RegisterFormIntent())).called(1);
 const errorMessage = "User Already exists";
  when(mockCubit.state).thenReturn(
    const RegisterState(
      registerStatus: StateStatus.failure(ResponseException(message:errorMessage )),
    ),
  );
  stateController.add(
    const RegisterState(
      registerStatus: StateStatus.failure(ResponseException(message: errorMessage)),
    ),
  );

  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));

  expect(find.text('User Already exists'), findsOneWidget);

  await tester.pump(const Duration(seconds: 1));

  expect(find.text('Login Screen'), findsNothing);
  expect(find.byType(PageViewCompeleteRegister), findsOneWidget);

  await stateController.close();
});

   tearDown(getIt.reset);
}