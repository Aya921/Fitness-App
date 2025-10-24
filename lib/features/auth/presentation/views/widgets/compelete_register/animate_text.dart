import 'package:animate_do/animate_do.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/auth/api/models/register/text_model.dart';
import 'package:flutter/cupertino.dart';

class AnimateText extends StatelessWidget {
  const AnimateText({super.key,required this.textModel});
final TextModel textModel;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
duration: const Duration(
    milliseconds: 800

),
         delay: const Duration(
           milliseconds: 800
         ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(textModel.title.toUpperCase(),style:
        getBoldStyle(color: AppColors.white,
            fontSize:context.setSp(20) ),),
        SizedBox(height: context.setHight(12),),
        Text(textModel.subTitle,style:
        getRegularStyle(color: AppColors.white,
            fontSize:context.setSp(16) ),),
      ],
    ))
     ;
  }
}
