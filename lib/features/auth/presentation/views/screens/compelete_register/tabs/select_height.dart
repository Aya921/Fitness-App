
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../view_model/register_view_model/register_intent.dart';

class SelectHeight extends StatelessWidget {
  const SelectHeight({super.key,});



  @override
  Widget build(BuildContext context) {
    return
    BlocBuilder<RegisterCubit,RegisterState>(builder: (context,state){

      return   Column(
        children: [
          Text(context.loc.cm,style:
          getMediumStyle(color:  AppColors
              .orange[AppColors.baseColor]!),),
          SizedBox(height: context.setHight(20),),
          NumberPicker(minValue: 70,

              maxValue: 230,
              value: state.height,

              axis: Axis.horizontal,
              textStyle: getMediumStyle(color: AppColors.white,
                  fontSize: context.setSp(20)),
              decoration: const BoxDecoration(
                color: Colors.transparent,


              ),
              selectedTextStyle: getMediumStyle(color:
              AppColors.orange[AppColors.baseColor]!,
                  fontSize: context.setSp(30)),
              onChanged: (val){
context.read<RegisterCubit>().doIntent(intent: SelectHeightIntent(
  height: val
));
              }),
          SizedBox(height: context.setHight(20),),
          Icon(Icons.arrow_drop_up,size: context.setMinSize(40),
              color:  AppColors.orange[AppColors.baseColor]
          )
        ],
      );
    })
    ;
  }
}
