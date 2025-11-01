import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/presentation/view/widgets/exercises_screen/video_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  Widget prepareWidget() {
    return const SizeProvider(
      baseSize: Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
        home: Scaffold(
          body: VideoErrorDialog(message: 'Something went wrong'),
        ),
      ),
    );
  }

  group('VideoErrorDialog Widget Tests', () {
    testWidgets('renders title, message, and back button correctly', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(prepareWidget());
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.error_outline), findsOneWidget);
        expect(find.textContaining('Error', findRichText: true), findsOneWidget);
        expect(find.textContaining('Back', findRichText: true), findsOneWidget);
      });
    });

    testWidgets('closes the dialog when back button is pressed', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SizeProvider(
              baseSize: const Size(375, 812),
              height: 812,
              width: 375,
              child: Builder(
                builder: (context) => Scaffold(
                  body: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => const SizeProvider(
                            baseSize: Size(375, 812),
                            height: 812,
                            width: 375,
                            child:  VideoErrorDialog(message: 'Test error'),
                          ),
                        );
                      },
                      child: const Text('Show Dialog'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);

        await tester.tap(find.textContaining('Back', findRichText: true));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
      });
    });
  });
}
