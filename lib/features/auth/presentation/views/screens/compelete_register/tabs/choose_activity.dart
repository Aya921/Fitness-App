import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/select_widget_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/enum/levels.dart';

class ChooseActivity extends StatelessWidget {
  const ChooseActivity({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<RegisterCubit,RegisterState>(builder: (context,state){
      final selectedLevel = state.level ?? ActivityLevel.level1;
      return       Column(
        children:ActivityLevel.values.map((e){
          return SelectWidgetItem(
              isSelected: e ==selectedLevel,
              title: e.getLocalizedName(context), onTap: (){
            context.read<RegisterCubit>().doIntent(intent: SelectLevelIntent
              (level: e));
          });
        }).toList()
      );
    });

  }
}

