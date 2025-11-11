import 'package:fitness/config/di/di.dart';
import 'package:fitness/core/routes/app_routes.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_cubit.dart';
import 'package:fitness/features/auth/presentation/view_model/register_view_model/register_intent.dart';
import 'package:fitness/features/auth/presentation/views/screens/compelete_register/screen/complete_register_screen.dart';
import 'package:fitness/features/auth/presentation/views/screens/register/register_screen.dart';
import 'package:fitness/features/foods/domain/entities/meals_by_category.dart';
import 'package:fitness/features/home/domain/entities/explore_entity/muscle_entity/muscle_entity.dart';
import 'package:fitness/features/home/presentation/view/screens/change_pass_screen/change_pass_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/edit_profile/edit_activity_level_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/edit_profile/edit_goal_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/edit_profile/edit_weight_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/exercise_screen/exercises_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/exercise_screen/video_screen.dart';
import 'package:fitness/features/home/presentation/view_model/edit_profile/edit_profile_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_cubit.dart';
import 'package:fitness/features/home/presentation/view_model/exercises_view_model/exercises_intent.dart';
import 'package:fitness/features/home/presentation/view/screens/view_model/bottom_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness/core/widget/video_widgets/vido_player_screen.dart';
import 'package:fitness/features/meal_details/presentaion/view/pages/details_food_sceen.dart';


import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/features/auth/presentation/views/screens/forget_pass/create_password_screen.dart';
import 'package:fitness/features/auth/presentation/views/screens/forget_pass/forget_password_screen.dart';
import 'package:fitness/features/auth/presentation/views/screens/forget_pass/otp_screen.dart';
import 'package:fitness/features/home/presentation/view/screens/home_tab.dart';
import 'package:fitness/features/auth/presentation/view_model/login_view_model/login_cubit.dart';
import 'package:fitness/features/auth/presentation/views/screens/login/login_screen.dart';
import '../../features/foods/presentaion/view/screens/food_detials_screen.dart';
import '../../features/on_boarding/view/on_boarding_view.dart';
import '../../features/smart_coach/presentation/view/screens/smart_coach_screen.dart';



abstract class Routes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static Route onGenerate(RouteSettings setting) {
    final url = Uri.parse(setting.name ?? "");
    switch (url.path) {
      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt.get<BottomNavigationCubit>() ,
            child: const HomeTab(),
          ),
        );

      case AppRoutes.forgetPassScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgetPasswordScreen();
          },
        );

        case AppRoutes.changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePassScreen();
          },
        );
      case AppRoutes.food:
        final index = setting.arguments as int;

        return MaterialPageRoute(

          builder: (context) {
            return
              FoodDetialsScreen(index: index,

              );
          },
        );
 case AppRoutes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterCubit>(
            create: (context) => getIt.get<RegisterCubit>()..doIntent(intent: const RegisterInitializationIntent()),
            child: const RegisterScreen(),
          ),
        );
      case AppRoutes.completeRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => const CompeleteRegisterScreen(),
        );
      case AppRoutes.loginRoute:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            );
          },
        );

   

      case AppRoutes.otpScreen:
        final email = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return OtpScreen(userEmail: email);
          },
        );
      case AppRoutes.resetPass:
        final email = setting.arguments as String;
        return MaterialPageRoute(
          builder: (context) {
            return CreatePasswordScreen(email: email);
          },
        );

      case AppRoutes.exercises:
        final primMoverMuscle = setting.arguments as MuscleEntity;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => getIt<ExercisesCubit>()
                ..doIntent(
                  intent: LoadLevelsByMuscleIntent(
                    muscleId: primMoverMuscle.id ?? '',
                  ),
                ),
              // create: (context) => getIt<WorkoutCubit>()..loadLevelsByMuscle(primMoverMuscle.id),
              child:  ExercisesScreen(
                primMoverMuscle: primMoverMuscle,
              ),
            );
          },
        );

      case AppRoutes.exeVideoScreen:
        final videourl = setting.arguments as String;
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              ExercisesVideoPlayerScreen(videoUrl: videourl),
    );
      case AppRoutes.smartCoach:

        return MaterialPageRoute(

          builder: (context) {
            return
              const SmartCoachScreen();
          },
        );

      case AppRoutes.videoPage:
        final videourl = setting.arguments as String;
        return PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) =>
              VideoPlayerScreen(videoUrl: videourl),

        );
      case AppRoutes.detailsFoodPage:
        final args = setting.arguments as Map<String, dynamic>;
        final meals = args['meal'] as List<MealsByCategory>;
        final index = args['index'] as int;
        return MaterialPageRoute(
          builder: (context) {
            return DetailsFoodScreen(meals: meals, index: index);
          },
        );

      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );

      case AppRoutes.editWeight:
        final cubit = setting.arguments as EditProfileCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const EditWeightScreen(),
          ),
        );

      case AppRoutes.editGoal:
        final cubit = setting.arguments as EditProfileCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const EditGoalScreen(),
          ),
        );


      case AppRoutes.editLevel:
        final cubit = setting.arguments as EditProfileCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const EditActivityLevelScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(child: Text(context.loc.noRouteFound)),
            );
          },
        );
    }
  }
}
