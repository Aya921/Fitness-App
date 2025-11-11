import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_profile_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_settings_section.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_view_body.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_screen_view_body_test.mocks.dart';

@GenerateMocks([ProfileCubit, AppLanguageConfig])
void main() {
  late MockProfileCubit mockProfileCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;

  final getItInstance = GetIt.instance;

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();

    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => const Stream<ProfileState>.empty());

    when(mockProfileCubit.state).thenReturn(const ProfileState());

    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    getItInstance.registerFactory<ProfileCubit>(() => mockProfileCubit);
    getItInstance.registerFactory<AppLanguageConfig>(
      () => mockAppLanguageConfig,
    );
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
          body: BlocProvider<ProfileCubit>(
            create: (context) => mockProfileCubit,
            child: const ProfileScreenViewBody(),
          ),
        ),
      ),
    );
  }

  testWidgets('verify structure', (WidgetTester tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    expect(find.byType(HomeBackground), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(ProfileScreenProfileSection), findsOneWidget);
    expect(find.byType(ProfileScreenSettingsSection), findsOneWidget);
  });

  testWidgets('HomeBackground should have correct properties', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final homeBackground = tester.widget<HomeBackground>(
      find.byType(HomeBackground),
    );
    expect(homeBackground.image, equals(AssetsManager.homeBackground));
    expect(homeBackground.alpha, equals(.12));
  });
}
