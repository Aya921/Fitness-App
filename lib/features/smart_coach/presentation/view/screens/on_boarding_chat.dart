import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/robot_bg.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/user_profile_section.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_bot_box.dart';

class OnBoardingChat extends StatefulWidget {
  const OnBoardingChat({super.key});

  @override
  State<OnBoardingChat> createState() => _OnBoardingChatState();
}

class _OnBoardingChatState extends State<OnBoardingChat> {

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        SizedBox(height: context.setHight(25)),
        const UserProfileSection(),
        SizedBox(height: context.setHight(25)),
        const RobotLogo(),
        SizedBox(height: context.setHight(20)),
        const ChatBotBox(),
        const Spacer(flex: 1),
      ],
    );
  }
}
