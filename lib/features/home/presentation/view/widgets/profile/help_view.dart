import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLanConfig = getIt.get<AppLanguageConfig>();
    final isArabic = !appLanConfig.isEn();

    return Scaffold(
      body: HomeBackground(
        alpha: .12,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<HelpCubit, HelpState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.helpContentState.isFailure) {
                  // Optional: show error snackbar
                }
              },
              buildWhen: (previous, current) =>
                  previous.helpContentState != current.helpContentState,
              builder: (context, state) {
                final helpContentState = state.helpContentState;

                if (helpContentState.isLoading || helpContentState.isInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }

                if (helpContentState.isFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          helpContentState.error?.message ??
                              Constants.anUnknownErrorOccurred,
                          style: const TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }

                if (helpContentState.isSuccess && helpContentState.data != null) {
                  return _buildContent(context, helpContentState.data, isArabic);
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    dynamic helpEntity,
    bool isArabic,
  ) {
    final sections = helpEntity.sections as List;

    // FIX: Use where().firstOrNull instead of firstWhere with orElse
    final header = sections.where((e) => e.section == 'page_title').firstOrNull;
    final subtitle = sections.where((e) => e.section == 'page_subtitle').firstOrNull;

    final headerText = header?.content?.getText(isArabic) ?? 'Help & Support';
    final subtitleText = subtitle?.content?.getText(isArabic) ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with back button
        Row(
          children: [
            CustomPopIcon(
              onTap: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: Text(
                  headerText,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),

        // Subtitle
        if (subtitleText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              subtitleText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gray,
                fontSize: 16,
              ),
            ),
          ),

        const SizedBox(height: 24),

        // Scrollable Content
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];

              if (section.section == 'page_title' ||
                  section.section == 'page_subtitle') {
                return const SizedBox.shrink();
              }

              return _buildSection(context, section, isArabic);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context,
    dynamic section,
    bool isArabic,
  ) {
    final sectionType = section.section;

    switch (sectionType) {
      case 'contact_us':
        return _buildContactSection(context, section, isArabic);
      case 'faq':
        return _buildFaqSection(context, section, isArabic);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContactSection(
    BuildContext context,
    dynamic section,
    bool isArabic,
  ) {
    final title = section.title?.getText(isArabic) ?? '';
    final contactMethods = section.contactMethods ?? [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.orange,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...contactMethods.map((contact) {
            return _buildContactCard(context, contact, isArabic);
          }),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    dynamic contact,
    bool isArabic,
  ) {
    final method = contact.method?.getText(isArabic) ?? '';
    final details = contact.details?.getText(isArabic) ?? '';
    final value = contact.value ?? '';
    final isEmail = contact.id == 'contact_001';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isEmail ? Icons.email : Icons.phone,
            color: AppColors.orange,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    color: AppColors.gray,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.orange,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection(
    BuildContext context,
    dynamic section,
    bool isArabic,
  ) {
    final title = section.title?.getText(isArabic) ?? '';
    final faqItems = section.faqItems ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...faqItems.map((faq) {
          return _buildFaqItem(context, faq, isArabic);
        }),
      ],
    );
  }

  Widget _buildFaqItem(
    BuildContext context,
    dynamic faq,
    bool isArabic,
  ) {
    final question = faq.question?.getText(isArabic) ?? '';
    final answer = faq.answer?.getText(isArabic) ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.shearGray.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            question,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconColor: AppColors.orange,
          collapsedIconColor: AppColors.orange,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                answer,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}