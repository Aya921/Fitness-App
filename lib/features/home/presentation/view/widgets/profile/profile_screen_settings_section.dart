import 'dart:ui';
import 'package:fitness/core/constants/assets_manager.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_manager.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:fitness/features/home/presentation/view/widgets/profile/profile_screen_json_data.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/profile_view_model/profile_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreenSettingsSection extends StatelessWidget {
  const ProfileScreenSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
              ),
              SettingsItem(
                iconPath: AssetsManager.changePasswordProfileIcon,
                title: context.loc.changePassword,
                onTap: () {},
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
                    value: true,
                    onChanged: (value) {

                    },
                    applyCupertinoTheme:false,
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
                      builder: (_) => BlocProvider.value(
                        value: context
                            .read<ProfileCubit>()..doIntent(SecurityIntent()),
                        child: ProfileScreenJsonData(
                          title: context.loc.security,
                          intent: SecurityIntent(),
                        ),
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
                      builder: (_) => BlocProvider.value(
                        value: context
                            .read<ProfileCubit>()..doIntent(PrivacyPolicyIntent()),
                        child: ProfileScreenJsonData(
                          title: context.loc.privacyPolicy,
                          intent: PrivacyPolicyIntent(),
                        ),
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
                      builder: (_) => BlocProvider.value(
                        value: context
                            .read<ProfileCubit>()..doIntent(HelpIntent()),
                        child: ProfileScreenJsonData(
                          title: context.loc.help,
                          intent: HelpIntent(),
                        ),
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
                onTap: () {},
                showBorder: false,
              ),
            ],
          ),
        ),
      ),
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
