import 'package:fitness/features/auth/presentation/views/widgets/register/register_screen_view_body.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
    
      body: RegisterScreenViewBody(),
    );
  }
}