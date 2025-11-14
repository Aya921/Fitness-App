import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/responsive/size_provider.dart';
import 'package:fitness/core/widget/custom_card_fitness.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/widgets/gym/gridview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final fakeMuscles = [
    const MuscleEntity(id: "1", name: "Chest Upper", image: "img1.png"),
    const MuscleEntity(id: "2", name: "Chest Lower", image: "img2.png"),
  ];

  Widget prepareWidget() {
    return MaterialApp(
      routes: {
        AppRoutes.exercises: (_) => const Scaffold(body: Text("Exercises Page")),
      },
      home: const SizeProvider(
        baseSize: Size(375, 812),
        height: 812,
        width: 375,
        child: Scaffold(
          body: SizedBox(),
        ),
      ),
    );
  }

  group("GridviewWidget Tests", () {
    testWidgets("renders correct number of items", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: GridviewWidget(randomMusclesData: fakeMuscles),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(2));
      expect(find.byType(CustomCardFitness), findsNWidgets(2));
    });

    testWidgets("displays correct muscle names", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: GridviewWidget(randomMusclesData: fakeMuscles),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Chest Upper"), findsOneWidget);
      expect(find.text("Chest Lower"), findsOneWidget);
    });

    testWidgets("tapping an item navigates to exercises page with arguments",
        (tester) async {
      late MuscleEntity receivedArgument;

      await tester.pumpWidget(
        MaterialApp(
          routes: {
            AppRoutes.exercises: (context) {
              receivedArgument =
                  ModalRoute.of(context)!.settings.arguments as MuscleEntity;
              return const Scaffold(body: Text("Exercises Page"));
            },
          },
          home: SizeProvider(
            baseSize: const Size(375, 812),
            height: 812,
            width: 375,
            child: Scaffold(
              body: GridviewWidget(randomMusclesData: fakeMuscles),
            ),
          ),
        ),
      );

      await tester.pump();


      await tester.tap(find.text("Chest Upper"));
      await tester.pumpAndSettle();

      expect(find.text("Exercises Page"), findsOneWidget);
      expect(receivedArgument.id, "1");
      expect(receivedArgument.name, "Chest Upper");
    });
  });
}
