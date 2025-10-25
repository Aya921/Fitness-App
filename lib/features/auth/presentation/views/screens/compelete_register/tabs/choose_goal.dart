import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseGoal extends StatelessWidget {
  const ChooseGoal({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String>goals=[
      context.loc.gainWeight,
      context.loc.loseWeight,
      context.loc.getFitter,
      context.loc.gainMoreFlexible,
      context.loc.learnTheBasic
    ];

    return
BlocBuilder<RegisterCubit,RegisterState>(builder: (context,state){
  return       Column(
    children: [
      ...List.generate(goals.length, (index){
        return SelectWidgetItem(
          isSelected:state.goal==goals[index],
            onTap: (){
context.read<RegisterCubit>().doIntent(intent: SelectGoalIntent
  (goal: goals[index]));
            },
            title: goals[index]);
      })
    ],
  );
});

  }
}

