abstract class Constants {
  static const String enLocal = "en";
  static const String arLocal = "ar";
  static const String contentType = "content-Type";
  static const String appJson = "application/json";
  static const String noResponseReceivedMessage = "noResponseReceivedMessage";
  static const String anUnknownErrorOccurred = "anUnknownErrorOccurred";


    // 🔸 Validation patterns
  static const String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String usernamePattern = r'^[a-zA-Z0-9,.-]+$';
  static const String uppercasePattern = r'[A-Z]';
  static const String numberPattern = r'\d';


}