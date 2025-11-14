import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/body_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/personal_info_entity.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/explore/explore_screen_profile_section.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/explore_view_model/explore_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'explore_screen_profile_section_test.mocks.dart';

@GenerateMocks([ExploreCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExploreCubit mockExploreCubit;

  /// Fake user data
  const fakeUser = AuthEntity(
    message: 'ss',
    token: 'ss',
    user: UserEntity(
     activityLevel: 'ss',
     createdAt: 'ss',
     goal: 'ss',
     bodyInfo: BodyInfoEntity(
      height: 22,
      weight: 22
     ) ,
     personalInfo: PersonalInfoEntity(
      firstName: 'omar',
      lastName: 'hassan',
      id: '1',
      age: 23,
      email: 'test@email.com',
      gender: 'male',
      photo: 'https://example.com/photo.jpg',
     )
    ),
  );

  const successState = ExploreState(
    userData: StateStatus.success(fakeUser),
  );


  setUp(() {
    mockExploreCubit = MockExploreCubit();

    provideDummy<ExploreState>(const ExploreState());
  });

  Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<ExploreCubit>.value(
        value: mockExploreCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: ExploreScreenProfileSection(),
          ),
        ),
      ),
    );
  }


  testWidgets("verify structure", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });


  testWidgets("shows correct greeting text when success", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    expect(find.text("${l10n.hiHomeText} omar,"), findsOneWidget);
    expect(find.text(l10n.letsStartDoingYourDay), findsOneWidget);
  });

 
  testWidgets("profile image loads correctly", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    final img = tester.widget<CachedNetworkImage>(
      find.byType(CachedNetworkImage),
    );

    expect(img.imageUrl, equals(fakeUser.user!.personalInfo!.photo));
  });


 
  testWidgets("layout alignment checks", (tester) async {
    when(mockExploreCubit.state).thenReturn(successState);
    when(mockExploreCubit.stream).thenAnswer((_) => Stream.value(successState));

    await tester.pumpWidget(prepareWidget());
    await tester.pump();

    final row = tester.widget<Row>(find.byType(Row));
    expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);

    final column = tester.widget<Column>(
      find.byWidgetPredicate(
        (w) => w is Column && w.crossAxisAlignment == CrossAxisAlignment.start,
      ),
    );
    expect(column.crossAxisAlignment, CrossAxisAlignment.start);
  });
}
