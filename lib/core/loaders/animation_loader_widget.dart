import 'package:fitness/core/responsive/size_helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionWidget,
    this.style,
  });

  final String text;
  final String animation;
  final bool showAction;
  final Widget? actionWidget;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Lottie.asset(
              animation,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.setMinSize(16)),
            child: Text(
              text,
              style:
                  style ??
                  theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
           SizedBox(height: context.setMinSize(24)),
          Visibility(
            visible: showAction,
            child: actionWidget ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
