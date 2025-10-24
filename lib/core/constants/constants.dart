abstract class Constants {
  static const String enLocal = "en";
  static const String arLocal = "ar";
  static const String contentType = "content-Type";
  static const String appJson = "application/json";
  static const String next = "Next";
  static const String skip = "Skip";
  static const String doIt = "Do It";
  static const String noResponseReceivedMessage = "noResponseReceivedMessage";
  static const String anUnknownErrorOccurred = "anUnknownErrorOccurred";
  static const String email = "email";
  static const String password = "password";
  static const String error = "error";
  static const String message = "message";
  static const String titleOnBoarding = "the price of excellent is discipline";
  static const String titleTwoBoarding = "Fitness has never been so much fun";
  static const String titleThreeBoarding = "NO MORE EXCUSES Do It Now";
  static const String descriptionOnBoarding = "Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa";




    // 🔸 Validation patterns
  static const String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String usernamePattern = r'^[a-zA-Z0-9,.-]+$';
  static const String uppercasePattern = r'[A-Z]';
  static const String numberPattern = r'\d';

  static const String invalidResponse =
      "Invalid response: missing token or user";
}