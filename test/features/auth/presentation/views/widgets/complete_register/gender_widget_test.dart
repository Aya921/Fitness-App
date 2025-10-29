import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/gender_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const testIconPath = 'assets/icons/male.svg';
  const testTitle = 'Male';

  Widget prepareWidget({
    required String iconData,
    required String title,
    bool isSelected = false,
    void Function()? onTap,
  }) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SizeProvider(
        baseSize: const Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: Center(
            child: GenderWidget(
              iconData: iconData,
              title: title,
              isSelected: isSelected,
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('verify GenderWidget structure', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();

    expect(find.byType(InkWell), findsOneWidget);
    expect(find.byType(AnimatedContainer), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.text(testTitle), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(4));
    expect(find.byType(FittedBox), findsNWidgets(2));
    expect(find.byType(Flexible), findsOneWidget);
  });

  testWidgets('verify AnimatedContainer has correct dimensions', (
    tester,
  ) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(GenderWidget));
    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    expect(animatedContainer.constraints?.minWidth, context.setWidth(95));
    expect(animatedContainer.constraints?.minHeight, context.setHight(95));
  });

  testWidgets('verify AnimatedContainer has correct duration', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    expect(animatedContainer.duration, const Duration(milliseconds: 300));
  });

  testWidgets('verify AnimatedContainer has correct padding', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(GenderWidget));
    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );

    expect(
      animatedContainer.padding,
      EdgeInsets.symmetric(
        vertical: context.setMinSize(9.45),
        horizontal: context.setMinSize(29.92),
      ),
    );
  });

  testWidgets('verify unselected state has transparent background', (
    tester,
  ) async {
    await tester.pumpWidget(
      prepareWidget(
        iconData: testIconPath,
        title: testTitle,
        isSelected: false,
      ),
    );
    await tester.pumpAndSettle();

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = animatedContainer.decoration as BoxDecoration;

    expect(decoration.color, Colors.transparent);
  });

  testWidgets('verify selected state has orange background', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle, isSelected: true),
    );
    await tester.pumpAndSettle();

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = animatedContainer.decoration as BoxDecoration;

    expect(decoration.color, AppColors.orange[AppColors.baseColor]);
  });

  testWidgets('verify unselected state has white border', (tester) async {
    await tester.pumpWidget(
      prepareWidget(
        iconData: testIconPath,
        title: testTitle,
        isSelected: false,
      ),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(GenderWidget));
    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = animatedContainer.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(border.top.color, AppColors.white);
    expect(border.top.width, context.setWidth(1));
  });

  testWidgets('verify selected state has orange border', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle, isSelected: true),
    );
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(GenderWidget));
    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = animatedContainer.decoration as BoxDecoration;
    final border = decoration.border as Border;

    expect(border.top.color, AppColors.orange[AppColors.baseColor]);
    expect(border.top.width, context.setWidth(1));
  });

  testWidgets('verify BoxDecoration has circular shape', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();

    final animatedContainer = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = animatedContainer.decoration as BoxDecoration;

    expect(decoration.shape, BoxShape.circle);
  });

  testWidgets('verify Text has correct content', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: 'Female'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Female'), findsOneWidget);
  });

  testWidgets('verify Text has correct content', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: 'Male'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Male'), findsOneWidget);
  });

  testWidgets('verify Text has correct style', (tester) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: testTitle),
    );
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(GenderWidget));
    final textWidget = tester.widget<Text>(find.text(testTitle));
    final textStyle = textWidget.style!;
    expect(textStyle.color, AppColors.white);
    expect(textStyle.fontSize, context.setSp(FontSize.s12));
    expect(textStyle.fontWeight, FontWeight.w600); // SemiBold
  });

  testWidgets('verify different titles are displayed correctly', (
    tester,
  ) async {
    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: 'Male'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Male'), findsOneWidget);

    await tester.pumpWidget(
      prepareWidget(iconData: testIconPath, title: 'Female'),
    );
    await tester.pumpAndSettle();

    expect(find.text('Female'), findsOneWidget);
    expect(find.text('Male'), findsNothing);
  });
}
