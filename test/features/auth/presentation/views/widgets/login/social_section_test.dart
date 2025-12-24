import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_icon_builder.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget makeTestableWidget(Widget child) {
  return SizeProvider(
    baseSize: const Size(375, 812),
    height: 812,
    width: 375,
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('SocialSection Widget Tests', () {
    testWidgets('renders correctly all main elements', (tester) async {
      // Arrange
      await tester.pumpWidget(makeTestableWidget(const SocialSection()));

      // Assert
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsNWidgets(2));
      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(SocialIconBuilder), findsNWidgets(3));
    });

    testWidgets('has correct divider color and thickness', (tester) async {
      //Arrange
      await tester.pumpWidget(makeTestableWidget(const SocialSection()));

      final dividers = tester
          .widgetList<Divider>(find.byType(Divider))
          .toList();

      //Assert
      for (final divider in dividers) {
        expect(divider.thickness, 1);
        expect((divider.color?.withOpacity(1))?.value, AppColors.white.value);
      }
    });

    testWidgets('renders social icons with correct asset paths', (
      tester,
    ) async {
      //Arrange
      await tester.pumpWidget(makeTestableWidget(const SocialSection()));

      final socialIcons = tester.widgetList<SocialIconBuilder>(
        find.byType(SocialIconBuilder),
      );

      //Assert
      expect(
        socialIcons.map((e) => e.icon),
        equals([
          AssetsManager.facecbookSvg,
          AssetsManager.gooleSvg,
          AssetsManager.appleSvg,
        ]),
      );
    });
  });
}
