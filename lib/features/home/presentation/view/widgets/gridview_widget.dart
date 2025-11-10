import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widget/custom_card_fitness.dart';

class GridviewWidget extends StatelessWidget {
  final List<String> images;
  final List<String> titles;
  const GridviewWidget({super.key, required this.images, required this.titles});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: context.setWidth(16), vertical: context.setHight(5)),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          return CustomCardFitness(
            image: images[index % images.length],
            title: titles[index % titles.length],
          );
        },
      ),
    );
  }
}
