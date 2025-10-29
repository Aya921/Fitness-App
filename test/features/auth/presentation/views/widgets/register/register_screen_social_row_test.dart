import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_social_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget prepareWidget() {
    return const MaterialApp(
      home: SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(body: RegisterScreenSocialRow()),
      ),
    );
  }

  testWidgets('verify RegisterScreenSocialRow structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(RegisterScreenSocialRow));

    expect(find.byType(Row), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(3));
    expect(
  find.byWidgetPredicate(
    (widget) =>
        widget is SizedBox &&
        widget.width == context.setWidth(16) &&
        widget.height == null
  ),
  findsNWidgets(2),
);
    expect(find.byType(SvgPicture), findsNWidgets(3));
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Row &&
            widget.mainAxisAlignment == MainAxisAlignment.center &&
            widget.children.length == 5 &&
            widget.children[0] is Container &&
            widget.children[1] is SizedBox &&
            widget.children[2] is Container &&
            widget.children[3] is SizedBox &&
            widget.children[4] is Container,
      ),
      findsOneWidget,
    );

    final containers = tester.widgetList<Container>(find.byType(Container)).toList();
    for (final c in containers) {
      final decoration = c.decoration as BoxDecoration;
      expect(decoration.shape, BoxShape.circle);
      expect(decoration.color, AppColors.gray[AppColors.colorCode90]);
    }

    final containerFinder = find.byType(Container).first;
final size = tester.getSize(containerFinder);

expect(size.width, context.setWidth(32));
expect(size.height, context.setHight(32));
  });
}
