import 'package:fitness/core/constants/assets_maneger.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custum_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('test custum text field struture when passwrod is false ...', (
    WidgetTester tester,
  ) async {
    final TextEditingController controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: "Email",
              icon: AssetsManeger.lock,
              validator: null,
            ),
          ),
        ),
      ),
    );

    final context = tester.element(find.byType(TextField));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Padding), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is TextField &&
            widget.controller == controller &&
            widget.obscureText == false &&
            widget.decoration!.suffixIcon == null &&
            widget.decoration!.hintText == "Email" &&
            widget.style ==
                getRegularStyle(
                  color: AppColors.white,
                  fontSize: context.setSp(FontSize.s16),
                ),
      ),
      findsNWidgets(1),
    );

    final textFormFieldFinder = find.byType(TextField);
    final textFormField = tester.widget<TextField>(textFormFieldFinder);

    final prefix = textFormField.decoration!.prefixIcon;
    expect(prefix, isA<Padding>());

    final paddingWidget = prefix as Padding;
    expect(
      paddingWidget.padding,
      EdgeInsets.only(left: context.setWidth(20), right: context.setWidth(10)),
    );

    final image = paddingWidget.child as Image;
    expect(image.image, isA<AssetImage>());
    final assetImage = image.image as AssetImage;
    expect(assetImage.assetName, AssetsManeger.lock);
  });

  testWidgets('test custum text field struture when passwrod is true and initial icon visibility is off and when click on it switch to visiblility icon ...', (


    WidgetTester tester,
  ) async {
    final TextEditingController controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SizeProvider(
          baseSize: const Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(
            body: CustomTextField(
              controller: controller,
              hintText: "Email",
              icon: AssetsManeger.lock,
              validator: null,
              isPassword: true,
            ),
          ),
        ),
      ),
    );

 
    expect(find.byType(IconButton), findsOneWidget);
    final icon = tester.widget<Icon>(find.byIcon(Icons.visibility_off));
 
    expect(icon.icon, Icons.visibility_off);
    expect(icon.color, AppColors.white);

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    final toggledIcons = tester.widget<Icon>(find.byIcon(Icons.visibility));
    expect(toggledIcons.icon, Icons.visibility);
  });
}
