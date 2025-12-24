import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/login/social_icon_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      home: Scaffold(body: Center(child: child)),
    ),
  );
}

void main() {
  const testIcon = 'assets/icons/google.svg';

  group('SocialIconBuilder Widget Tests', () {
    testWidgets('renders correctly with given SVG icon', (tester) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(const SocialIconBuilder(icon: testIcon)),
      );

      // Assert
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('has circular shape and correct background color', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(const SocialIconBuilder(icon: testIcon)),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;

      // Assert
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, AppColors.gray[AppColors.colorCode90]);
    });

    testWidgets('has correct width and height according to context', (
      tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(const SocialIconBuilder(icon: testIcon)),
      );

      final containerFinder = find.byType(Container);
      final renderBox = tester.renderObject<RenderBox>(containerFinder);

      final width = renderBox.size.width;
      final height = renderBox.size.height;

      // Assert
      expect(width, 32);
      expect(height, 32);
    });

    testWidgets('fits the SVG inside circle properly', (tester) async {
      // Arrange
      await tester.pumpWidget(
        makeTestableWidget(const SocialIconBuilder(icon: testIcon)),
      );
      final svgPicture = tester.widget<SvgPicture>(find.byType(SvgPicture));

      // Assert
      expect(svgPicture.fit, BoxFit.scaleDown);
    });
  });
}
