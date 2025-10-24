import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/user/user_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //// 👉👉👉👉👉👉👉👉for testing the flow👈👈👈👈👈👈👈👈👈
  @override
  Widget build(BuildContext context) {
    final user = UserManager().currentUser;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Name: ${user?.personalInfo?.firstName ?? "Guest"}'),
        Text('Email: ${user?.personalInfo?.email ?? "N/A"}'),
        Text('Age: ${user?.personalInfo?.age ?? "-"}'),
      ],
    ),
    ),

    );
  }
}
