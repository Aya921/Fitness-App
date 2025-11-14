import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/presentation/view/screens/tabs/profile_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';

import 'profile_screen_test.mocks.dart';

@GenerateMocks([ProfileCubit, AppLanguageConfig])
void main() {
  late MockProfileCubit mockProfileCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;

  final getItInstance = GetIt.instance;

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();

    when(mockProfileCubit.stream)
        .thenAnswer((_) => const Stream<ProfileState>.empty());

    when(mockProfileCubit.state).thenReturn(const ProfileState());

    when(mockProfileCubit.doIntent(any)).thenAnswer((_) async {});

    // Mock AppLanguageConfig methods
    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    getItInstance.registerFactory<ProfileCubit>(() => mockProfileCubit);
    getItInstance.registerFactory<AppLanguageConfig>(() => mockAppLanguageConfig);
  });

  tearDown(getItInstance.reset);

  Widget prepareWidget() {
    return const SizeProvider(
      baseSize: Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: ProfileScreen(),
      ),
    );
  }

  testWidgets('verify structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(BlocProvider<ProfileCubit>), findsOneWidget);
    expect(find.byType(ProfileScreenViewBody), findsOneWidget);
  });


  testWidgets('ProfileCubit should call GetLoggedUserIntent on init',
          (WidgetTester tester) async {
        await tester.pumpWidget(prepareWidget());
        await tester.pumpAndSettle();

        // Verify doIntent called once with GetLoggedUserIntent
        verify(mockProfileCubit.doIntent(argThat(isA<GetLoggedUserIntent>())))
            .called(1);
      });
}