
import 'package:fitness/core/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';

abstract class FullScreenLoader {
  static void openLoadingDialog({
    required String text,
    required String animation,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: AnimationLoaderWidget(text: text, animation: animation),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void stopLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
