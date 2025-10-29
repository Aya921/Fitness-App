import 'package:fitness/core/widget/app_background.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/page_view_complete_register.dart';
import 'package:flutter/material.dart';


class CompeleteRegisterScreen extends StatelessWidget {
  const CompeleteRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            Expanded(child: PageViewCompeleteRegister()),
          ],
        ),
      ),
    );
  }
}
