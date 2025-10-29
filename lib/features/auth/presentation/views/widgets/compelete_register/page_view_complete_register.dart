// import 'package:fitness/core/extension/app_localization_extension.dart';
// import 'package:fitness/core/loaders/loaders.dart';
// import 'package:fitness/core/responsive/size_helper.dart';
// import 'package:fitness/core/routes/app_routes.dart';
// import 'package:fitness/core/widget/loading_button.dart';
// import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
// import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
// import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/choose_goal.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_age.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_gender.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
// import 'package:fitness/core/widget/custom_pop_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../../core/widget/logo.dart';
// import '../../../../api/models/register/text_model.dart';
// import '../../screens/compelete_register/tabs/choose_activity.dart';
// import '../../screens/compelete_register/tabs/select_height.dart';
// import '../../screens/compelete_register/tabs/select_weight.dart';
//
// class PageViewCompeleteRegister extends StatefulWidget {
//   const PageViewCompeleteRegister({super.key});
//
//   @override
//   State<PageViewCompeleteRegister> createState() =>
//       _PageViewCompeleteRegisterState();
// }
//
// class _PageViewCompeleteRegisterState extends State<PageViewCompeleteRegister> {
//   final PageController pageController = PageController();
//   bool isLast = false;
//   int currIndex = 0;
//
//   final List<Widget> tabs = const [
//     //RegisterTab(),
//     SelectGender(),
//     SelectAge(),
//     SelectWeight(),
//     SelectHeight(),
//     ChooseGoal(),
//     ChooseActivity(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final List<TextModel> texts = [
//       TextModel(
//         title: context.loc.tellUsAboutYourself,
//         subTitle: context.loc.weNeedToKnowYourGender,
//       ),
//       TextModel(
//         title: context.loc.howOldAreYou,
//         subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
//       ),
//       TextModel(
//         title: context.loc.whatIsYourWeight,
//         subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
//       ),
//       TextModel(
//         title: context.loc.whatIsYourHeight,
//         subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
//       ),
//       TextModel(
//         title: context.loc.whatIsYourGoal,
//         subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
//       ),
//       TextModel(title: context.loc.yourRegularPhysical, subTitle: ""),
//     ];
//
//     return BlocListener<RegisterCubit, RegisterState>(
//       listenWhen: (previous, current) =>
//           current.registerStatus.isSuccess || current.registerStatus.isFailure,
//       listener: (context, state) {
//         if (state.registerStatus.isSuccess) {
//           Loaders.showSuccessMessage(
//             message: "Registerd Successfully!",
//             context: context,
//           );
//           Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
//         } else if (state.registerStatus.isFailure) {
//           Loaders.showErrorMessage(
//             message: state.registerStatus.error?.message ?? "",
//             context: context,
//           );
//         }
//       },
//       child: Column(
//         children: [
//           const Spacer(flex: 1),
//           Padding(
//             padding: EdgeInsetsDirectional.symmetric(
//               horizontal: context.setWidth(20),
//             ),
//             child: Row(
//               spacing: 130,
//               children: [
//                 currIndex > 0
//                     ? CustomPopIcon(
//                         onTap: () {
//                           pageController.previousPage(
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                           );
//                         },
//                       )
//                     : const SizedBox.shrink(),
//                 const Logo(),
//               ],
//             ),
//           ),
//           const Spacer(flex: 1),
//           //index!=0?
//           Align(
//             alignment: Alignment.center,
//             child: CustomLoadingCircleProgressIndictor(index: currIndex + 1),
//           ),
//
//           SizedBox(height: context.setHight(30)),
//           Expanded(
//             child: PageView.builder(
//               controller: pageController,
//               itemCount: tabs.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   currIndex = index;
//                   isLast = index == tabs.length - 1;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return _buildPage(context, index, texts[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPage(BuildContext context, int index, TextModel textModel) {
//     return
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsetsDirectional.only(start: 22),
//             child: AnimateText(textModel: textModel),
//           ),
//           SizedBox(height: context.setHight(12)),
//
//           ContainerDetialsCompleteRegister(
//             child: Column(
//               children: [
//                 tabs[index],
//                 SizedBox(height: context.setHight(16)),
//
//                 Padding(
//                   padding: const EdgeInsetsDirectional.symmetric(
//                     horizontal: 16,
//                   ),
//                   child: BlocBuilder<RegisterCubit, RegisterState>(
//                     builder: (context, state) {
//                       if (state.registerStatus.isLoading) {
//                         return const LoadingButton();
//                       } else {
//                         return ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: Size(
//                               MediaQuery.of(context).size.width,
//                               context.setHight(45),
//                             ),
//                           ),
//                           onPressed: () {
//                             if (isLast) {
//                               BlocProvider.of<RegisterCubit>(
//                                 context,
//                               ).doIntent(intent: const RegisterFormIntent());
//                             } else {
//                               pageController.nextPage(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                               );
//                             }
//                           },
//                           child: Text(context.loc.next),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Spacer(flex: 2),
//         ],
//       );
//   }
// }
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/loaders/loaders.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/core/widget/loading_button.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/choose_goal.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_age.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_gender.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
import 'package:fitness/core/widget/custom_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widget/logo.dart';
import '../../../../api/models/register/text_model.dart';
import '../../screens/compelete_register/tabs/choose_activity.dart';
import '../../screens/compelete_register/tabs/select_height.dart';
import '../../screens/compelete_register/tabs/select_weight.dart';

class PageViewCompeleteRegister extends StatefulWidget {
  const PageViewCompeleteRegister({super.key});

  @override
  State<PageViewCompeleteRegister> createState() =>
      _PageViewCompeleteRegisterState();
}

class _PageViewCompeleteRegisterState extends State<PageViewCompeleteRegister> {
  final PageController pageController = PageController();
  bool isLast = false;
  int currIndex = 0;

  final List<Widget> tabs = const [
    SelectGender(),
    SelectAge(),
    SelectWeight(),
    SelectHeight(),
    ChooseGoal(),
    ChooseActivity(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<TextModel> texts = [
      TextModel(
        title: context.loc.tellUsAboutYourself,
        subTitle: context.loc.weNeedToKnowYourGender,
      ),
      TextModel(
        title: context.loc.howOldAreYou,
        subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
      ),
      TextModel(
        title: context.loc.whatIsYourWeight,
        subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
      ),
      TextModel(
        title: context.loc.whatIsYourHeight,
        subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
      ),
      TextModel(
        title: context.loc.whatIsYourGoal,
        subTitle: context.loc.thisHelpsUsCreateYourPersonalizedPlan,
      ),
      TextModel(title: context.loc.yourRegularPhysical, subTitle: ""),
    ];

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
      current.registerStatus.isSuccess || current.registerStatus.isFailure,
      listener: (context, state) {
        if (state.registerStatus.isSuccess) {
          Loaders.showSuccessMessage(
            message: "Registered Successfully!",
            context: context,
          );
          Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
        } else if (state.registerStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.registerStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      child: SafeArea(
        child: Column(
          children: [
          SizedBox(
           height: context.setHight(20),
         ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: context.setWidth(20),
                vertical: context.setHight(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currIndex > 0
                      ? CustomPopIcon(
                    onTap: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                      : const SizedBox.shrink(),
                  const Logo(),

                  const SizedBox.shrink()
                ],
              ),
            ),

            // ---------- Progress ----------
            Align(
              alignment: Alignment.center,
              child: CustomLoadingCircleProgressIndictor(index: currIndex + 1),
            ),

            SizedBox(height: context.setHight(25)),

            // ---------- PageView ----------
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: tabs.length,
                onPageChanged: (index) {
                  setState(() {
                    currIndex = index;
                    isLast = index == tabs.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(context, index, texts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, int index, TextModel textModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: context.setHight(16),
        top: context.setHight(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- Title ----------
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 22),
            child: AnimateText(textModel: textModel),
          ),
          SizedBox(height: context.setHight(12)),

          // ---------- Content ----------
          ContainerDetialsCompleteRegister(
            child: Column(
              children: [
                tabs[index],
                SizedBox(height: context.setHight(16)),

                // ---------- Button ----------
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state.registerStatus.isLoading) {
                        return const LoadingButton();
                      }
                      return ElevatedButton(
                        key: const Key("page_view_button"),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            context.setHight(45),
                          ),
                        ),
                        onPressed: () {
                          if (isLast) {
                            context
                                .read<RegisterCubit>()
                                .doIntent(intent: const RegisterFormIntent());
                          } else {
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(context.loc.next),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
