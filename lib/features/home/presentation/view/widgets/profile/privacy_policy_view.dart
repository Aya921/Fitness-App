// lib/features/home/presentation/view/widgets/profile/privacy_policy_view.dart

import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLanConfig = getIt.get<AppLanguageConfig>();
    final isArabic = !appLanConfig.isEn();

    return Scaffold(
      body: HomeBackground(
        image: AssetsManager.homeBackground,
        alpha: .12,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.privacyPolicyState.isFailure) {
                  // Optional: show error snackbar
                }
              },
              buildWhen: (previous, current) =>
                  previous.privacyPolicyState != current.privacyPolicyState,
              builder: (context, state) {
                final privacyPolicyState = state.privacyPolicyState;

                if (privacyPolicyState.isLoading ||
                    privacyPolicyState.isInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }

                if (privacyPolicyState.isFailure) {
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
                          privacyPolicyState.error?.message ??
                              Constants.anUnknownErrorOccurred,
                          style: const TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }

                if (privacyPolicyState.isSuccess &&
                    privacyPolicyState.data != null) {
                  return _buildContent(
                      context, privacyPolicyState.data, isArabic);
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
    dynamic privacyEntity,
    bool isArabic,
  ) {
    final sections = privacyEntity.sections as List;

    final header = sections.where((e) => e.section == 'title').firstOrNull;
    final lastUpdated =
        sections.where((e) => e.section == 'last_updated').firstOrNull;

    final headerText = _getLocalizedText(header?.content, isArabic) ?? 'Privacy Policy';
    final lastUpdatedText = _getLocalizedText(lastUpdated?.content, isArabic) ?? '';

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
                    color: AppColors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),

        // Last Updated
        if (lastUpdatedText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              lastUpdatedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.gray,
                fontSize: 14,
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

              if (section.section == 'title' ||
                  section.section == 'last_updated') {
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
    final titleText = _getLocalizedText(section.title, isArabic) ?? '';
    final content = section.content;
    final subSections = section.subSections;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          if (titleText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                titleText,
                style: const TextStyle(
                  color: AppColors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          // Section Content
          if (content != null) _buildContentWidget(content, isArabic),

          // Sub-sections
          if (subSections != null && subSections.isNotEmpty)
            ...subSections.map((subSection) {
              return _buildSubSection(subSection, isArabic);
            }),
        ],
      ),
    );
  }

  Widget _buildContentWidget(dynamic content, bool isArabic) {
    // Try to get the localized value using getText()
    try {
      final result = content.getText(isArabic);
      
      // Check if result is a List
      if (result is List) {
        return _buildListContent(result);
      }
      
      // Check if result is a String
      if (result is String && result.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            result,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        );
      }
    } catch (e) {
      // If getText fails, content might be null or invalid
    }

    return const SizedBox.shrink();
  }

  Widget _buildListContent(List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map<Widget>((item) {
        final itemText = item is String ? item : item.toString();
        
        if (itemText.isEmpty || itemText == 'null') {
          return const SizedBox.shrink();
        }
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: Text(
                  itemText,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubSection(dynamic subSection, bool isArabic) {
    final title = _getLocalizedText(subSection.title, isArabic) ?? '';
    final content = _getLocalizedText(subSection.content, isArabic) ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          if (content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                content,
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to safely extract localized text
  String? _getLocalizedText(dynamic content, bool isArabic) {
    if (content == null) return null;
    
    try {
      final result = content.getText(isArabic);
      if (result is String) {
        return result;
      }
    } catch (e) {
      // getText doesn't exist or failed
    }
    
    return null;
  }
}