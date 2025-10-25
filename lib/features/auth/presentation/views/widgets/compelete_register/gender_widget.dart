import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenderWidget extends StatelessWidget {
   const GenderWidget({super.key, this.isSelected=false
    ,required this.iconData, required this.title,this.onTap});

  final String iconData;
  final String title;
  final void Function()? onTap;
final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap:onTap,
        child:AnimatedContainer(
          width: context.setWidth(95),
          height: context.setHight(95),
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: context.setMinSize(9.45),horizontal: context.setMinSize(29.92)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:isSelected?AppColors.orange[AppColors.baseColor]
                : Colors.transparent,
            border: Border.all(width: context.setWidth(1),
                color: isSelected? AppColors.orange[AppColors.baseColor]!: AppColors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: SvgPicture.asset(fit: BoxFit.contain,iconData)),
              SizedBox(height: context.setHight(8)),
              SizedBox(
                width: context.setMinSize(39),
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(title, style: getSemiBoldStyle(color: AppColors.white,fontSize:
                  context.setSp(FontSize.s12)),textAlign: TextAlign.center,),
                ),
              ),
            ],
          ),
        ) ,
      );
  }
}
