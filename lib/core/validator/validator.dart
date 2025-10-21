import 'package:flutter/material.dart';
import 'package:fitness/core/extension/app_localization_extension.dart';
import 'package:fitness/core/constants/constants.dart';

class Validator {
  Validator._();

  static String? validateEmail(BuildContext context, String? val) {
    if (val == null || val.trim().isEmpty) {
      return context.loc.emailRequired;
    } else if (!RegExp(Constants.emailPattern).hasMatch(val)) {
      return context.loc.emailNotValid;
    } else {
      return null;
    }
  }

  static String? validatePassword(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.loc.passwordRequired;
    }

    if (val.length < 6) {
      return context.loc.passwordMinLength;
    }

    if (!RegExp(Constants.uppercasePattern).hasMatch(val)) {
      return context.loc.passwordUppercase;
    }

    if (!RegExp(Constants.numberPattern).hasMatch(val)) {
      return context.loc.passwordNumber;
    }
    return null;
  }

  static String? validateConfirmPassword(
      BuildContext context, String? val, String? password) {
    if (val == null || val.isEmpty) {
      return context.loc.fieldRequired;
    } else if (val != password) {
      return context.loc.passwordsNotMatch;
    } else {
      return null;
    }
  }

  static String? validateUsername(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.loc.usernameRequired;
    } else if (!RegExp(Constants.usernamePattern).hasMatch(val)) {
      return context.loc.usernameNotValid;
    } else {
      return null;
    }
  }

  static String? validateFullName(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.loc.fullnameRequired;
    }
    if (val.trim().length < 3) {
      return context.loc.fullnameMinLength;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.loc.phoneRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return context.loc.phoneNumbersOnly;
    } else if (val.trim().length != 13) {
      return context.loc.phoneLength;
    } else {
      return null;
    }
  }

  static String? validateNumber(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return context.loc.numberRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return context.loc.numberOnly;
    } else {
      return null;
    }
  }
}
