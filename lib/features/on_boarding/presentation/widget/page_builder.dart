import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/on_boarding_cubit.dart';
import '../cubit/on_boarding_intent.dart';

class PageBuilder extends StatelessWidget {
  final List<String> images;
  const PageBuilder({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Column(
      children: [
        SizedBox(height: context.setHight(20)),
        Expanded(
          flex: 11,
          child: PageView.builder(
            controller: cubit.controller(),
            itemCount: images.length,
            onPageChanged: (index) {
              cubit.intent(PageChangedIntent(index));
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: context.setHight(5)),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    cubit.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),
        const Expanded(
          flex: 3,
          child: SizedBox(),
        ),
      ],
    );
  }
}
