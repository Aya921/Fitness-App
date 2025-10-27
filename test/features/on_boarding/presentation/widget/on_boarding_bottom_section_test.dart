import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/features/on_boarding/presentation/widget/on_boarding_bottom_section.dart';
import 'package:fitness/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/constants/constants.dart';

void main() {
  testWidgets('OnBoardingBottomSection renders and shows first title', (WidgetTester tester) async {
    final cubit = OnBoardingCubit();

    await tester.pumpWidget(
      SizeProvider(
        height: 812,
        width: 375,
        baseSize: const Size(375, 812),
        child: MaterialApp(
          home: BlocProvider.value(
            value: cubit,
            child: OnBoardingBottomSection(
              titles: cubit.titles,
              images: cubit.images,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text(cubit.titles[0]), findsOneWidget);
    expect(find.text(Constants.next), findsOneWidget);
  });
}
