import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/manager_helper/manager_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenJsonData extends StatelessWidget {
  final String title;
  final ProfileIntents intent;

  const ProfileScreenJsonData({
    super.key,
    required this.title,
    required this.intent,
  });

  @override
  Widget build(BuildContext context) {
      // final appLanConfig = getIt.get<AppLanguageConfig>();
    final isArabic = Localizations.localeOf(context).languageCode == 'er';

    return Scaffold(
      body: HomeBackground(
        alpha: .12,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                //
                if (state.dataState.isFailure) {
                  //
                }
              },
              buildWhen: (previous, current) =>
                  previous.dataState != current.dataState,
              builder: (context, state) {
                if (state.dataState.isInitial) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.read<ProfileCubit>().doIntent(intent);
                  });
                }

                final dataState = state.dataState;

                if (dataState.isLoading || dataState.isInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }

                if (dataState.isSuccess && dataState.data != null) {
                  return _buildContent(context, dataState.data!, isArabic);
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
    List<dynamic> sections,
    bool isArabic,
  ) {
    final header = sections.firstWhere(
      (e) => e['section'] == 'page_title',
      orElse: () => <String, dynamic>{},
    );

    final subtitle = sections.firstWhere(
      (e) => e['section'] == 'page_subtitle',
      orElse: () => <String, dynamic>{},
    );

    final headerText = _getLocalizedText(header['content'], isArabic, title);
    final subtitleText = _getLocalizedText(subtitle['content'], isArabic, '');

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
                  style: ManagerHelper.parseTextStyle(header['style']),
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
              style: ManagerHelper.parseTextStyle(subtitle['style']),
            ),
          ),

        const SizedBox(height: 24),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];

              if (section['section'] == 'page_title' ||
                  section['section'] == 'page_subtitle') {
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
    Map<String, dynamic> section,
    bool isArabic,
  ) {
    final content = section['content'];
    final title = section['title'];
    final style = section['style'];
    final subSections = section['sub_sections'] as List?;

    final titleText = _getLocalizedText(title, isArabic, null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        if (titleText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              titleText,
              style: ManagerHelper.parseTextStyle(style?['title']),
              textAlign: ManagerHelper.parseAlignment(style?['title'], isArabic),
            ),
          ),

        // Section Content
        if (content != null) _buildContentWidget(content, style, isArabic),

        // Sub-sections
        if (subSections != null)
          ...subSections.map((subSection) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 12.0),
              child: _buildSubSection(subSection, isArabic),
            );
          }),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildContentWidget(dynamic content, dynamic style, bool isArabic) {
  
    if (content is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content.map<Widget>((item) {
          final itemText = _getLocalizedText(item, isArabic, '');
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: ManagerHelper.parseTextStyle(style?['content'] ?? style)
                      ?.copyWith(color: AppColors.orange) ??
                      const TextStyle(color: AppColors.orange),
                ),
                Expanded(
                  child: Text(
                    itemText,
                    style: ManagerHelper.parseTextStyle(
                      style?['content'] ?? style,
                    ),
                    textAlign: ManagerHelper.parseAlignment(
                      style?['content'] ?? style,
                      isArabic,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    if (content is Map) {
      final text = _getLocalizedText(content, isArabic, '');
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          text,
          style: ManagerHelper.parseTextStyle(style),
          textAlign: ManagerHelper.parseAlignment(style, isArabic),
        ),
      );
    }

    if (content is String) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          content,
          style: ManagerHelper.parseTextStyle(style),
          textAlign: ManagerHelper.parseAlignment(style, isArabic),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSubSection(Map<String, dynamic> subSection, bool isArabic) {
    final title = _getLocalizedText(subSection['title'], isArabic, null);
    final content = _getLocalizedText(subSection['content'], isArabic, '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
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
    );
  }

  String _getLocalizedText(dynamic field, bool isArabic, String? fallback) {
    if (field == null) return fallback ?? '';
    if (field is String) return field;
    if (field is Map) {
      return field[isArabic ? 'ar' : 'en']?.toString() ?? (fallback ?? '');
    }
    return fallback ?? '';
  }
}
