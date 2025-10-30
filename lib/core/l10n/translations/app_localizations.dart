import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @tellUsAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself!'**
  String get tellUsAboutYourself;

  /// No description provided for @weNeedToKnowYourGender.
  ///
  /// In en, this message translates to:
  /// **'We need to know your gender'**
  String get weNeedToKnowYourGender;

  /// No description provided for @howOldAreYou.
  ///
  /// In en, this message translates to:
  /// **'How old are you?'**
  String get howOldAreYou;

  /// No description provided for @thisHelpsUsCreateYourPersonalizedPlan.
  ///
  /// In en, this message translates to:
  /// **'This helps us create your personalized plan'**
  String get thisHelpsUsCreateYourPersonalizedPlan;

  /// No description provided for @whatIsYourWeight.
  ///
  /// In en, this message translates to:
  /// **'What is your weight?'**
  String get whatIsYourWeight;

  /// No description provided for @whatIsYourHeight.
  ///
  /// In en, this message translates to:
  /// **'What is your height?'**
  String get whatIsYourHeight;

  /// No description provided for @whatIsYourGoal.
  ///
  /// In en, this message translates to:
  /// **'What is your goal?'**
  String get whatIsYourGoal;

  /// No description provided for @gainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get gainWeight;

  /// No description provided for @loseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get loseWeight;

  /// No description provided for @getFitter.
  ///
  /// In en, this message translates to:
  /// **'Get fitter'**
  String get getFitter;

  /// No description provided for @gainMoreFlexible.
  ///
  /// In en, this message translates to:
  /// **'Gain more flexibility'**
  String get gainMoreFlexible;

  /// No description provided for @learnTheBasic.
  ///
  /// In en, this message translates to:
  /// **'Learn the basics'**
  String get learnTheBasic;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'CM'**
  String get cm;

  /// No description provided for @rookie.
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get rookie;

  /// No description provided for @beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get beginner;

  /// No description provided for @intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermediate;

  /// No description provided for @advance.
  ///
  /// In en, this message translates to:
  /// **'Advance'**
  String get advance;

  /// No description provided for @trueBeast.
  ///
  /// In en, this message translates to:
  /// **'True Beast'**
  String get trueBeast;

  /// No description provided for @yourRegularPhysical.
  ///
  /// In en, this message translates to:
  /// **'your regular physical\nactivity level ?'**
  String get yourRegularPhysical;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @level1.
  ///
  /// In en, this message translates to:
  /// **'level1'**
  String get level1;

  /// No description provided for @level2.
  ///
  /// In en, this message translates to:
  /// **'level2'**
  String get level2;

  /// No description provided for @level3.
  ///
  /// In en, this message translates to:
  /// **'level3'**
  String get level3;

  /// No description provided for @level4.
  ///
  /// In en, this message translates to:
  /// **'level4'**
  String get level4;

  /// No description provided for @level5.
  ///
  /// In en, this message translates to:
  /// **'level5'**
  String get level5;

  /// No description provided for @heyThere.
  ///
  /// In en, this message translates to:
  /// **'Hey There'**
  String get heyThere;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'CREATE AN ACCOUNT'**
  String get createAnAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have An Account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @loginRegister.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginRegister;

  /// No description provided for @firtNameRegister.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firtNameRegister;

  /// No description provided for @lastNameRegister.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameRegister;

  /// No description provided for @emailRegister.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailRegister;

  /// No description provided for @passwordRegister.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordRegister;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @noRouteFound.
  ///
  /// In en, this message translates to:
  /// **'No Route Found'**
  String get noRouteFound;

  /// No description provided for @sendOTP.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOTP;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @oTPCode.
  ///
  /// In en, this message translates to:
  /// **'OTP CODE'**
  String get oTPCode;

  /// No description provided for @enterYourOtp.
  ///
  /// In en, this message translates to:
  /// **'Eneter Your OTP Check your Email'**
  String get enterYourOtp;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @didnotReciveCode.
  ///
  /// In en, this message translates to:
  /// **'Didnt Recieve Verification Code?'**
  String get didnotReciveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code?'**
  String get resendCode;

  /// No description provided for @makeSure8Char.
  ///
  /// In en, this message translates to:
  /// **'Make Sure Its 8 Characters Or More'**
  String get makeSure8Char;

  /// No description provided for @createNewPass.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPass;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPass.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPass;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @doIt.
  ///
  /// In en, this message translates to:
  /// **'Do IT'**
  String get doIt;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @onBoardingtitleOne.
  ///
  /// In en, this message translates to:
  /// **'The Price of Excellence\nis Discipline'**
  String get onBoardingtitleOne;

  /// No description provided for @onBoardingtitletwo.
  ///
  /// In en, this message translates to:
  /// **'Fitness Has Never Been So\nMuch Fun'**
  String get onBoardingtitletwo;

  /// No description provided for @onBoardingtitlethree.
  ///
  /// In en, this message translates to:
  /// **'NO MORE EXCUSES\nDo It Now'**
  String get onBoardingtitlethree;

  /// No description provided for @onBoardingdescriptionOne.
  ///
  /// In en, this message translates to:
  /// **'Build a routine that sticks. Personalized plans, daily reminders, and clear tracking small steps, big results'**
  String get onBoardingdescriptionOne;

  /// No description provided for @onBoardingdescriptionTwo.
  ///
  /// In en, this message translates to:
  /// **'Make fitness a game. Quick workouts, challenges, and friend leaderboards keep you moving and coming back'**
  String get onBoardingdescriptionTwo;

  /// No description provided for @onBoardingdescriptionThree.
  ///
  /// In en, this message translates to:
  /// **'Busy day? No problem. Train anywhere in minutes and watch your progress climb start today'**
  String get onBoardingdescriptionThree;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailNotValid.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get emailNotValid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUppercase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumber;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @usernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// No description provided for @usernameNotValid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid username'**
  String get usernameNotValid;

  /// No description provided for @fullnameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullnameRequired;

  /// No description provided for @fullnameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Full name must be at least 3 characters long'**
  String get fullnameMinLength;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @phoneNumbersOnly.
  ///
  /// In en, this message translates to:
  /// **'Enter numbers only'**
  String get phoneNumbersOnly;

  /// No description provided for @phoneLength.
  ///
  /// In en, this message translates to:
  /// **'Value must be 11 digits after country code'**
  String get phoneLength;

  /// No description provided for @numberRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get numberRequired;

  /// No description provided for @numberOnly.
  ///
  /// In en, this message translates to:
  /// **'Enter numbers only'**
  String get numberOnly;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @chatAi.
  ///
  /// In en, this message translates to:
  /// **'chat bot'**
  String get chatAi;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful ✔︎'**
  String get loginSuccess;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgetPass.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgetPass;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get welcomeBack;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get doNotHaveAccount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
