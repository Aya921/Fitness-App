import 'package:fitness/core/constants/app_widgets_key.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/core/widget/custom_text_form_field.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTabToEditField extends StatelessWidget {
  final String title;
  final String value;
  final String routeToNavigate;
  const ProfileTabToEditField({
    required this.title,
    required this.value,
    required this.routeToNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: context.setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text.rich(
              key: const Key(WidgetKey.tabToEditNTextRich),
              TextSpan(
                children: [
                  TextSpan(
                    text: "$title (",
                    style: getSemiBoldStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                  TextSpan(
                    text: context.loc.tabToEdit,
                    style: getSemiBoldStyle(
                      color: AppColors.orange,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                  TextSpan(
                    text: ")",
                    style: getSemiBoldStyle(
                      color: AppColors.white,
                      fontSize: context.setSp(FontSize.s14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            key:const Key(WidgetKey.tabToEditNavigator),
            onTap: () {
              final cubit = context.read<EditProfileCubit>();
              Navigator.pushNamed(
                context,
                routeToNavigate,
                arguments: cubit,
              );
            },
            child: CustomTextFormField(
              isReadOnly: true,
              enabled: false,
              initialValue: value,
            ),
          ),
          SizedBox(
            height: context.setHight(16),
          )
        ],
      ),
    );
  }
}
