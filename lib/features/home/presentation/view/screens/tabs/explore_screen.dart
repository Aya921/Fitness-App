import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/theme/app_colors.dart';
import 'package:fitness/core/theme/font_style.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(context.loc.explore,style: getBoldStyle(color: AppColors.white,
                  fontSize: context.setSp(30)
              ),),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context,AppRoutes.logout),
                child: Text("logout",style: getBoldStyle(color: AppColors.white,
                    fontSize: context.setSp(30)
                ),),
              ),
            ],
          )
      ),
    );
  }
}