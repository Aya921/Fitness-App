import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/l10n/translations/app_localizations.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/screen/complete_register_screen.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/page_view_complete_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'complete_register_screen_test.mocks.dart';

@GenerateMocks([RegisterCubit])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterCubit mockCubit;
  setUp((){
    mockCubit =MockRegisterCubit();
    getIt.registerFactory<RegisterCubit>(() => mockCubit);
    provideDummy<RegisterState>(const RegisterState());
     when(mockCubit.state).thenReturn(const RegisterState());
    when(
      mockCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const RegisterState()]));

  });
Widget prepareWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: BlocProvider<RegisterCubit>.value(
        value: mockCubit,
        child: const SizeProvider(
          baseSize: Size(375, 812),
          height: 812,
          width: 375,
          child: Scaffold(body: CompeleteRegisterScreen()),
        ),
      ),
    );
  }

  testWidgets('verify CompeleteRegisterScreen structure', (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 900));
    expect(find.byType(AppBackground), findsOneWidget);
    expect(find.byType(Column), findsAtLeast(1));
    expect(find.byType(Expanded), findsAtLeast(1));
    expect(find.byType(PageViewCompeleteRegister), findsOneWidget);
  });

  testWidgets('verify Align widget centers the progress indicator',
      (tester) async {
    await tester.pumpWidget(prepareWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    final align = tester.widget<Align>(
      find.ancestor(
        of: find.byType(CustomLoadingCircleProgressIndictor),
        matching: find.byType(Align),
      ),
    );

    expect(align.alignment, Alignment.center);
  });
   tearDown(getIt.reset);
}