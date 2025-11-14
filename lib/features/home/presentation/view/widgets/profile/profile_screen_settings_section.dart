import 'dart:ui';
import 'package:fitness/config/app_language/app_language_config.dart';
import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/constants/constants.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/widgets/logout/logout_dialog.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/help_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/privacy_policy_view.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/security_view.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/help_view_model/help_intents.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/privacy_policy_view_model/privacy_policy_intent.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_state.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/security_view_model/security_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreenSettingsSection extends StatelessWidget {
  const ProfileScreenSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final appLanConfig = getIt.get<AppLanguageConfig>();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.logoutStatus?.isSuccess == true) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginRoute,
            (route) => false,
          );
        } else if (state.logoutStatus?.isFailure == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.logoutStatus?.error?.message ?? "can not logout now",
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darkBackground.withValues(alpha: .4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.shearGray.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  SettingsItem(
                    iconPath: AssetsManager.profileUserIcon,
                    title: context.loc.editProfile,
                      onTap: () async {
                        final result = await Navigator.pushNamed(context, AppRoutes.editProfile);

                        if (!context.mounted) return;

                        if (result == true) {
                          context.read<ProfileCubit>().doIntent(GetLoggedUserIntent());
                        }
                      }

                  ),
                  SettingsItem(
                    iconPath: AssetsManager.changePasswordProfileIcon,
                    title: context.loc.changePassword,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                  ),
                  SettingsItem(
                    iconPath: AssetsManager.selectLanguageSvg,
                    richText: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: context.loc.selectLanguage,
                            style: getSemiBoldStyle(
                              color: AppColors.white,
                              fontSize: context.setSp(FontSize.s14),
                            ),
                          ),
                          TextSpan(
                            text: '(${context.loc.language})',
                            style: getSemiBoldStyle(
                              color: AppColors.orange,
                              fontSize: context.setSp(FontSize.s14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.only(right: context.setHight(10)),
                      height: context.setHight(20),
                      width: context.setWidth(34),
                      child: Switch.adaptive(
                        inactiveThumbColor: AppColors.lightWhite,
                        inactiveTrackColor: AppColors.darkBackground,
                        activeColor: AppColors.orange,
                        activeTrackColor: AppColors.orange,
                        activeThumbColor: AppColors.white,
                        trackOutlineColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        trackOutlineWidth: MaterialStateProperty.all(0),
                        value: appLanConfig.isEn(),
                        onChanged: (value) async {
                          if (value) {
                            await appLanConfig.changeLocal(Constants.enLocal);
                          } else {
                            await appLanConfig.changeLocal(Constants.arLocal);
                          }
                        },
                      ),
                    ),
                    onTap: null,
                  ),
                  SettingsItem(
                    iconPath: AssetsManager.securitySvg,
                    title: context.loc.security,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) =>
                                getIt.get<SecurityCubit>()
                                  ..doIntent(LoadSecurityPolicyIntent()),
                            child: const SecurityView(),
                          ),
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    iconPath: AssetsManager.privacyIcon,
                    title: context.loc.privacyPolicy,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) =>
                                getIt.get<PrivacyPolicyCubit>()
                                  ..doIntent(LoadPrivacyPolicyIntent()),
                            child: const PrivacyPolicyView(),
                          ),
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    iconPath: AssetsManager.helpSvg,
                    title: context.loc.help,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) =>
                                getIt.get<HelpCubit>()
                                  ..doIntent(LoadHelpContentIntent()),
                            child: const HelpView(),
                          ),
                        ),
                      );
                    },
                  ),
                  SettingsItem(
                    iconPath: AssetsManager.logoutSvg,
                    title: context.loc.logoutProfile,
                    titleColor: AppColors.orange,
                    iconColor: AppColors.orange,
                    onTap: () {
                      final cubit = context.read<ProfileCubit>();
                      showDialog(
                        context: context,
                        barrierColor: AppColors.gray[80]?.withAlpha(150),
                        barrierDismissible: false,
                        builder: (context) => LogoutDialog(cubit: cubit),
                      );
                    },
                    showBorder: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String iconPath;
  final String? title;
  final RichText? richText;
  final Widget? trailing;
  final Color? titleColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool showBorder;

  const SettingsItem({
    super.key,
    required this.iconPath,
    this.title,
    this.richText,
    this.trailing,
    this.titleColor,
    this.iconColor,
    this.onTap,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.setWidth(8),
          vertical: context.setHight(13),
        ),
        decoration: BoxDecoration(
          border: showBorder
              ? const Border(
                  bottom: BorderSide(color: AppColors.shearGray, width: 1),
                )
              : null,
        ),
        child: Row(
          children: [
            // Icon without container
            SvgPicture.asset(
              iconPath,
              width: context.setMinSize(20),
              height: context.setMinSize(20),
            ),

            SizedBox(width: context.setWidth(16)),

            // Title
            Expanded(
              child:
                  richText ??
                  Text(
                    title ?? "",
                    style:
                        getSemiBoldStyle(
                          color: titleColor ?? AppColors.white,
                        ).copyWith(
                          fontSize: context.setSp(FontSize.s14),
                          fontFamily: 'BalooThambi2',
                        ),
                  ),
            ),

            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.orange,
                  size: context.setMinSize(18.355),
                ),
          ],
        ),
      ),
    );
  }
}
