import 'dart:ui';
import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/home/presentation/view/widgets/logout/logout_dialog.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_settings_section.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_screen_settings_section_test.mocks.dart';

@GenerateMocks([
  ProfileCubit,
  AppLanguageConfig,
  SecurityCubit,
  HelpCubit,
  PrivacyPolicyCubit,
])
void main() {
  late MockProfileCubit mockProfileCubit;
  late MockAppLanguageConfig mockAppLanguageConfig;
  late MockSecurityCubit mockSecurityCubit;

  final getItInstance = GetIt.instance;

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    mockAppLanguageConfig = MockAppLanguageConfig();
    mockSecurityCubit = MockSecurityCubit();

    when(
      mockProfileCubit.stream,
    ).thenAnswer((_) => const Stream<ProfileState>.empty());

    when(mockProfileCubit.state).thenReturn(const ProfileState());

    when(mockProfileCubit.doIntent(any)).thenAnswer((_) async {});

    when(mockAppLanguageConfig.isEn()).thenReturn(true);
    when(mockAppLanguageConfig.selectedLocal).thenReturn('en');
    when(mockAppLanguageConfig.changeLocal(any)).thenAnswer((_) async {});

    when(mockSecurityCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockSecurityCubit.state).thenReturn(const SecurityState());

    getItInstance.registerFactory<ProfileCubit>(() => mockProfileCubit);
    getItInstance.registerFactory<AppLanguageConfig>(
      () => mockAppLanguageConfig,
    );

    getItInstance.registerFactory<SecurityCubit>(() => mockSecurityCubit);
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
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.editProfile:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Edit Profile Screen')),
                ),
              );
            case AppRoutes.changePassword:
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: Center(child: Text('Change Password Screen')),
                ),
              );
            case AppRoutes.loginRoute:
              return MaterialPageRoute(
                builder: (_) =>
                    const Scaffold(body: Center(child: Text('Login Screen'))),
              );
            default:
              if (settings.arguments is Widget) {
                return MaterialPageRoute(
                  builder: (_) => settings.arguments as Widget,
                );
              }
              return null;
          }
        },
        home: Scaffold(
          body: BlocProvider<ProfileCubit>(
            create: (context) => mockProfileCubit,
            child: const ProfileScreenSettingsSection(),
          ),
        ),
      ),
    );
  }

  group('ProfileScreenSettingsSection Widget Tests', () {
    testWidgets('renders structure correctly', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(BackdropFilter), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(SettingsItem), findsNWidgets(7));
    });

    testWidgets('applies blur effect correctly', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final backdropFilter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );

      expect(backdropFilter.filter, isA<ImageFilter>());
      expect(backdropFilter.filter.toString(), contains('blur'));
    });

    testWidgets('renders all settings items with correct icons', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      expect(find.byType(SettingsItem), findsNWidgets(7));

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.profileUserIcon,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.changePasswordProfileIcon,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.selectLanguageSvg,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.securitySvg,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.privacyIcon,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.helpSvg,
        ),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.logoutSvg,
        ),
        findsOneWidget,
      );
    });

    testWidgets('language switch works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      final switchWidget = tester.widget<Switch>(switchFinder);
      expect(switchWidget.value, true);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      verify(mockAppLanguageConfig.changeLocal(any)).called(1);
    });

    testWidgets('logout item has orange color', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final logoutItem = tester.widget<SettingsItem>(
        find.byWidgetPredicate(
          (widget) =>
              widget is SettingsItem &&
              widget.iconPath == AssetsManager.logoutSvg,
        ),
      );

      expect(logoutItem.titleColor, AppColors.orange);
      expect(logoutItem.iconColor, AppColors.orange);
    });

    testWidgets('all items are tappable except language switch', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final settingsItems = tester
          .widgetList<SettingsItem>(find.byType(SettingsItem))
          .toList();

      expect(settingsItems[0].onTap, isNotNull); // Edit Profile
      expect(settingsItems[1].onTap, isNotNull); // Change Password
      expect(settingsItems[2].onTap, isNull); // Language
      expect(settingsItems[3].onTap, isNotNull); // Security
      expect(settingsItems[4].onTap, isNotNull); // Privacy
      expect(settingsItems[5].onTap, isNotNull); // Help
      expect(settingsItems[6].onTap, isNotNull); // Logout
    });
  });

  group('ProfileScreenSettingsSection - Navigation Tests', () {
    testWidgets('navigates to edit profile screen when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final editProfileItem = find.byWidgetPredicate(
        (widget) =>
            widget is SettingsItem &&
            widget.iconPath == AssetsManager.profileUserIcon,
      );

      expect(editProfileItem, findsOneWidget);

      await tester.tap(editProfileItem);
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile Screen'), findsOneWidget);
    });

    testWidgets('navigates to change password screen when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final changePasswordItem = find.byWidgetPredicate(
        (widget) =>
            widget is SettingsItem &&
            widget.iconPath == AssetsManager.changePasswordProfileIcon,
      );

      expect(changePasswordItem, findsOneWidget);

      await tester.tap(changePasswordItem);
      await tester.pumpAndSettle();

      expect(find.text('Change Password Screen'), findsOneWidget);
    });

    // testWidgets('navigates to security screen when tapped', (tester) async {
    //   await tester.pumpWidget(
    //     SizeProvider(
    //       baseSize: const Size(375, 812),
    //       height: 812,
    //       width: 375,
    //       child: MaterialApp(
    //         localizationsDelegates: AppLocalizations.localizationsDelegates,
    //         supportedLocales: AppLocalizations.supportedLocales,
    //         locale: const Locale('en'),
    //         home: Scaffold(
    //           body: BlocProvider<ProfileCubit>(
    //             create: (context) => mockProfileCubit,
    //             child: const ProfileScreenSettingsSection(),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    //
    //   expect(find.byType(SecurityView), findsOneWidget);
    // });

    // testWidgets('navigates to privacy policy screen when tapped', (
    //   WidgetTester tester,
    // ) async {
    //   await tester.pumpWidget(prepareWidget());
    //   await tester.pumpAndSettle();
    //
    //   final privacyItem = find.byWidgetPredicate(
    //     (widget) =>
    //         widget is SettingsItem &&
    //         widget.iconPath == AssetsManager.privacyIcon,
    //   );
    //
    //   expect(privacyItem, findsOneWidget);
    //
    //   await tester.tap(privacyItem);
    //   await tester.pumpAndSettle();
    //
    //   expect(privacyItem, findsNothing);
    // });

    // testWidgets('navigates to help screen when tapped', (
    //   WidgetTester tester,
    // ) async {
    //   await tester.pumpWidget(prepareWidget());
    //   await tester.pumpAndSettle();
    //
    //   final helpItem = find.byWidgetPredicate(
    //     (widget) =>
    //         widget is SettingsItem && widget.iconPath == AssetsManager.helpSvg,
    //   );
    //
    //   expect(helpItem, findsOneWidget);
    //
    //   await tester.tap(helpItem);
    //   await tester.pumpAndSettle();
    //
    //   expect(helpItem, findsNothing);
    // });
  });

  group('ProfileScreenSettingsSection - Logout Tests', () {
    testWidgets('tapping logout shows dialog', (WidgetTester tester) async {
      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final logoutItem = find.byWidgetPredicate(
        (widget) =>
            widget is SettingsItem &&
            widget.iconPath == AssetsManager.logoutSvg,
      );

      expect(logoutItem, findsOneWidget);

      await tester.tap(logoutItem);
      await tester.pumpAndSettle();

      expect(find.byType(LogoutDialog), findsOneWidget);
    });
  });

  group('SettingsItem Widget Tests', () {
    Widget prepareSettingsItem({
      String? title,
      RichText? richText,
      Widget? trailing,
      Color? titleColor,
      Color? iconColor,
      bool showBorder = true,
      VoidCallback? onTap,
    }) {
      return SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: MaterialApp(
          home: Scaffold(
            body: SettingsItem(
              iconPath: AssetsManager.profileUserIcon,
              title: title,
              richText: richText,
              trailing: trailing,
              titleColor: titleColor,
              iconColor: iconColor,
              showBorder: showBorder,
              onTap: onTap,
            ),
          ),
        ),
      );
    }

    testWidgets('has correct layout structure', (WidgetTester tester) async {
      await tester.pumpWidget(prepareSettingsItem(title: 'Test'));
      await tester.pumpAndSettle();

      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('renders with title correctly', (WidgetTester tester) async {
      await tester.pumpWidget(prepareSettingsItem(title: 'Test Title'));
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders custom trailing widget', (WidgetTester tester) async {
      final trailing = Container(
        key: const Key('custom_trailing'),
        child: const Text('Custom'),
      );

      await tester.pumpWidget(
        prepareSettingsItem(title: 'Test', trailing: trailing),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('custom_trailing')), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('applies custom colors correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        prepareSettingsItem(
          title: 'Colored Item',
          titleColor: AppColors.white,
          iconColor: AppColors.orange,
        ),
      );
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(find.text('Colored Item'));
      expect(textWidget.style?.color, AppColors.white);
    });

    testWidgets('shows border when showBorder is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        prepareSettingsItem(title: 'Test', showBorder: true),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).border != null,
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
    });

    testWidgets('hides border when showBorder is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        prepareSettingsItem(title: 'Test', showBorder: false),
      );
      await tester.pumpAndSettle();

      final containers = tester.widgetList<Container>(find.byType(Container));

      bool hasNoBorder = true;
      for (final container in containers) {
        if (container.decoration is BoxDecoration) {
          final decoration = container.decoration as BoxDecoration;
          if (decoration.border != null) {
            hasNoBorder = false;
            break;
          }
        }
      }

      expect(hasNoBorder, true);
    });

    testWidgets('onTap callback works', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        prepareSettingsItem(
          title: 'Test Title',
          onTap: () {
            tapped = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(tapped, true);
    });

    testWidgets('renders default arrow icon when no trailing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(prepareSettingsItem(title: 'Test'));
      await tester.pumpAndSettle();

      final icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.icon, Icons.arrow_forward_ios);
      expect(icon.color, AppColors.orange);
    });
  });
}
