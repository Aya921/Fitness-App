import 'dart:ui';

import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonLoadingExercises extends StatelessWidget {
  const SkeletonLoadingExercises({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.setWidth(16),
        vertical: context.setHight(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.setWidth(20)),
        child: Container(
          width: context.setWidth(343),
          height: context.setHight(430),
          decoration: BoxDecoration(
            color: AppColors.gray[90]?.withValues(alpha: 0.7),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Skeletonizer(
              enabled: true,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 6,
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.gray[50],
                  thickness: context.setHight(0.2),
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            context.setWidth(30),
                          ),
                          child: Container(
                            height: context.setHight(88),
                            width: context.setWidth(81),
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        SizedBox(width: context.setWidth(10)),
                        SizedBox(
                          width: context.setWidth(180),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: context.setHight(18),
                                width: context.setWidth(120),
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                              SizedBox(height: context.setHight(8)),
                              Container(
                                height: context.setHight(14),
                                width: context.setWidth(80),
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: context.setWidth(24),
                          height: context.setWidth(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
