import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/robot_bg.dart';
import 'package:fitness/features/smart_coach/presentation/view/widgets/user_profile_section.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_cubit.dart';
import 'package:fitness/features/smart_coach/presentation/view_model/smart_coach_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_bot_box.dart';

class OnBoardingChat extends StatelessWidget {
  const OnBoardingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SmartCoachCubit>()..loadUserData(),
      child: Column(
        children: [
          SizedBox(height: context.setHight(25)),
          BlocBuilder<SmartCoachCubit, SmartCoachChatState>(
            builder: (context, state) {
              return UserProfileSection(
                firstName: context.read<SmartCoachCubit>().name,
              );
            },
          ),
          SizedBox(height: context.setHight(25)),
          const RobotLogo(),
          SizedBox(height: context.setHight(20)),
          const ChatBotBox(),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
