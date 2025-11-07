import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/logo.dart';
import 'package:fitness/features/auth/api/models/register/text_model.dart';
import 'package:fitness/features/auth/domain/entity/auth/user_entity.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/home/presentation/view/widgets/edit_profile/edit_weight_screen/weight_picker_section.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:flutter/material.dart';

class EditWeightBody extends StatelessWidget {
  final EditProfileCubit cubit;
  final UserEntity? user;
  final EditProfileState state;

  const EditWeightBody({
    super.key,
    required this.cubit,
    required this.user,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: context.setWidth(22)),
            CustomPopIcon(onTap: Navigator
                .of(context)
                .pop),
            SizedBox(width: context.setWidth(88)),
            const Logo(),
          ],
        ),
        SizedBox(height: context.setHight(148)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding:  EdgeInsets.only(left: context.setWidth(24)),
               child: AnimateText(
                textModel: TextModel(
                  title: context.loc.whatIsYourWeight,
                  subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
                ),
                           ),
             ),
            SizedBox(height: context.setHight(8)),
            WeightPickerSection(cubit: cubit, user: user, state: state),
          ],
        ),
      ],
    );
  }

}
