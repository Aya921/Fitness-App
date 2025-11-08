abstract class Constants {
  static const String enLocal = "en";
  static const String arLocal = "ar";
  static const String contentType = "content-Type";
  static const String appJson = "application/json";
  static const String next = "Next";
  static const String skip = "Skip";
  static const String doIt = "Do IT";
  static const String noResponseReceivedMessage = "noResponseReceivedMessage";
  static const String anUnknownErrorOccurred = "anUnknownErrorOccurred";
  static const String email = "email";
  static const String password = "password";
  static const String error = "error";
  static const String message = "message";
  static const String workouts = "Workouts";
  static const String titleOnBoarding = "the price of excellent \n is discipline";
  static const String titleTwoBoarding = "Fitness has never been so \n much fun";
  static const String titleThreeBoarding = "NO MORE EXCUSES \n Do It Now";
  static const String descriptionOnBoarding = "Lorem ipsum dolor sit amet consectetur. Eu urna ut gravida quis id pretium purus. Mauris massa";
 static const String getMealsDetailsQuery = "i";
 static const String invalidUrl = "Invalid YouTube URL";


   // 🔸 Validation patterns
  static const String emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static const String uppercasePattern = r'(?=.*[A-Z])';

 
  static const String lowercasePattern = r'(?=.*[a-z])';


  static const String numberPattern = r'(?=.*[0-9])';


  static const String specialCharPattern = r'(?=.*[#?!@$%^&*-])';


  static const String lengthPattern = r'.{8,}';

  static const String passwordPattern =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[#?!@$%^&*-]).{8,}$';

  static const String invalidResponse =
      "Invalid response: missing token or user";

        static const String usernamePattern = r'^[a-zA-Z0-9,.-]+$';

  static const String usersCollection = "users";
  static const String conversationsCollection = "conversations";
  static const String messagesCollection = "messages";

  static const String fieldText = "text";
  static const String sender = "sender";
  static const String fieldStartedAt= "startedAt";
  static const String fieldTitle = "title";

  static const String defaultConversationTitle = "Untitled";
  static const String senderUser = "user";
  static const String senderModel = "model";
  static const String id = "id";

  static const String gemeniKey="AIzaSyBAUlexPzTGncesKwuwgr-viaODCIa7eMY";
  static const String gemeniModel ="gemini-1.5-flash";
  static const String fitnessPrefix = """
You are **SmartCoach**, a world-class AI fitness & nutrition coach.  
Your expertise covers:

- **Custom workout plans** (strength, hypertrophy, fat-loss, endurance, mobility).
- **Science-based nutrition** (macros, meal timing, hydration, supplements).
- **Progress tracking** – adjust plans weekly based on user feedback.
- **Form & safety** – always give clear sets × reps, rest, and execution tips.
- **Motivation** – keep the tone upbeat, encouraging, and goal-oriented.

**Rules**:
1. Respond **only in English**.
2. Use the user’s name (if provided) naturally.
3. For every exercise request, output:
   - Exercise name
   - Sets × Reps (or time)
   - Rest between sets
   - Key form cue
4. If the user asks for a meal plan, include calories/macros and a simple grocery list.
5. Never give medical advice; suggest consulting a doctor when appropriate.
6. Start the very first reply with an energetic welcome.

Example welcome (first message only):
"Hey {userName}! Ready to crush your goals? Tell me your stats and target, and I’ll build you a tailor-made plan right now!
""";
  static const String promptFallback = """
Oops! I couldn’t generate a proper response right now 💭  
Please try asking in a different way, or check your connection.
""";


}