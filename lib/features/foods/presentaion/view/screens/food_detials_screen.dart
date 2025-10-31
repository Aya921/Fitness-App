import 'package:fitness/features/foods/presentaion/view/widgets/food_detials_body.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widget/home_back_ground.dart';




class FoodDetialsScreen extends StatelessWidget {
  final int index;
  const FoodDetialsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBackground(
        alpha: 0.12,
        child: SafeArea(
          child: FoodDetialsBody(index: index),
        ),
      ),
    );
  }

}
