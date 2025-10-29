import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/cupertino.dart';

class ChatAiScreen extends StatelessWidget {
  const ChatAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(context.loc.chatAi,style: getBoldStyle(color: AppColors.white,
        fontSize: context.setSp(30)
    ),),
  ],
)
    );
  }
}
