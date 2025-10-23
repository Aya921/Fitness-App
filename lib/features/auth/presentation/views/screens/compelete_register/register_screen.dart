import 'package:fitness/core/widget/app_background.dart';
import 'package:flutter/material.dart';

import '../../widgets/compelete_register/page_view.dart';

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
