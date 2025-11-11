abstract class EndPointsConstants {
  static const String baseUrl = "https://fitness.elevateegy.com/api/v1/";
  static const String baseUrlFood = "https://www.themealdb.com/api/json/v1/";
  static const String detailsFoodBaseUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php";
  static const String authEndPoint = "auth/";
  //signUpEndPoint
  static const String signUpEndPoint = "signup";
  static const String signIn = "signin";
  static const String getLoggedUser = "profile-data";
  static const String forgetPassEndPoint = "forgotPassword";
  static const String verifyResetCode = "verifyResetCode";
  static const String resetPass = "resetPassword";
  static const String musclesRandom = "muscles/random";
  static const String allMusclesGroups = "muscles";
  //static const String mealsCategories = "categories.php";

  static const String mealsCategories = "1/categories.php";
  static const String mealsByCategories = "1/filter.php?";
  static const String musclesGroupById = "/musclesGroup/{id}";
  static const String  getAllExercisesExplore = "exercises";

  //exercises
  static const String difficultyByPrimeMoverMuscle = "levels/difficulty-levels/by-prime-mover";
  static const String exercisesByMuscleAndDifficulty = "exercises/by-muscle-difficulty";
  static const String difficultyLevelId = "difficultyLevelId";
  static const String primeMoverMuscleId = "primeMoverMuscleId";
  static const String page = "page";
  static const String limit = "limit";

  //change password
  static const String changePassword = "auth/change-password";

  //logout
  static const String logout="auth/logout";

  //edit profile
static const String editProfile="auth/editProfile";
static const String uploadPhoto="auth/upload-photo";
static const String photo="photo";
}