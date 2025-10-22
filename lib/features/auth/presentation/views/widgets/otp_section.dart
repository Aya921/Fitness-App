import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/widget/custum_fields_button.dart';
import 'package:fitness/features/auth/presentation/views/widgets/custum_otp.dart';
import 'package:fitness/features/auth/presentation/views/widgets/verification_question_section.dart';
import 'package:flutter/material.dart';

class OtpSection extends StatelessWidget {
  OtpSection({super.key});

  final ValueNotifier<bool> isOtpCompleted = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // otp
        CustomOtpField(numberOfFields: 4, isOtpCompleted: isOtpCompleted),

         SizedBox(height: context.setHight(30)),
        //button
        CustumFieldsButton(valueNotify: isOtpCompleted, text: context.loc.confirm),
        

        //endSection
        const VerifcationQuestionSection(),
      ],
    );
  }
}
