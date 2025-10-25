import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/gender_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../view_model/register_view_model/register_intent.dart';

class SelectGender extends StatelessWidget {
  const SelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GenderWidget(
              iconData: AssetsManager.maleGenderIcon,
              title: context.loc.male,
              isSelected: context.loc.male == state.selectedGender,
              onTap: () {
                context.read<RegisterCubit>().doIntent(
                  intent: ChangeGenderIntent(selectedGender: context.loc.male),
                );
              },
            ),
            SizedBox(height: context.setHight(24)),
            GenderWidget(
              isSelected: context.loc.female == state.selectedGender,

              iconData: AssetsManager.femaleGenderIcon,
              title: context.loc.female,

              onTap: () {
                context.read<RegisterCubit>().doIntent(
                  intent: ChangeGenderIntent(
                    selectedGender: context.loc.female,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
