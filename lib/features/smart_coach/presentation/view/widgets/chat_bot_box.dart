import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
import 'package:flutter/material.dart';

class ChatBotBox extends StatelessWidget {
  const ChatBotBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerDetialsCompleteRegister(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.setWidth(32),
          vertical: context.setHight(20)
        ),
        child: Column(
          children: [
            Text(
              context.loc.howCanIAssistYouToday,
              textAlign: TextAlign.center,
              style: getBoldStyle(
                color: AppColors.white,
                fontSize: context.setSp(FontSize.s24),
              ),
            ),
            SizedBox(height: context.setHight(8)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.smartCoach);
              },
              child: Text(context.loc.getStarted),
            ),
          ],
        ),
      ),
    );
  }
}
