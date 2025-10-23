// import 'package:fitness/core/extension/app_localization_extension.dart';
// import 'package:fitness/core/responsive/size_helper.dart';
// import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
// import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/choose_goal.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_age.dart';
// import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_gender.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
// import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_pop_icon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../../config/di/di.dart';
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
//   final List<Widget> tabs = [
//     const SelectGender(),
//     const SelectAge(),
//     const SelectWeight(),
//     const SelectHeight(),
//     const ChooseGoal(),
//     const ChooseActivity(),
//   ];
//   bool isLast=false;
//  PageController pageController=PageController();
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
//     return PageView.builder(
//       controller: pageController,
//       onPageChanged: (index) {
//         if(index==tabs.length-1){
//           isLast=true;
//           setState(() {
//
//           });
//         }
//       },
//       itemBuilder: (context, index) {
//         return BlocProvider(
//           create: (context)=>getIt<RegisterCubit>()..doIntent(intent:
//         const RegisterInitializationIntent()),
//         child: SizedBox.expand(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.symmetric(
//                   horizontal: context.setWidth(20),
//                 ),
//                 child: Row(
//                   spacing: 130,
//                   children: [
//                     index > 1 ?  CustomPopIcon(
//                       onTap: (){
//                         pageController.previousPage(duration: const
//                         Duration(
//                             milliseconds: 300
//
//                         ), curve: Curves.bounceInOut);
//                       },
//                     ) : const SizedBox.shrink(),
//
//                     const Logo(),
//                   ],
//                 ),
//               ),
//               const Spacer(flex: 2),
//               CustomLoadingCircleProgressIndictor(index: index + 1),
//               SizedBox(height: context.setHight(30)),
//               AnimateText(textModel: texts[index]),
//               SizedBox(height: context.setHight(12)),
//               ContainerDetialsCompleteRegister(
//                 child: Column(
//                   children: [
//                     tabs[index],
//                     SizedBox(height: context.setHight(16)),
//                     Padding(
//                       padding: const EdgeInsetsDirectional.symmetric(
//                         horizontal: 16,
//                       ),
//                       child:
//      BlocListener(listener: (context,state){},
//      child:                  ElevatedButton(
//        style: ElevatedButton.styleFrom(
//          fixedSize: Size(
//            MediaQuery.of(context).size.width,
//            context.setHight(45),
//          ),
//        ),
//        onPressed: () {
//          if(index==tabs.length-1){
//            //navigator to login screen
//            Navigator.of(context).
//            push(MaterialPageRoute(builder: (context)=>const Scaffold(
//
//            )));
//            BlocProvider.of<RegisterCubit>(context)
//                .doIntent(intent: const RegisterFormIntent());
//          }
//          pageController.nextPage(duration: const Duration(
//              milliseconds: 300
//          ),
//              curve:Curves.bounceInOut );
//        },
//        child: Text(context.loc.next),
//      ),
//      )
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(flex: 2),
//             ],
//           ),
//         ),
//         );
//
//       },
//     );
//   }
// }
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/responsive/size_helper.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_states.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/choose_goal.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_age.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/tabs/select_gender.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/animate_text.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/container_detials_complete_register.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_loading_circle_progress_indictor.dart';
import 'package:fitness/features/auth/presentation/views/widgets/compelete_register/custom_pop_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/di/di.dart';
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

  final List<Widget> tabs = const [
    //RegisterTab(),
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

    return BlocProvider(
      create: (context) =>
      getIt<RegisterCubit>()..doIntent(intent: const RegisterInitializationIntent()),
      child: PageView.builder(
        controller: pageController,
        itemCount: tabs.length,
        onPageChanged: (index) {
          setState(() {
            isLast = index == tabs.length - 1;
          });
        },
        itemBuilder: (context, index) {
          return _buildPage(context, index, texts[index]);
        },
      ),
    );
  }
  Widget _buildPage(BuildContext context, int index, TextModel textModel) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 1),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: context.setWidth(20),
            ),
            child: Row(
              spacing: 130,
              children: [
                if (index > 1)
                  CustomPopIcon(
                    onTap: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                else
                  const SizedBox.shrink(),
                const Logo(),
              ],
            ),
          ),
          const Spacer(flex: 1),
        index!=0?
        Align(
          alignment: Alignment.center,
          child: CustomLoadingCircleProgressIndictor(index: index),
        ):const
        SizedBox.shrink(),
          SizedBox(height: context.setHight(30)),
        Padding(padding: const EdgeInsetsDirectional.only(
          start: 22
        ),child:   AnimateText(textModel: textModel),),
          SizedBox(height: context.setHight(12)),


          ContainerDetialsCompleteRegister(
            child: Column(
              children: [
                tabs[index],
                SizedBox(height: context.setHight(16)),

                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                  child: BlocListener<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                    },
                    child:
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width,
                          context.setHight(45),
                        ),
                      ),
                      onPressed: () {
                        if (isLast) {
                          BlocProvider.of<RegisterCubit>(context).doIntent(
                            intent: const RegisterFormIntent(),
                          );

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Scaffold(
                                body: Center(child: Text('Registered Successfully!')),
                              ),
                            ),
                          );
                        } else {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(context.loc.next),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

