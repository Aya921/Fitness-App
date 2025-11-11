import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:fitness/core/widget/home_back_ground.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

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
            child: BlocConsumer<SecurityCubit, SecurityState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.securityRolesState.isFailure) {
                  // Optional: show error snackbar
                }
              },
              buildWhen: (previous, current) =>
                  previous.securityRolesState != current.securityRolesState,
              builder: (context, state) {
                final securityRolesState = state.securityRolesState;

                if (securityRolesState.isLoading ||
                    securityRolesState.isInitial) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.orange),
                  );
                }

                if (securityRolesState.isFailure) {
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
                          securityRolesState.error?.message ??
                              Constants.anUnknownErrorOccurred,
                          style: const TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }

                if (securityRolesState.isSuccess &&
                    securityRolesState.data != null) {
                  return _buildContent(
                      context, securityRolesState.data, isArabic);
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
  dynamic securityEntity,
  bool isArabic,
) {
  final sections = securityEntity.sections as List;

  final header = sections.where((e) => e.section == 'page_title').firstOrNull;
  final description = sections.where((e) => e.section == 'page_description').firstOrNull;

  final headerText =
      header?.content?.getText(isArabic) ?? 'User Roles & Permissions';
  final descriptionText = description?.content?.getText(isArabic) ?? '';

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

        // Description
        if (descriptionText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              descriptionText,
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
                  section.section == 'page_description') {
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
      case 'role_list_title':
        return _buildRoleListTitle(section, isArabic);
      case 'role_definition':
        return _buildRoleDefinition(section, isArabic);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildRoleListTitle(dynamic section, bool isArabic) {
    final title = section.title?.getText(isArabic) ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.orange,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRoleDefinition(dynamic section, bool isArabic) {
    final roleDefinition = section.roleDefinition;
    if (roleDefinition == null) return const SizedBox.shrink();

    final name = roleDefinition.name?.getText(isArabic) ?? '';
    final description = roleDefinition.description?.getText(isArabic) ?? '';
    final permissions = roleDefinition.permissions ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBackground.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Role Name
          Text(
            name,
            style: const TextStyle(
              color: AppColors.orange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Role Description
          Text(
            description,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),

          if (permissions.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Permissions:',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),

            // Permissions List
            ...permissions.map((permission) {
              final permissionName = permission.name?.getText(isArabic) ?? '';
              final permissionDesc =
                  permission.description?.getText(isArabic) ?? '';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.orange,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            permissionName,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            permissionDesc,
                            style: const TextStyle(
                              color: AppColors.gray,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}