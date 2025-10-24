import 'package:fitness/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


void showCustomSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 16, color: AppColors.white),
    ),
    backgroundColor: AppColors.orange, 
    behavior: SnackBarBehavior.floating, 
    margin: const EdgeInsets.all(16), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), 
    ),
   // duration: const Duration(seconds: 3),
    elevation: 6,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
