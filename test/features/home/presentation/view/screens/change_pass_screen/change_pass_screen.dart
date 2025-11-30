import 'package:fitness/core/enum/request_state.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/core/widget/blur_container.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/presentation/views/widgets/forget_pass/text_section.dart';
import 'package:fitness/features/home/presentation/view/screens/change_pass_screen/change_pass_screen.dart';
import 'package:fitness/features/home/presentation/view/widgets/change_pass/change_pass_section.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/change_pass_view_model/change_pass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'change_pass_screen.mocks.dart';

@GenerateMocks([ChangePassCubit])
void main() {
  final getItInstance = GetIt.instance;
  late MockChangePassCubit mockChangePassCubit;

  setUp(() {
    mockChangePassCubit = MockChangePassCubit();

    when(
      mockChangePassCubit.stream,
    ).thenAnswer((_) => const Stream<ChangePassState>.empty());

    when(mockChangePassCubit.state).thenReturn(const ChangePassState());

    getItInstance.registerFactory<ChangePassCubit>(() => mockChangePassCubit);
  });


  tearDown(getItInstance.reset);

  group('ChangePassScreen Widget Tests', () {

    Widget prepareWidget() {
      return const SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: ChangePassScreen()
        ),
      );
    }

    testWidgets('verify ChangePassScreen structure',
            (WidgetTester tester) async {
          // Arrange & Act
          await tester.pumpWidget(prepareWidget());
          await tester.pumpAndSettle();

          // Assert
          expect(find.byType(Scaffold), findsOneWidget);
          expect(find.byType(AppBackground), findsOneWidget);
          expect(find.byType(SafeArea), findsOneWidget);
          expect(find.byType(CustomPopIcon), findsOneWidget);
          expect(find.byType(TextSection), findsOneWidget);
          expect(find.byType(BlurContainer), findsOneWidget);
          expect(find.byType(ChangePassSection), findsOneWidget);
          expect(find.byType(SingleChildScrollView), findsOneWidget);
          expect(find.byType(Logo), findsOneWidget);
          expect(find.byType(Spacer), findsNWidgets(3));
        });

    testWidgets('should navigate back when CustomPopIcon is tapped', (
        WidgetTester tester,
        ) async {
      when(mockChangePassCubit.state).thenReturn(
        const ChangePassState(
          changePassStatus:
          StateStatus<void>.initial(),
        ),
      );

      await tester.pumpWidget(prepareWidget());
      await tester.pumpAndSettle();

      final customPopIcon = find.byType(CustomPopIcon);
      expect(customPopIcon, findsOneWidget);

      await tester.tap(customPopIcon);
      await tester.pumpAndSettle();

      expect(find.byType(ChangePassScreen), findsNothing);
    });

    testWidgets('should have correct crossAxisAlignment and mainAxisAlignment',
            (WidgetTester tester) async {
          // Arrange & Act
          await tester.pumpWidget(prepareWidget());

          // Assert
          final Column column = tester.widget(find.byType(Column).first);
          expect(column.crossAxisAlignment, CrossAxisAlignment.start);
          expect(column.mainAxisAlignment, MainAxisAlignment.center);
        });

  });
}