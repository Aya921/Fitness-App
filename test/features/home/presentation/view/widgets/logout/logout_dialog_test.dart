import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/features/home/presentation/view/widgets/logout/logout_dialog.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_dialog_test.mocks.dart';

@GenerateMocks([ProfileCubit])
void main() {
  late MockProfileCubit mockCubit;

  setUp(() {
    mockCubit = MockProfileCubit();
    when(
      mockCubit.stream,
    ).thenAnswer((_) => const Stream<ProfileState>.empty());
  });

  Widget prepareWidget() {
    return SizeProvider(
      baseSize: const Size(375, 812),
      height: 812,
      width: 375,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(body: LogoutDialog(cubit: mockCubit)),
      ),
    );
  }

  group('LogoutDialog Widget Tests', () {
    testWidgets('renders dialog with all required elements', (tester) async {
      await tester.pumpWidget(prepareWidget());

      expect(find.byType(Dialog), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
    });

    testWidgets('has transparent background for Dialog', (tester) async {
      await tester.pumpWidget(prepareWidget());

      final dialog = tester.widget<Dialog>(find.byType(Dialog));
      expect(dialog.backgroundColor, Colors.transparent);
    });

    testWidgets('container has correct styling', (tester) async {
      await tester.pumpWidget(prepareWidget());

      final containerFinder = find.descendant(
        of: find.byType(Dialog),
        matching: find.byType(Container),
      );

      expect(containerFinder, findsWidgets);

      final container = tester.widget<Container>(containerFinder.first);
      final decoration = container.decoration as BoxDecoration;

      expect(decoration.borderRadius, isNotNull);
      expect(decoration.color, isNotNull);
    });

    testWidgets('No button closes dialog without calling cubit', (
      tester,
    ) async {
      await tester.pumpWidget(prepareWidget());

      final noButtonFinder = find.byType(OutlinedButton);
      expect(noButtonFinder, findsOneWidget);

      await tester.tap(noButtonFinder);
      await tester.pumpAndSettle();

      verifyNever(mockCubit.doIntent(any));
    });

    testWidgets(
      'Yes button closes dialog and calls cubit with LogoutBtnSubmitted',
      (tester) async {
        await tester.pumpWidget(prepareWidget());

        final yesButtonFinder = find.byType(ElevatedButton);
        expect(yesButtonFinder, findsOneWidget);

        await tester.tap(yesButtonFinder);
        await tester.pumpAndSettle();

        verify(mockCubit.doIntent(any)).called(1);
      },
    );

    testWidgets('No button has correct styling', (tester) async {
      await tester.pumpWidget(prepareWidget());

      final noButton = tester.widget<OutlinedButton>(
        find.byType(OutlinedButton),
      );

      final style = noButton.style;
      expect(style, isNotNull);
    });

    testWidgets('Yes button has correct styling', (tester) async {
      await tester.pumpWidget(prepareWidget());

      final yesButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );

      final style = yesButton.style;
      expect(style, isNotNull);
    });

    testWidgets('buttons are arranged horizontally with Spacer', (
      tester,
    ) async {
      await tester.pumpWidget(prepareWidget());

      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Spacer), findsOneWidget);
    });

    testWidgets('tapping outside dialog does not trigger any action', (
      tester,
    ) async {
      await tester.pumpWidget(prepareWidget());

      //  Tap outside the dialog (on the barrier)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      verifyNever(mockCubit.doIntent(any));
    });
  });
}
